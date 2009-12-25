# By Psycho(killer1888) / L2jFree
# - Pailaka #1: Song of Ice and Fire. Disabled in script.cfg as it still needs core support to forbid the use of the items when player not in Pailaka. 
# - Based on my game experience on Teon, html are 100% offlike (excpet possible mistakes) 
# - Next Pailakas to come when I can control my work, as soon as I have level to play them
# 中文化 pmq
from com.l2jserver.gameserver.datatables             import ItemTable
from com.l2jserver.gameserver.instancemanager        import InstanceManager
from com.l2jserver.gameserver.model.actor            import L2Summon
from com.l2jserver.gameserver.model.entity           import Instance
from com.l2jserver.gameserver.model.quest            import State
from com.l2jserver.gameserver.model.quest            import QuestState
from com.l2jserver.gameserver.model.quest.jython     import QuestJython as JQuest
from com.l2jserver.gameserver.model.actor.instance   import L2PcInstance
from com.l2jserver.gameserver.network                import SystemMessageId
from com.l2jserver.gameserver.network.serverpackets  import CreatureSay
from com.l2jserver.gameserver.network.serverpackets  import MagicSkillUse
from com.l2jserver.gameserver.network.serverpackets  import NpcSay
from com.l2jserver.gameserver.network.serverpackets  import SystemMessage
from com.l2jserver.util                              import Rnd

#128 1  【菲拉卡的嚮導】
#128 2  【水之精華】
#128 3  【劍之強化】
#128 4  【強化精靈之劍】
#128 5  【尋找火之精華】
#128 6  【冰與火之劍】
#128 7  【炎之守門人】
#128 8  【最後的敵人】
#128 9  【崩毀的菲拉卡】

qn = "128_PailakaSongOfIceAndFire"

debug = False

#NPC
ADLER                    = 32497    # 調查官 艾德勒
SINAI                    = 32500    # 調查官 悉奈
INSPECTOR                = 32507    # 神殿的調查官
ADLER2                   = 32510    # 調查官 艾德勒

#MOBs
GARGOS                   = 18607    # 加爾高斯 火的精靈
KINSUS                   = 18608    # 金瑟斯   火的精靈
PAPION                   = 18609    # 帕米恩   水的精靈
HILLAS                   = 18610    # 赫爾勒斯 水的精靈
SW1                      = 18611    # 水的精靈
SW2                      = 18612    # 水的精靈
SW3                      = 18613    # 水的精靈
SF1                      = 18614    # 火的精靈
SF2                      = 18615    # 火的精靈
BLOOM                    = 18616    # 畢羅卡
ADIANTUM                 = 18620    # 埃迪安藤
CRYSTAL_WATER_BOTTLE     = 32492    # 水晶瓶
BURNING_BRAZIER          = 32493    # 燃燒的火爐

#ITEM
PAILAKA_INSTANT_SHIELD   = 13032    # 菲拉卡即時盾
QUICK_HEALING_POTION     = 13033    # 瞬間體力治癒藥水
SWORD                    = 13034    # 精靈之劍
ENHENCED_SWORD           = 13035    # 強化精靈之劍
ENHENCED_SWORD_2         = 13036    # 冰與火之劍
PAILAKA_SOULSHOT_GRADE_D = 13037    # 菲拉卡靈魂彈-D級
WATER_ENHENCER           = 13038    # 水的精華
FIRE_ENHENCER            = 13039    # 火的精華
FIRE_ATTRIBUTE_ENHANCER  = 13040    # 火屬性強化劑
WATER_ATTRIBUTE_ENHANCER = 13041    # 水屬性強化劑
PSOE                     = 13129    # 菲拉卡返回卷軸
BOOK1                    = 13130    # 神殿的祕冊
BOOK2                    = 13131    # 神殿的祕冊
BOOK3                    = 13132    # 神殿的祕冊
BOOK4                    = 13133    # 神殿的祕冊
BOOK5                    = 13134    # 神殿的祕冊
BOOK6                    = 13135    # 神殿的祕冊
BOOK7                    = 13136    # 神殿的祕冊
PAILAKA_EARRING          = 13293    # 菲拉卡耳環
PAILAKA_RING             = 13294    # 菲拉卡戒指

