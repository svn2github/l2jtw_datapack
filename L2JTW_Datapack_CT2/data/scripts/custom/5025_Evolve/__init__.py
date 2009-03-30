import sys
from net.sf.l2j.gameserver.model.quest        import State
from net.sf.l2j.gameserver.model.quest        import QuestState
from net.sf.l2j.gameserver.model.quest.jython import QuestJython as JQuest

qn = "5025_Evolve"

#Minimum pet level in order to evolve
WOLF_MIN_LEVEL    = 55
GREATW_MIN_LEVEL  = 70
BABY_MIN_LEVEL    = 55
STRIDER_MIN_LEVEL = 55

#Maximum distance allowed between pet and owner
MAX_DISTANCE = 100

#Messages
default = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
error_1 = "<html><body><br>為了進化寵物，必須召喚該寵物並將牠帶到我附近好讓我看清楚。<br>若召喚毫不相干的寵物或距離太遠，就無法為您進化。<br>而且，寵物的等級也要達到一定的程度才行。</body></html>"
error_2 = "<html><body><br>您沒有可進化的寵物啊。至少要有一個寵物，這樣我才能來幫您進化寵物吧？</body></html>"
error_3 = "<html><body><br>您必須召喚該寵物，並將牠帶到我附近，好讓我看清楚。</body></html>"
error_lvl_wolf = "<html><body><br>您的狼等級尚未達到"+str(WOLF_MIN_LEVEL)+"，所以無法進化。</body></html>"
error_lvl_greatw = "<html><body><br>您的黑鬃狼等級尚未達到"+str(GREATW_MIN_LEVEL)+"，所以無法進化。</body></html>"
error_lvl_fenrir = "<html><body><br>您的座狼等級尚未達到"+str(GREATW_MIN_LEVEL)+"，所以無法進化。</body></html>"
error_lvl_baby = "<html><body><br>您的小寵物等級尚未達到"+str(BABY_MIN_LEVEL)+"，所以無法進化。</body></html>"
error_lvl_strider = "<html><body><br>您的座龍等級尚未達到"+str(STRIDER_MIN_LEVEL)+"，所以無法進化。</body></html>"
end_msg = "<html><body><br>呼~真辛苦的工作。<br>已經將您的寵物進化，請好好欣賞您的新寵物吧。</body></html>"

NPCSCH = [35440,35442,35444,35446,35448,35450,35567,35569,35571,35573,35575,35577,35579]

#Items
WOLF_COLLAR           = 2375  # 狼項鍊
GREAT_WOLF_NECK       = 9882  # 黑鬃狼項鍊
FENRIR_NECK           = 10426 # 座狼項鍊
GREAT_SNOW_WOLF_NECK  = 10307 # 白鬃狼項鍊
SNOW_FENRIR_NECK      = 10611 # 白座狼項鍊
BABY_BUFFALO_PAN      = 6648  # 小野牛之笛
BABY_KOOK_OCARINA     = 6650  # 小笑翠鳥之笛
BABY_COUGAR_CHIME     = 6649  # 小老虎之鐘
IMPROVED_BUFFALO_PAN  = 10311 # 改良型野牛之笛
IMPROVED_KOOK_OCARINA = 10313 # 改良型老虎之鐘
IMPROVED_COUGAR_CHIME = 10312 # 改良型笑翠鳥之笛
WSTRIDER_BUGLE        = 4422  # 風龍號角
SSTRIDER_BUGLE        = 4423  # 星龍號角
TSTRIDER_BUGLE        = 4424  # 黃昏龍號角
RED_WSTRIDER_BUGLE    = 10308 # 赤紅風龍號角
RED_SSTRIDER_BUGLE    = 10309 # 赤紅星龍號角
RED_TSTRIDER_BUGLE    = 10310 # 赤紅黃昏龍號角

#Pets
WOLF     = 12077 # 狼
GREATW   = 16025 # 黑鬃狼
FENRIR   = 16041 # 座狼
SFENRIR  = 16042 # 白座狼
GREATSW  = 16037 # 白鬃狼
BABYS    = [12780,12781,12782] # 小野牛、小笑翠鳥、小老虎
WSTRIDER = 12526 # 風座龍
SSTRIDER = 12527 # 星座龍
TSTRIDER = 12528 # 黃昏座龍

