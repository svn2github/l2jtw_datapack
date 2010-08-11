# author Korvin
import sys
from com.l2jserver.gameserver.model.actor.instance   import L2PcInstance
from com.l2jserver.gameserver.model.quest            import State
from com.l2jserver.gameserver.model.quest            import QuestState
from com.l2jserver.gameserver.model.quest.jython     import QuestJython as JQuest
from com.l2jserver.gameserver.instancemanager        import InstanceManager
from com.l2jserver.gameserver.model.entity           import Instance
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets  import SystemMessage
from com.l2jserver.util                              import Rnd


qn = "Infinitum"

#Mobs
MFL = [22373,22374,22375,22376,25540,25542]

MOBS = [
[[22373,30],[0]],
[[22373,40],[0]],
[[22373,20],[22374,20]],
[[22373,25],[22374,25]],
[[25540],[-18993,279541,-8260]],
[[22375,30],[0]],
[[22375,20],[22376,20]],
[[22375,25],[22376,25]],
[[22375,30],[22376,30]],
[[25542],[-22206,279497,-8260]]]

#TP
TPS = [
[-19645,277528,-15045],
[-19645,277528,-13378],
[-19645,277528,-11650],
[-19645,277528,-9915],
[-19036,277588,-8260],
[-22852,277502,-15048],
[-22852,277502,-13381],
[-22852,277502,-11650],
[-22852,277502,-9918],
[-22199,277437,-8260]]

FLOORS = [
[-19870,277020,1750,3130,-15045],
[-19870,277020,1750,3130,-13381],
[-19870,277020,1750,3130,-11653],
[-19870,277020,1750,3130,-9925],
[-19870,277020,1750,3130,-8267],
[-23000,277060,1670,3000,-15052],
[-23000,277060,1670,3000,-13381],
[-23000,277060,1670,3000,-11653],
[-23000,277060,1670,3000,-9920],
[-23000,277060,1670,3000,-8260]]

class PyObject :
  pass

def checkCondition(player) :
  party = player.getParty()
  if not party :
    player.sendPacket(SystemMessage(SystemMessageId.NOT_IN_PARTY_CANT_ENTER))
    return False
  if not player.getParty().isLeader(player) :
    player.sendPacket(SystemMessage(SystemMessageId.ONLY_PARTY_LEADER_CAN_ENTER))
    return False
  membersCount = player.getParty().getMemberCount()
  if membersCount < 2 :
    player.sendPacket(SystemMessage(SystemMessageId.PARTY_EXCEEDED_THE_LIMIT_CANT_ENTER))
    return False
  for partyMember in party.getPartyMembers().toArray() :
    if not partyMember.getLevel() >= 78 :
      sm = SystemMessage(SystemMessageId.C1_LEVEL_REQUIREMENT_NOT_SUFFICIENT)
      sm.addCharName(partyMember)
      player.sendPacket(sm)
      return False
  for partyMember in player.getParty().getPartyMembers().toArray() :
    if not partyMember.isInsideRadius(player, 500, False, False) :
      sm = SystemMessage(SystemMessageId.C1_IS_IN_LOCATION_THAT_CANNOT_BE_ENTERED)
      sm.addCharName(partyMember)
      player.sendPacket(sm)
      return False
  return True

def teleportPlayer(self, player, teleto) :
  player.setInstanceId(teleto.instanceId)
  player.teleToLocation(teleto.x, teleto.y, teleto.z)
  pet = player.getPet()
  if pet != None :
    pet.setInstanceId(teleto.instanceId)
    pet.teleToLocation(teleto.x, teleto.y, teleto.z)
  return

def teleportParty(self, player, teleto, out = False) :
  if out : teleto.instanceId = 0
  else : teleto.instanceId = player.getInstanceId()
  if not player.isInParty() : 
    teleportPlayer(self, player, teleto)
    return
  for pm in player.getParty().getPartyMembers() :
    teleportPlayer(self, pm, teleto)