REWARDS1 = [13032,13033,13041]

REWARDS2 = [13032,13033,13040]

RNDCOUNT = [1,2,3,4,5,6,7,8,9]
class PyObject:
    pass

def dropItem(npc,itemId,count):
    ditem = ItemTable.getInstance().createItem("Loot", itemId, count, None)
    ditem.dropMe(npc, npc.getX(), npc.getY(), npc.getZ())

def checkCondition(player):
    party = player.getParty()
    if party:
        player.sendPacket(SystemMessage.sendString("菲拉卡只能由單人挑戰。"))    
        return False
    return True

def teleportplayer(self,player,teleto):
    player.setInstanceId(teleto.instanceId)
    player.teleToLocation(teleto.x, teleto.y, teleto.z)
    pet = player.getPet()
    if pet != None :
        pet.setInstanceId(teleto.instanceId)
        pet.teleToLocation(teleto.x, teleto.y, teleto.z)
    return

def enterInstance(self,player,template,teleto):
    instanceId = 0
    if not checkCondition(player):
        return 0
    # Create instance
    instanceId = InstanceManager.getInstance().createDynamicInstance(template)
    if not self.worlds.has_key(instanceId):
        world = PyObject()
        world.instanceId = instanceId
        self.worlds[instanceId]=world
        self.world_ids.append(instanceId)
        instance = InstanceManager.getInstance().getInstance(instanceId)
        instance.setAllowSummon(False)
        print "菲拉卡-冰與火之歌 (等級 36-42)：" +str(instanceId) + " 創造玩家：" + str(player.getName())
        runStartRoom(self,world)
    # Teleports player
    teleto.instanceId = instanceId
    teleportplayer(self,player,teleto)
    return instanceId

def exitInstance(player,tele):
    player.setInstanceId(0)
    player.teleToLocation(teleto.x, teleto.y, teleto.z)
    pet = player.getPet()
    if pet != None :
        pet.setInstanceId(0)
        pet.teleToLocation(teleto.x, teleto.y, teleto.z)

