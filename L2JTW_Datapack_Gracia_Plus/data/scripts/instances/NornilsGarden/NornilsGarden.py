# Update by pmq 25-09-2010

import sys
from com.l2jserver.gameserver.datatables            import SkillTable
from com.l2jserver.gameserver.instancemanager       import InstanceManager
from com.l2jserver.gameserver.model.actor.instance  import L2PcInstance
from com.l2jserver.gameserver.model.entity          import Instance
from com.l2jserver.gameserver.model.quest           import State
from com.l2jserver.gameserver.model.quest           import QuestState
from com.l2jserver.gameserver.model.quest.jython    import QuestJython as JQuest
from com.l2jserver.gameserver.network               import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets import NpcSay
from com.l2jserver.gameserver.network.serverpackets import SystemMessage
from com.l2jserver.gameserver.network.serverpackets import MagicSkillUse
from com.l2jserver.gameserver.datatables            import ItemTable
from com.l2jserver.gameserver.model                 import L2ItemInstance
from com.l2jserver.gameserver.model.itemcontainer   import PcInventory
from com.l2jserver.gameserver.network.serverpackets import InventoryUpdate
from com.l2jserver.gameserver.network.serverpackets import ExShowScreenMessage

#SKILL|DOOR NAME|     |DOOR ID||OPEN DOOR KEY
#     戰士之門         16200001
#2343 闇天使之門       16200002 闇天使之門的鑰匙
#2346 斯比裘拉之門     16200003 斯比裘拉之門的鑰匙
#     中間門           16200004
#2344 紀錄之門         16200005 紀錄之門的鑰匙
#2350 凱特奈特之門     16200006 鑰匙 雷歐波爾德
#2347 哈爾卡凱梅德之門 16200007 鑰匙 諸天之上
#2348 羅丹彼裘拉之門   16200008 鑰匙 弗萊格拉克
#2345 觀察之門         16200009 觀察之門的鑰匙
#2349 亞爾比泰魯之門   16200010 亞爾比泰魯之門的鑰匙
#2351 預測之門         16200011 預測之門的鑰匙
#2352                  1        諾爾妮之門的鑰匙
#2353                  1        諾爾妮之力
#                      16200012 大空洞之門
#                      16200013 暗門
#                      16200014 古代之門
#                      16200015 現在之門
#                      16200016 未來之門
#                      16200017 橋
#                      16200018 橋
#                      16200019 橋
#                      16200023 門
#                      16200024 門
#                      16200025 門
#ITEM
#9703	闇天使之門的鑰匙     可打開闇天使之門的鑰匙。
#9704	紀錄之門的鑰匙       可打開紀錄之門的鑰匙。
#9705	觀察之門的鑰匙       可打開觀察之門的鑰匙。
#9706	斯比裘拉之門的鑰匙   可打開斯比裘拉之門的鑰匙。
#9707	鑰匙-諸天之上        可打開哈爾卡凱梅德之門的鑰匙。
#9708	鑰匙-佛拉赫爾哈      可打開羅丹彼裘拉之門的鑰匙。
#9709	亞爾比泰魯之門的鑰匙 可打開亞爾比泰魯之門的鑰匙。
#9710	鑰匙-雷歐波爾德      可打開凱特奈特之門的鑰匙。
#9711	預測之門的鑰匙       可打開預測之門的鑰匙。
#9712	大空洞之門的鑰匙     可打開大空洞之門的鑰匙。
#9713	諾爾妮之力           在庭園尋找紅色花來使用。

qn = "NornilsGarden"

InstanceTemplate = "NGarden.xml"
Class = [0, 10, 18, 25, 31, 38, 44, 49, 53, 123, 124]

dataIndex = 0

def dropItem(player,npc,itemId,count):
    ditem = ItemTable.getInstance().createItem("Loot", itemId, count, player)
    ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ()); 

def getGardenIndex(level):
    if level == 19:
        return 0

def isWithinLevel(player):
     if player.getLevel() > 21:
         return False
     if player.getLevel() < 17:
         return False
     return True

def checkPrimaryConditions(player):
    if not player.getParty():
        return False
    return True

def checkNewInstanceConditions(player):
    party = player.getParty()
    if party == None:
        return True
    if not party.isLeader(player):
        player.sendPacket(SystemMessage(2185))
        return False
    for partyMember in party.getPartyMembers().toArray():
        if not partyMember.isInsideRadius(player, 500, False, False):
            sm = SystemMessage(2096)
            sm.addCharName(partyMember)
            player.sendPacket(sm)
            return False
    for partyMember in party.getPartyMembers().toArray():
        if not isWithinLevel(partyMember):
            sm = SystemMessage(2097)
            sm.addCharName(partyMember)
            player.sendPacket(sm)
            return False
    for partyMember in party.getPartyMembers().toArray():
        if not partyMember.getClassId().getId() in Class:
            sm = SystemMessage(2098)
            sm.addCharName(partyMember)
            player.sendPacket(sm)
            return False
    return True

