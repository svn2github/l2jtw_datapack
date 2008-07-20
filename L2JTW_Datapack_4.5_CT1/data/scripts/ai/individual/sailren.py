# By L2J_JP SANDMAN

import sys
from net.sf.l2j.gameserver.model.quest import State
from net.sf.l2j.gameserver.model.quest import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest
from net.sf.l2j.gameserver.serverpackets import SocialAction
from net.sf.l2j.gameserver.instancemanager import SailrenManager
from net.sf.l2j.gameserver.instancemanager import GrandBossManager

#NPC
STATUE          =   32109   #ƒV[ƒŒƒ“‚ÌÎ‘œ/Shilen's Stone Statue
VELOCIRAPTOR    =   22218   #ƒ”ƒFƒƒLƒ‰ƒvƒgƒ‹/Velociraptor
PTEROSAUR       =   22199   #ƒ‰ƒ“ƒtƒHƒŠƒ“ƒNƒX/Pterosaur
TYRANNOSAURUS   =   22217   #ƒeƒBƒ‰ƒmƒUƒEƒ‹ƒX/Tyrannosaurus
SAILREN         =   29065   #ƒTƒCƒŒƒ“/Sailren

#ITEM
GAZKH   =   8784    #ƒJƒWƒN/Gazkh

# Boss: sailren
class sailren (JQuest):

  def __init__(self,id,name,descr): JQuest.__init__(self,id,name,descr)

  def onTalk (self,npc,player):
    st = player.getQuestState("sailren")
    if not st : return "<html><head><body>½Ğ°İ§A§ä§Ú¦³¬Æ»ò¨Æ±¡?</body></html>"
    npcId = npc.getNpcId()
    if npcId == STATUE :
      if player.isFlying() :
        return "<html><body>®uµY¸t¹³¡G<br><font color=\"LEVEL\">ÃM­¼­¸Àsª¬ºAµLªk¶i¤J¡C</font></body></html>"
        #return "<html><body>Shilen's Stone Statue:<br>You may not enter while flying a wyvern</body></html>"
      if st.getQuestItemsCount(GAZKH) :
        ENTRY_SATAT = SailrenManager.getInstance().canIntoSailrenLair(player)
        if ENTRY_SATAT == 1 or ENTRY_SATAT == 2 :
          st.exitQuest(1)
          return "<html><body>®uµY¸t¹³¡G<br><font color=\"LEVEL\">¤w¸g¦³¤H¶i¤JÁÉº¸Äõ±_¥Ş¡C¦b¥L­Ì»PÁÉº¸Äõªº¹ï¾Ôµ²§ô¤§«e¤£¯àÅı§A­Ì¶i¤J¡C</font></body></html>"
          #return "<html><head><body>Shilen's Stone Statue:<br>Another adventurers have already fought against the sailren. Do not obstruct them.</body></html>"
        elif ENTRY_SATAT == 3 :
          st.exitQuest(1)
          return "<html><body>®uµY¸t¹³¡G<br>µ¥µ¥¡C§A¦ü¥G¤£¬O¬ù©w­n¦b³o¾Ô°«°µ¥ı¾Wªº¤H°Ú¡C§Ú¥u·|¹ï¤@­Ó¶¤¥îªº¶¤¥î¶¤ªø¥´¶}³q©¹ÁÉº¸Äõ¤s¹ë¤§ªù¡A¦pªG§A·Q¶Ç°e´N±N¶¤¥îªº¶¤¥î¶¤ªø±a¨Ó¡A©ÎªÌ§A¤]¥i¥H±o¨ì¶¤¥î¶¤ªø¸ê®æ¦A¦^¨Ó¡C</body></html>"
          #return "<html><head><body>Shilen's Stone Statue:<br>The sailren is very powerful now. It is not possible to enter the inside.</body></html>"
        elif ENTRY_SATAT == 4 :
          st.exitQuest(1)
          return "<html><head><body>®uµY¸t¹³¡G<br>·Q¤@­Ó¤H«Ê¦LÁÉº¸Äõ? §A§O·Q¤F! ½Ğ§â¶¤¥î±a¹L¨Ó§a¡C</body></html>"
          #return "<html><head><body>Shilen's Stone Statue:<br>You seal the sailren alone? You should not do so! Bring the companion.</body></html>"
        elif ENTRY_SATAT == 0 :
          st.takeItems(GAZKH,1)
          SailrenManager.getInstance().setSailrenSpawnTask(VELOCIRAPTOR)
          SailrenManager.getInstance().entryToSailrenLair(player)
          return "<html><head><body>®uµY¸t¹³¡G<br>½Ğ¥Î§Aªº§Ş¥©§âÁÉº¸Äõµ¹«Ê¦L¡C</body></html>"
          #return "<html><head><body>Shilen's Stone Statue:<br>Please seal the sailren by your ability.</body></html>"
      else :
        st.exitQuest(1)
        return "<html><head><body>®uµY¸t¹³¡G<br><font color=LEVEL>¥d¯÷§J</font>¬O«Ê¦LÁÉº¸Äõ¥²³Æªºª««~¡C</body></html>"
        #return "<html><head><body>Shilen's Stone Statue:<br><font color=LEVEL>Gazkh</font> is necessary for seal the sailren.</body></html>"

  def onKill (self,npc,player,isPet):
    st = player.getQuestState("sailren")
    if not st: return
    if GrandBossManager.getInstance().checkIfInZone("LairofSailren", player) :
      npcId = npc.getNpcId()
      if npcId == VELOCIRAPTOR :
        SailrenManager.getInstance().setSailrenSpawnTask(PTEROSAUR)
      elif npcId == PTEROSAUR :
        SailrenManager.getInstance().setSailrenSpawnTask(TYRANNOSAURUS)
      elif npcId == TYRANNOSAURUS :
        SailrenManager.getInstance().setSailrenSpawnTask(SAILREN)
      elif npcId == SAILREN :
        SailrenManager.getInstance().setCubeSpawn()
        st.exitQuest(1)
    return

# Quest class and state definition
QUEST = sailren(-1, "sailren", "ai")
# Quest NPC starter initialization
QUEST.addStartNpc(STATUE)
QUEST.addTalkId(STATUE)
QUEST.addKillId(VELOCIRAPTOR)
QUEST.addKillId(PTEROSAUR)
QUEST.addKillId(TYRANNOSAURUS)
QUEST.addKillId(SAILREN)