UPDATE_CONTROL_ITEMS = { 
			WOLF_COLLAR:GREAT_WOLF_NECK,
			GREAT_WOLF_NECK:FENRIR_NECK,
			BABY_BUFFALO_PAN:IMPROVED_BUFFALO_PAN,
			BABY_KOOK_OCARINA:IMPROVED_KOOK_OCARINA,
			BABY_COUGAR_CHIME:IMPROVED_COUGAR_CHIME,
			GREAT_SNOW_WOLF_NECK:SNOW_FENRIR_NECK
			}

EXCHANGE_CONTROL_ITEMS = {
			GREAT_WOLF_NECK:GREAT_SNOW_WOLF_NECK,
			FENRIR_NECK:SNOW_FENRIR_NECK,
			WSTRIDER_BUGLE:RED_WSTRIDER_BUGLE,
			SSTRIDER_BUGLE:RED_SSTRIDER_BUGLE,
			TSTRIDER_BUGLE:RED_TSTRIDER_BUGLE
			}

def get_control_item(st) :
  item = st.getPlayer().getPet().getControlItemId()
  if st.getState() == State.CREATED :
    st.set("item",str(item))
  else :
    if st.getInt("item") != item :
      item = 0
  return item  

def get_distance(player) :
  is_far = False
  if abs(player.getPet().getX() - player.getX()) > MAX_DISTANCE :
    is_far = True
  if abs(player.getPet().getY() - player.getY()) > MAX_DISTANCE :
    is_far = True
  if abs(player.getPet().getZ() - player.getZ()) > MAX_DISTANCE :
    is_far = True
  return is_far

class Quest (JQuest) :

 def __init__(self, id, name, descr): 
   JQuest.__init__(self, id, name, descr)

 def onEvent(self, event, st) :
   player = st.getPlayer()
   if event == "wolf" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [WOLF] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < WOLF_MIN_LEVEL :
       htmltext = error_lvl_wolf
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = UPDATE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "greatw" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [GREATW] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < GREATW_MIN_LEVEL :
       htmltext = error_lvl_greatw
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = UPDATE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "baby" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in BABYS :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < BABY_MIN_LEVEL :
       htmltext = error_lvl_baby
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = UPDATE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "greatsw" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [GREATW] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < WOLF_MIN_LEVEL :
       htmltext = error_lvl_wolf
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = EXCHANGE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "fenrir" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [FENRIR] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < GREATW_MIN_LEVEL :
       htmltext = error_lvl_fenrir
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = EXCHANGE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "wstrider" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [WSTRIDER] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < STRIDER_MIN_LEVEL :
       htmltext = error_lvl_strider
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = EXCHANGE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "sstrider" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [SSTRIDER] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < STRIDER_MIN_LEVEL :
       htmltext = error_lvl_strider
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = EXCHANGE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")
   elif event == "tstrider" :
     if player.getPet() == None :
       htmltext = error_1
       st.exitQuest(1)
     elif player.getPet().getTemplate().npcId not in [TSTRIDER] :
       htmltext = error_2
       st.exitQuest(1)
     elif player.getPet().getLevel() < STRIDER_MIN_LEVEL :
       htmltext = error_lvl_strider
       st.exitQuest(1)
     elif get_distance(player) :
       htmltext = error_3
       st.exitQuest(1)
     elif get_control_item(st) == 0 :
       htmltext = error_2
       st.exitQuest(1)
     else :
       htmltext = end_msg
       item = EXCHANGE_CONTROL_ITEMS[player.getInventory().getItemByObjectId(player.getPet().getControlItemId()).getItemId()]
       player.getPet().deleteMe(player) #both despawn pet and delete controlitem
       st.giveItems(item, 1)
       st.exitQuest(1)
       st.playSound("ItemSound.quest_finish")                                 
   return htmltext

 def onTalk(self, npc, player):
   htmltext = default
   st = player.getQuestState(qn)
   if not st : return htmltext
   htmltext = "Chamberlain.htm"
   return htmltext

QUEST       = Quest(5025, qn, "Custom")

for i in NPCSCH:
   QUEST.addStartNpc(i)
   QUEST.addTalkId(i)