def getExistingInstanceId(player):
    instanceId = 0
    party = player.getParty()
    if party == None:
        return 0
    for partyMember in party.getPartyMembers().toArray():
        if partyMember.getInstanceId() != 0:
            instanceId = partyMember.getInstanceId()
    return instanceId

def teleportPlayer(self, player, teleto):
    player.setInstanceId(teleto.instanceId)
    player.teleToLocation(teleto.x, teleto.y, teleto.z)
    pet = player.getPet()
    if pet != None :
        pet.setInstanceId(teleto.instanceId)
        pet.teleToLocation(teleto.x, teleto.y, teleto.z)
    return

def enterInstance(self,player,template,tele,quest):
    instanceId = getExistingInstanceId(player)
    if instanceId == 0:
        if not checkNewInstanceConditions(player):
            return
        instanceId = InstanceManager.getInstance().createDynamicInstance(template)    
        if not self.worlds.has_key(instanceId):
            world = PyObject()
            world.rewarded = []
            world.instanceId = instanceId
            self.worlds[instanceId] = world
            self.world_ids.append(instanceId)
            self.currentWorld = instanceId
            #openDoor(16200001, world.instanceId)
            #openDoor(16200013, world.instanceId)
            #openDoor(16200017, world.instanceId)
            #openDoor(16200018, world.instanceId)
            #openDoor(16200019, world.instanceId)
            #openDoor(16200023, world.instanceId)
            #openDoor(16200023, world.instanceId)
            #openDoor(16200024, world.instanceId)
            #openDoor(16200025, world.instanceId)
            player.stopAllEffects()
            tele.instanceId = instanceId
            teleportPlayer(self, player, tele)
            party = player.getParty()
            if party != None:
                for partyMember in party.getPartyMembers().toArray():
                    partyMember.stopAllEffects()
                    teleportPlayer(self, partyMember, tele)
                    world.status = 1
    else:
        foundworld = False
        for worldid in self.world_ids:
            if worldid == instanceId:
                foundworld = True
        if not foundworld:
            player.sendPacket(SystemMessage.sendString("Your Party Members are in another Instance."))    
            return
        instanceObj = InstanceManager.getInstance().getInstance(instanceId)
        if instanceObj.getCountPlayers() >= PartySize[dataIndex]:
            player.sendPacket(SystemMessage(2112))
            return
        tele.instanceId = instanceId
        teleportPlayer(self, player, tele)
    return

def exitInstance(player, tele):
    player.setInstanceId(0)
    player.teleToLocation(tele.x, tele.y, tele.z)
    pet = player.getPet()
    if pet != None :
        pet.setInstanceId(0)
        pet.teleToLocation(tele.x, tele.y, tele.z)

class PyObject:
    pass

def openDoor(doorId, instanceId):
    for door in InstanceManager.getInstance().getInstance(instanceId).getDoors():
        if door.getDoorId() == doorId:
            door.openMe()