def runStartRoom(self, world):
    world.status = 0
    world.startRoom = PyObject()
    world.startRoom.npclist = {}
    newNpc = self.addSpawn(32500, -53906, 188200, -4667, 65163, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -54822, 190638, -4480, 50019, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -56005, 190072, -4480, 16383, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55442, 190340, -4480, 38942, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55744, 190698, -4480, 48622, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -55757, 190183, -4480, 35530, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18616, -57316, 190091, -4518, 1405, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -57340, 188371, -4501, 16554, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -57532, 188103, -4501, 9059, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -57417, 188232, -4501, 8789, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -59088, 188565, -4518, 47738, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -59173, 187984, -4518, 61584, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -59361, 188277, -4518, 30750, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -60379, 188255, -4518, 64884, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -60587, 188263, -4517, 64590, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55643, 188438, -4518, 12242, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55720, 188010, -4518, 42065, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -56110, 188291, -4518, 27912, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -55348, 188292, -4518, 32767, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -54435, 188274, -4518, 32132, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -58336, 186101, -4517, 65309, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -58768, 186132, -4524, 242, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -58497, 185367, -4517, 42593, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -58694, 185149, -4529, 33971, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -59089, 185351, -4524, 800, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32507, -57091, 185704, -4518, 32452, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18610, -56171, 185858, -4518, 33735, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18616, -57737, 183541, -4518, 6316, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55479, 183389, -4518, 29376, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -54984, 183585, -4518, 29490, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -55498, 183752, -4518, 27951, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -55224, 183431, -4518, 28717, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55785, 182587, -4518, 17864, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -55778, 181937, -4518, 49172, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -55778, 180662, -4524, 16001, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -55964, 184468, -4518, 64590, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -55661, 184453, -4518, 34065, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -56419, 184457, -4518, 297, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -54966, 181956, -4518, 16737, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -54974, 181264, -4517, 16770, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -54971, 180645, -4524, 16638, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18611, -54905, 184711, -4517, 20288, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -54733, 185187, -4524, 43893, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32492, -54879, 185238, -4524, 48284, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18609, -53863, 181482, -4558, 16696, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -53950, 181300, -4558, 11769, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -53757, 181317, -4558, 18804, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18612, -53861, 181836, -4558, 12803, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18620, -53582, 185022, -4619, 64590, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -53469, 184846, -4630, 64898, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18613, -53417, 185260, -4630, 58498, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32507, -53854, 179303, -4644, 11446, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -55692, 179289, -4818, 359, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -56345, 179394, -4818, 64817, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -56428, 179181, -4818, 62683, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -56768, 179386, -4818, 62400, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18616, -59369, 179177, -4818, 2015, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32507, -59555, 181336, -4818, 61234, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -60178, 181062, -4818, 40747, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -58827, 181340, -4818, 39156, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -59977, 181597, -4819, 53628, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18608, -61415, 181418, -4818, 63852, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -61425, 182635, -4818, 65027, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -61246, 182761, -4818, 52912, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -61921, 182779, -4818, 32047, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -61700, 182440, -4818, 62310, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -62650, 182217, -4818, 49511, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -62648, 181411, -4818, 49231, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -62648, 181033, -4818, 14568, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -62647, 180070, -4818, 49207, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -61654, 179659, -4818, 31654, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -61285, 179728, -4818, 30212, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -61985, 179837, -4818, 15368, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -61786, 179408, -4819, 20623, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -55678, 181341, -4818, 32546, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -56547, 181333, -4807, 32396, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -57013, 181320, -4807, 33065, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -57616, 181354, -4807, 32292, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -58413, 184465, -4818, 38857, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -58250, 184298, -4818, 30509, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -58894, 182709, -4818, 35426, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -59012, 182381, -4818, 45549, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -58765, 182190, -4818, 62289, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -58548, 182613, -4818, 12219, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -58586, 182450, -4818, 30915, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -59504, 183787, -4818, 45996, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -59499, 184397, -4818, 20522, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -59495, 183221, -4818, 37757, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18607, -61863, 183571, -4824, 3204, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18616, -59676, 186186, -4818, 16196, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -57152, 186111, -4818, 33022, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -56976, 186479, -4818, 33494, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -57309, 186320, -4818, 37221, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -57361, 186271, -4972, 945, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(32493, -57017, 186267, -4972, 32767, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -57191, 186253, -4973, 17216, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -57184, 186579, -4972, 17699, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -57194, 185901, -4973, 38795, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -54897, 186785, -4818, 38404, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -55211, 186396, -4818, 41103, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -55344, 186499, -4818, 25894, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18614, -55199, 186649, -4818, 63813, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False
    newNpc = self.addSpawn(18615, -54972, 186571, -4818, 10584, False, 0, False, world.instanceId)
    world.startRoom.npclist[newNpc]=False

class Quest(JQuest):
    def __init__(self,id,name,descr):
        JQuest.__init__(self,id,name,descr)
        self.questItemIds = [SWORD,ENHENCED_SWORD,ENHENCED_SWORD_2,BOOK1,BOOK2,BOOK3,BOOK4,BOOK5,BOOK6,BOOK7,WATER_ENHENCER,FIRE_ENHENCER,PAILAKA_INSTANT_SHIELD,QUICK_HEALING_POTION,FIRE_ATTRIBUTE_ENHANCER,WATER_ATTRIBUTE_ENHANCER,PAILAKA_SOULSHOT_GRADE_D]
        self.worlds = {}
        self.world_ids = []
        self.FirstAttacked = True
        for i in [32492,32493]:
            self.addSkillSeeId(i)
            self.addAttackId(i)
            self.addKillId(i)
            self.addSpawnId(i)

    def onAdvEvent(self,event,npc,player):
        htmltext = event
        st = player.getQuestState(qn)
        if not st: return
        npcId = npc.getNpcId()
        if npcId == ADLER and event == "accept":
            tele = PyObject()
            tele.x = -52855
            tele.y = 188199
            tele.z = -4700
            instanceId = enterInstance(self, player, "SongOfIceAndFire.xml", tele)
            if instanceId == 0:
                return
            st.set("cond","1")
            st.setState(State.STARTED)
            st.playSound("ItemSound.quest_accept")
            htmltext = "32497-05.htm"
        if event == "32497-02.htm":
            if player.getLevel() < 36:
                htmltext = "32497-04.htm"
            elif player.getLevel() >= 42:
                htmltext = "32497-00.htm"
        elif event == "32500-05.htm":
            st.set("cond","2")
            st.playSound("ItemSound.quest_itemget")
            st.giveItems(SWORD, 1)
            st.giveItems(BOOK1, 1)
        elif event == "32507-03.htm":
            st.set("cond","4")
            st.playSound("ItemSound.quest_middle")
            st.takeItems(SWORD, -1)
            st.giveItems(ENHENCED_SWORD, 1)
            st.takeItems(WATER_ENHENCER, -1)
            st.takeItems(BOOK2, -1)
            st.giveItems(BOOK3,1)
            st.takeItems(WATER_ENHENCER, -1)
        elif event == "32507-07.htm":
            st.set("cond","7")
            st.playSound("ItemSound.quest_itemget")
            st.takeItems(ENHENCED_SWORD, -1)
            st.giveItems(ENHENCED_SWORD_2, 1)
            st.takeItems(FIRE_ENHENCER, -1)
            st.takeItems(BOOK5, -1)
            st.giveItems(BOOK6, 1)
        elif event == "32510-01.htm":
            st.playSound("ItemSound.quest_finish")
            st.giveItems(PSOE, 1)
            st.giveItems(PAILAKA_RING, 1)
            st.giveItems(PAILAKA_EARRING, 1)
            player.setVitalityPoints(20000, True)
            st.addExpAndSp(810000, 50000)
            st.unset("cond")
            st.exitQuest(False)
            instanceId = player.getInstanceId()
            instance = InstanceManager.getInstance().getInstance(instanceId)
            instance.setDuration(300000)
        return htmltext
            
    def onTalk (self,npc,player):
        htmltext = "<html><body>目前沒有執行任務，或條件不符。</body></html>"
        st = player.getQuestState(qn)
        if not st : return htmltext
        npcId = npc.getNpcId()
        state = st.getState()
        cond = st.getInt("cond")
        if state == State.COMPLETED :
            if npcId == ADLER:
                htmltext = "32497-06.htm"
            elif npcId == ADLER2:
                htmltext = "32510-02.htm"
        elif state == State.CREATED :
            if npcId == ADLER:
                if cond == 0:
                    htmltext = "32497.htm"
                else:
                    htmltext = "32497-06.htm"
        else:
            if npcId == ADLER:
                if cond in [1,2]:
                    tele = PyObject()
                    tele.x = -52855
                    tele.y = 188199
                    tele.z = -4700
                    instanceId = enterInstance(self, player, "SongOfIceAndFire.xml", tele)
                    htmltext = "32497-05.htm"
                else:
                    htmltext = "因為超過時間限制，故任務取消。請重新接任務。"
                    st.exitQuest(1)
            elif npcId == SINAI:
                if cond == 1:
                    htmltext = "32500.htm"
                if cond in [2,3,4,5,6,7,8,9]:
                    htmltext = "32500-06.htm"
            elif npcId == ADLER2:
                if cond == 9:
                    htmltext = "32510.htm"
            elif npcId == INSPECTOR:
                if cond == 2:
                    htmltext = "32507-01.htm"
                elif cond == 3:
                    htmltext = "32507-02.htm"
                elif cond in [4,5]:
                    htmltext = "32507-04.htm"
                elif cond == 6 :
                    htmltext = "32507-05.htm"
                elif cond in [7,8,9]:
                    htmltext = "32507-08.htm"
        return htmltext

    def onAttack (self, npc, player, damage, isPet, skill) :
        objId = npc.getObjectId()
        if npc.getNpcId() == GARGOS :
            if self.FirstAttacked :
                if Rnd.get(50) : return
                npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), "開...開...始..."))
            else :
                self.FirstAttacked = True
                if Rnd.get(50) : return
                npc.broadcastPacket(NpcSay(objId, 0, npc.getNpcId(), "開...開...始..."))
        return 

    def onKill(self,npc,player,isPet):
        st = player.getQuestState(qn)
        if not st : return
        npcId = npc.getNpcId()
        cond = st.getInt("cond")
        if npc.getInstanceId() in self.worlds:
            world = self.worlds[npc.getInstanceId()]
            if world.status == 0:
                if npcId == HILLAS and cond == 2:
                    st.playSound("ItemSound.quest_itemget")
                    st.giveItems(WATER_ENHENCER,1)
                    st.takeItems(BOOK1, -1)
                    st.giveItems(BOOK2, 1)
                    st.set("cond","3")
                elif npcId == PAPION and cond == 4:
                    st.playSound("ItemSound.quest_itemget")
                    st.takeItems(BOOK3, -1)
                    st.giveItems(BOOK4,1)
                    st.set("cond","5")
                elif npcId == KINSUS and cond == 5:
                    st.playSound("ItemSound.quest_itemget")
                    st.takeItems(BOOK4, -1)
                    st.giveItems(BOOK5, 1)
                    st.giveItems(FIRE_ENHENCER,1)
                    st.set("cond","6")
                elif npcId == GARGOS and cond == 7:
                    st.playSound("ItemSound.quest_itemget")
                    st.takeItems(BOOK6, -1)
                    st.giveItems(BOOK7, 1)
                    st.set("cond","8")
                    self.FirstAttacked = False
                elif npcId == ADIANTUM and cond == 8:
                    st.playSound("ItemSound.quest_middle")
                    st.set("cond","9")
                    newNpc = self.addSpawn(ADLER2, -53582, 185022, -4619, 64590, False, 0, False, world.instanceId)
                    world.startRoom.npclist[newNpc] = False
                elif npcId == BLOOM:
                    st.giveItems(PAILAKA_SOULSHOT_GRADE_D, 500)
                weapon = player.getActiveWeaponItem()
                found = False
                if str(weapon) == "None" :
                    found = False
                elif isPet == True :
                    found = False
                else :
                    if npc.getNpcId() == CRYSTAL_WATER_BOTTLE:
                        if weapon.getItemId() in [13034,13035,13036]:
                            found = True
                    if found :
                        dropid = Rnd.get(len(REWARDS1))
                        qty = Rnd.get(len(RNDCOUNT))
                        st.giveItems(REWARDS1[dropid],RNDCOUNT[qty])
                        return
                    if npc.getNpcId() == BURNING_BRAZIER:
                        if weapon.getItemId() in [13034,13035,13036]:
                            found = True
                    if found :
                        dropid1 = Rnd.get(len(REWARDS2))
                        qty = Rnd.get(len(RNDCOUNT))
                        st.giveItems(REWARDS2[dropid1],RNDCOUNT[qty])
                        return
        return

QUEST = Quest(128, qn, "菲拉卡-冰與火之歌")

QUEST.addStartNpc(ADLER)

QUEST.addAttackId(GARGOS)

for i in [32497,32500,32507,32510]:
	QUEST.addTalkId(i)

for mob in [18607,18608,18609,18610,18611,18612,18613,18614,18615,18616,18620,32492,32493]:
	QUEST.addKillId(mob)