def enterInstance(self, player, template, teleto) :
  instanceId = 0
  if not checkCondition(player) :
    return 0
  party = player.getParty()
  # Check for existing instances of party members
  for partyMember in party.getPartyMembers().toArray() :
    if partyMember.getInstanceId() != 0 :
      instanceId = partyMember.getInstanceId()
  # New instance
  else :
    instanceId = InstanceManager.getInstance().createDynamicInstance(template)
    if not self.worlds.has_key(instanceId) :
      world = PyObject()
      world.instanceId = instanceId
      self.worlds[instanceId] = world
      self.world_ids.append(instanceId)
      print "Tower of Infinity: started " + template + " Instance: " +str(instanceId) + " created by player: " + str(player.getName())
      runFloor(self, world, 0)
    # teleports player
    for partyMember in party.getPartyMembers().toArray() :
      st = partyMember.getQuestState(qn)
      if not st : st = self.newQuestState(partyMember)
      teleto.instanceId = instanceId
      teleportPlayer(self, partyMember, teleto)
    return instanceId
  return instanceId

def runFloor(self, world, floor):
  world.status = floor
  world.FloorSt = {}
  world.FloorSt[floor] = PyObject()
  world.FloorSt[floor].npclist = {}
  if floor in [0,1,2,3,5,6,7,8] :
    i = MOBS[floor][0][1]
    x = FLOORS[floor][0]
    y = FLOORS[floor][1]
    z = FLOORS[floor][4]
    while i > 0 :
      rx = Rnd.get(FLOORS[floor][2])
      ry = Rnd.get(FLOORS[floor][3])
      newNpc = self.addSpawn(MOBS[floor][0][0], x+rx, y+ry, z, 0, False, 0, False, world.instanceId)
      world.FloorSt[floor].npclist[newNpc] = False
      i -= 1
  if floor in [2,3,6,7,8] :
    i = MOBS[floor][1][1]
    x = FLOORS[floor][0]
    y = FLOORS[floor][1]
    z = FLOORS[floor][4]
    while i > 0 :
      rx = Rnd.get(FLOORS[floor][2])
      ry = Rnd.get(FLOORS[floor][3])
      newNpc = self.addSpawn(MOBS[floor][1][0], x+rx, y+ry, z, 0, False, 0, False, world.instanceId)
      world.FloorSt[floor].npclist[newNpc] = False
      i -= 1
  if floor in [4,9] :
    newNpc = self.addSpawn(MOBS[floor][0][0],MOBS[floor][1][0],MOBS[floor][1][1],MOBS[floor][1][2], 0, False, 0, False, world.instanceId)
    world.FloorSt[floor].npclist[newNpc] = False

def checkKillProgress(npc, floor) :
  cont = True
  if floor.npclist.has_key(npc) :
    floor.npclist[npc] = True
  for npc in floor.npclist.keys() :
    if floor.npclist[npc] == False :
      cont = False
  return cont

class Quest (JQuest):
  def __init__(self, id, name, descr) :
    JQuest.__init__(self, id, name, descr)
    self.worlds = {}
    self.world_ids = []

  def onTalk (self,npc,player):
    npcId = npc.getNpcId()
    if npcId == 32302 :
      if not player.getFirstEffect(2357):
        return "<html><body>塞良：<br>將惡魔溫熱的血液噴灑在全身....！</body></html>"
#        if content:
#            content = content.replace("%objectId%", str(player.getTarget().getObjectId()))
#            npcReply = NpcHtmlMessage(5)
#            npcReply.setHtml(content)
#            npcReply.replace("%playername%", player.getName())
#            player.sendPacket(npcReply);
#        return
      tele = PyObject()
      tele.x = -19645
      tele.y = 277528
      tele.z = -15048
      instanceId = enterInstance(self, player, "Infinitum.xml", tele)
      if not instanceId :
        return
      if instanceId == 0 :
        return
    if self.worlds.has_key(npc.getInstanceId()) :
      world = self.worlds[npc.getInstanceId()]
    return

  def onKill(self,npc,player,isPet) :
    npcId = npc.getNpcId()
    if npcId == 25542 :
      tele = PyObject()
      tele.x = 8800
      tele.y = 251652
      tele.z = -2032
      instanceId = player.getInstanceId()
      teleportParty(self, player, tele, True)
      self.world_ids.remove(instanceId)
      self.worlds[instanceId] = None
      return
    if self.worlds.has_key(npc.getInstanceId()) :
      world = self.worlds[npc.getInstanceId()]
      if checkKillProgress(npc,world.FloorSt[world.status]):
        tele = PyObject()
        tele.x = TPS[world.status + 1][0]
        tele.y = TPS[world.status + 1][1]
        tele.z = TPS[world.status + 1][2]
        teleportParty(self,player,tele)
        runFloor(self,world,world.status + 1)
    return

QUEST = Quest(-1, qn, "hellbound")

QUEST.addStartNpc(32302)
for mob in MFL : QUEST.addKillId(mob)