class NornilsGarden(JQuest) :

    def __init__(self, id, name, desc):
        JQuest.__init__(self, id, name, desc)
        self.worlds = {}
        self.world_ids = []
        self.currentWorld = 0

    def onAdvEvent (self,event,npc,player) :
        htmltext = event
        st = player.getQuestState(qn)
        if not st : return

        passwrd = st.getInt("pass")

        if event == "32260-02.htm" :
            st.set("pass","0")
        elif event == "32260-03a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32260-03.htm"
        elif event == "32260-04a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32260-04.htm"
        elif event == "32260-05a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32260-05.htm"
        elif event == "32260-06a.htm" :
            st.set("pass",str(passwrd+1))
            world = self.worlds[player.getInstanceId()]
            openDoor(16200014, world.instanceId) # 過去之門
            player.sendPacket(ExShowScreenMessage("被掩蓋的創造主...",30000))
            htmltext = "被掩蓋的創造主..."
            if st.getInt("pass") != 4:
                return "32260-06.htm"
        elif event == "32261-02.htm" :
            st.set("pass","0")
        elif event == "32261-03a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32261-03.htm"
        elif event == "32261-04a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32261-04.htm"
        elif event == "32261-05a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32261-05.htm"
        elif event == "32261-06a.htm" :
            st.set("pass",str(passwrd+1))
            world = self.worlds[player.getInstanceId()]
            openDoor(16200015, world.instanceId) # 現在之門
            player.sendPacket(ExShowScreenMessage("應封印起來的種族",30000))
            htmltext = "應封印起來的種族"
            if st.getInt("pass") != 4:
                return "32261-06.htm"
        elif event == "32262-02.htm" :
            st.set("pass","0")
        elif event == "32262-03a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32262-03.htm"
        elif event == "32262-04a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32262-04.htm"
        elif event == "32262-05a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32262-05.htm"
        elif event == "32262-06a.htm" :
            st.set("pass",str(passwrd+1))
            htmltext = "32262-06.htm"
        elif event == "32262-07a.htm" :
            st.set("pass",str(passwrd+1))
            world = self.worlds[player.getInstanceId()]
            openDoor(16200016, world.instanceId) # 未來之門
            player.sendPacket(ExShowScreenMessage("渾沌的未來...",30000))
            htmltext = "渾沌的未來..."
            if st.getInt("pass") != 5:
                return "32262-07.htm"
        return htmltext

    def onTalk (self, npc, player):
        npcId = npc.getNpcId()
        st = player.getQuestState(qn)
        if not st :
            st = self.newQuestState(player)
        if npcId == 32330 :
            party = player.getParty()
            if not party :
                htmltext = "<html><body>庭園警衛兵：<br>首先你到某處去尋找能夠掩護你弱點的隊友們吧。只有與他們在一起時，才能克服這裡的試練。</body></html>"
                return htmltext
            if player.getLevel() < 17 or player.getLevel() > 21 :
                htmltext = "<html><body>庭園警衛兵：<br>你們尚未準備妥當。備齊一切所需後再回來吧。<br>（隊員等級不符。）</body></html>"
                return htmltext
            if not checkPrimaryConditions(player):
                htmltext = "<html><body>庭園警衛兵：<br>現在就先等等吧。還不是你們能夠挑戰的時候。<br>（立即地區進入失敗。）</body></html>"
                return htmltext
            for partyMember in party.getPartyMembers().toArray():
                st2 = partyMember.getQuestState("179_IntoTheLargeCavern")
                if not st2 and partyMember.getRace().ordinal() == 5 :
                    htmltext = "<html><body>庭園警衛兵：<br>你們尚未準備妥當。備齊一切所需後再回來吧。<br>（隊員闇天使沒有執行任務。）</body></html>"
                    return htmltext
            for partyMember in party.getPartyMembers().toArray():
                st2 = partyMember.getQuestState("179_IntoTheLargeCavern")
                if st2 and st2.getState() == State.COMPLETED:
                    htmltext = "<html><body>庭園警衛兵：<br>你們尚未準備妥當。備齊一切所需後再回來吧。<br>（隊員闇天使已完成這任務。）</body></html>"
                    return htmltext
            tele = PyObject()
            tele.x = -111183
            tele.y = 74553
            tele.z = -12432
            enterInstance(self, player, "NGarden.xml", tele, self)
            party = player.getParty()
            if party :
                for partyMember in party.getPartyMembers().toArray() :
                    st = partyMember.getQuestState(qn)
                    if not st : st = self.newQuestState(partyMember)
        world = self.worlds[player.getInstanceId()]
        if world.status >= 0 :
            st2 = player.getQuestState("179_IntoTheLargeCavern")
            if st2 :
                if npcId == 32260 :
                    htmltext = "32260-01.htm"
                    return htmltext
                elif npcId == 32261 :
                    htmltext = "32261-01.htm"
                    return htmltext
                elif npcId == 32262 :
                    htmltext = "32262-01.htm"
                    return htmltext
            else :
                return "<html><body>目前沒有執行任務，或條件不符。</body></html>"
        return ""

    def onAttack(self, npc, player, damage, isPet, skill):
        npcId = npc.getNpcId()
        if self.worlds.has_key(npc.getInstanceId()):
            world = self.worlds[npc.getInstanceId()]
            if npcId == 18347:
                if world.status == 1:
                    world.status = 2
                    newpath = self.addSpawn(18349, -110016, 74512, -12533, 0, False, 0, False, npc.getInstanceId())
                    newpath = self.addSpawn(18348, -109729, 74913, -12533, 0, False, 0, False, npc.getInstanceId())
                    newpath = self.addSpawn(18348, -109981, 74899, -12533, 0, False, 0, False, npc.getInstanceId())
                    openDoor(16200001, world.instanceId)
        return

    def onAggroRangeEnter(self, npc, player, isPet) : 
        if self.worlds.has_key(npc.getInstanceId()):
            world = self.worlds[npc.getInstanceId()]
            if npc.getNpcId() == 18437:
                npc.getAggroList().remove(player)
                npc.setTarget(player)
                npc.doCast(SkillTable.getInstance().getInfo(4322,1))
                npc.doCast(SkillTable.getInstance().getInfo(4327,1))
                npc.doCast(SkillTable.getInstance().getInfo(4329,1))
                npc.doCast(SkillTable.getInstance().getInfo(4324,1))
        return

    def onKill(self,npc,player,isPet):
        npcId = npc.getNpcId()
        objId = npc.getObjectId()
        if self.worlds.has_key(npc.getInstanceId()):
            world = self.worlds[npc.getInstanceId()]
            if npcId == 25528 :
                npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), "真有實力。到了這個程度，那我也就認同你達到了可以通過我的水準。拿著鑰匙離開此地吧。"))
                dropItem(player,npc,9712,1)
        return

QUEST = NornilsGarden(-1, qn, "instances")

QUEST.addStartNpc(32330)
QUEST.addTalkId(32260)
QUEST.addTalkId(32261)
QUEST.addTalkId(32262)
QUEST.addTalkId(32330)
QUEST.addAttackId(18347)
QUEST.addAggroRangeEnterId(18437)

QUEST.addKillId(25528)