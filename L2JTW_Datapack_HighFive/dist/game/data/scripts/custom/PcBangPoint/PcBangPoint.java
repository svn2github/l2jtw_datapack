/*
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */
package custom.PcBangPoint;

import java.util.Map;

import javolution.util.FastMap;

import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.actor.instance.L2SummonInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.ExPCCafePointInfo;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;

/**
 * @author pmq
 * Update to HIGH FIVE
 */
public class PcBangPoint extends Quest
{
	private static final String qn = "PcBangPoint";
	// Item
	//private static final int POINTS    = -100; // PcBangPoint
	// NPCs
	private static final int[] NPCs =
	{
		31729, 31730, 31731, 31732, 31733, 31734, 31735, 31736, 31737, 31738, 31739, 31740, 31741,
		31742, 31743, 31744, 31745, 31746, 31747, 31748, 31749, 31750, 31751, 31752, 31753, 31754,
		31755, 31756, 31757, 31758, 31759, 31760, 31761, 31762, 31763, 31764, 31765, 31766, 31767,
		31768, 31769, 31770, 31771, 31772, 31773, 31774, 31775, 31776, 31777, 31778, 31779, 31780,
		31781, 31782, 31783, 31784, 31785, 31786, 31787, 31788, 31789, 31790, 31791, 31792, 31793,
		31794, 31795, 31796, 31797, 31798, 31799, 31800, 31801, 31802, 31803, 31804, 31805, 31806,
		31807, 31808, 31809, 31810, 31811, 31812, 31813, 31814, 31815, 31816, 31817, 31818, 31819,
		31820, 31821, 31822, 31823, 31824, 31825, 31826, 31827, 31828, 31829, 31830, 31831, 31832,
		31833, 31834, 31835, 31836, 31837, 31838, 31839, 31840, 31841, 32337, 32338, 32339, 32340
	};
	
	private static final Map<String, int[]> PETSKILL = new FastMap<String, int[]>();
	private static final Map<String, int[]> POINTSSKILL = new FastMap<String, int[]>();
	private static final Map<String, int[]> TELEPORTERS = new FastMap<String, int[]>();
	
	static
	{
		// Player Skill                      ID   LV  QTY Points
		POINTSSKILL.put("S4391", new int[] { 4391, 2, 300 }); // Wind Walk 風之疾走2級 - 300點
		POINTSSKILL.put("S4392", new int[] { 4392, 3, 200 }); // Shield 保護盾3級   - 200點
		POINTSSKILL.put("S4393", new int[] { 4393, 3, 400 }); // Might 力量強化3級 - 400點
		POINTSSKILL.put("S4394", new int[] { 4394, 4, 400 }); // Blessed Body 神佑之體4級 - 400點
		POINTSSKILL.put("S4395", new int[] { 4395, 4, 400 }); // Blessed Soul 神佑之魂4級 - 400點
		POINTSSKILL.put("S4396", new int[] { 4396, 2, 400 }); // Magic Barrier 魔法屏障2級 - 400點
		POINTSSKILL.put("S4397", new int[] { 4397, 2, 500 }); // Berserker Spirit 狂戰士魂2級 - 500點
		POINTSSKILL.put("S4398", new int[] { 4398, 3, 200 }); // Bless Shield 祝福之盾3級 - 200點
		POINTSSKILL.put("S4399", new int[] { 4399, 3, 400 }); // Vampiric Rage 吸血怒擊3級 - 400點
		POINTSSKILL.put("S4440", new int[] { 4400, 3, 950 }); // Acumen 靈活思緒3級 - 950點
		POINTSSKILL.put("S4401", new int[] { 4401, 3, 400 }); // Empower 魔力催化3級 - 400點
		POINTSSKILL.put("S4402", new int[] { 4402, 2, 950 }); // Haste 速度激發2級 - 950點
		POINTSSKILL.put("S4403", new int[] { 4403, 3, 400 }); // Guidance 導引3級     - 400點
		POINTSSKILL.put("S4404", new int[] { 4404, 3, 800 }); // Focus 弱點偵測3級 - 800點
		POINTSSKILL.put("S4405", new int[] { 4405, 3, 950 }); // Death Whisper 死之呢喃3級 - 950點
		POINTSSKILL.put("S4406", new int[] { 4406, 3, 400 }); // Agility 敏捷術3級   - 400點
		
		// Pet Skill                      ID   LV  QTY Points
		PETSKILL.put("P4391", new int[] { 4391, 2, 300 }); // Wind Walk 風之疾走2級 - 300點
		PETSKILL.put("P4392", new int[] { 4392, 2, 150 }); // Shield 保護盾2級   - 150點
		PETSKILL.put("P4393", new int[] { 4393, 2, 300 }); // Might 力量強化2級 - 300點
		PETSKILL.put("P4394", new int[] { 4394, 3, 300 }); // Blessed Body 神佑之體3級 - 300點
		PETSKILL.put("P4395", new int[] { 4395, 3, 300 }); // Blessed Soul 神佑之魂3級 - 300點
		PETSKILL.put("P4396", new int[] { 4396, 1, 300 }); // Magic Barrier 魔法屏障1級 - 300點
		PETSKILL.put("P4397", new int[] { 4397, 1, 300 }); // Berserker Spirit 狂戰士魂1級 - 300點
		PETSKILL.put("P4398", new int[] { 4398, 2, 150 }); // Bless Shield 祝福之盾2級 - 150點
		PETSKILL.put("P4399", new int[] { 4399, 2, 300 }); // Vampiric Rage 吸血怒擊2級 - 300點
		PETSKILL.put("P4440", new int[] { 4400, 2, 600 }); // Acumen 靈活思緒2級 - 600點
		PETSKILL.put("P4401", new int[] { 4401, 2, 300 }); // Empower 魔力催化2級 - 300點
		PETSKILL.put("P4402", new int[] { 4402, 1, 400 }); // Haste 速度激發1級 - 400點
		PETSKILL.put("P4403", new int[] { 4403, 2, 300 }); // Guidance 導引2級     - 300點
		PETSKILL.put("P4404", new int[] { 4404, 2, 650 }); // Focus 弱點偵測2級 - 650點
		PETSKILL.put("P4405", new int[] { 4405, 2, 800 }); // Death Whisper 死之呢喃2級 - 800點
		PETSKILL.put("P4406", new int[] { 4406, 2, 300 }); // Agility 敏捷術2級   - 300點
		
		// Teleporters                            x       y       z    QTY Points
		// 說話之島 NPCID 31775
		TELEPORTERS.put("TELE_01", new int[] { -112367, 234703, -3688, 30 }); // Elven Ruins 30 points = 精靈廢墟 - 30 點數
		TELEPORTERS.put("TELE_02", new int[] { -111728, 244330, -3448, 20 }); // Singing Waterfall 20 points = 歌唱的瀑布 - 20 點數
		TELEPORTERS.put("TELE_03", new int[] { -106696, 214691, -3424, 30 }); // Western Territory 30 points = 說話之島西部(北邊) - 30 點數
		TELEPORTERS.put("TELE_04", new int[] { -99586, 237637, -3568, 20 }); // Obelisk of Victory 20 points = 戰勝紀念塔 - 20 點數
		// 精靈村莊 NPCID 31780
		TELEPORTERS.put("TELE_05", new int[] { 21362, 51122, -3688, 20 }); // Elven Forest 20 points = 精靈森林 - 20 點數
		TELEPORTERS.put("TELE_06", new int[] { 29294, 74968, -3776, 30 }); // Elven Fortress 30 points = 精靈的地底要塞 - 30 點數
		TELEPORTERS.put("TELE_07", new int[] { -10612, 75881, -3592, 50 }); // Neutral Zone 50 points = 中立地帶 - 50 點數
		// 黑暗精靈村莊 NPCID 31777
		TELEPORTERS.put("TELE_08", new int[] { -22224, 14168, -3232, 30 }); // Dark Forest 30 points = 黑暗精靈森林 - 30 點數
		TELEPORTERS.put("TELE_09", new int[] { -21966, 40544, -3192, 30 }); // Swampland 30 points = 沼澤地帶 - 30 點數
		TELEPORTERS.put("TELE_10", new int[] { -61095, 75104, -3352, 90 }); // Spider Nest 90 points = 蜘蛛巢穴 - 90 點數
		TELEPORTERS.put("TELE_11", new int[] { -10612, 75881, -3592, 50 }); // Neutral Zone 50 points = 中立地帶 - 50 點數
		// 獸人村莊 NPCID 31784
		TELEPORTERS.put("TELE_12", new int[] { -4190, -80040, -2696, 50 }); // Immortal Plateau Southern Region 50 points = 不滅高原南部 - 50 點數
		TELEPORTERS.put("TELE_13", new int[] { -10983, -117484, -2464, 30 }); // The Immortal Plateau 30 points = 不滅高原 - 30 點數
		TELEPORTERS.put("TELE_14", new int[] { 9340, -112509, -2536, 40 }); // Cave of Trials 40 points = 試練洞窟 - 40 點數
		TELEPORTERS.put("TELE_15", new int[] { 8652, -139941, -1144, }); // Frozen Waterfall 40 points = 冰凍瀑布 - 40 點數
		// 矮人村莊 NPCID 31782
		TELEPORTERS.put("TELE_16", new int[] { 139714, -177456, -1536, 20 }); // Abandoned Coal Mines 20 points = 廢棄的礦坑 - 20 點數
		TELEPORTERS.put("TELE_17", new int[] { 169008, -208272, -3504, 60 }); // Eastern Mining Zone (Northeastern Shore) 60 points = 山脈礦區東部（東北部海岸） - 60 點數
		TELEPORTERS.put("TELE_18", new int[] { 136910, -205082, -3664, 30 }); // Western Mining Zone (Central Shore) 30 points = 山脈礦區西部（中部海岸） - 30 點數
		TELEPORTERS.put("TELE_19", new int[] { 171946, -173352, 3440, 280 }); // Mithril Mines Western Entrance 280 points = 米索莉礦山西邊入口 - 280 點數
		TELEPORTERS.put("TELE_20", new int[] { 178591, -184615, -360, 300 }); // Mithril Mines Eastern Entrance 300 points = 米索莉礦山北邊入口 - 300 點數
		// 闇天使村莊沒有傳送 NPCID 32338 32337
		// 古魯丁村莊 NPCID 31790
		TELEPORTERS.put("TELE_21", new int[] { -44763, 203497, -3592, 50 }); // Langk Lizardman Dwelling 50 points = 朗克蜥蝪人兵營 - 50 點數
		TELEPORTERS.put("TELE_22", new int[] { -63736, 101522, -3552, 40 }); // Fellmere Harvest Grounds 40 points = 帕米爾採集場 - 40 點數
		TELEPORTERS.put("TELE_23", new int[] { -75437, 168800, -3632, 20 }); // Windmill Hill 20 points = 風車的山坡 - 20 點數
		TELEPORTERS.put("TELE_24", new int[] { -53001, 191425, -3568, 50 }); // Forgotten Temple 50 points = 遺忘神殿 - 50 點數
		TELEPORTERS.put("TELE_25", new int[] { -89763, 105359, -3576, 50 }); // Orc Barracks 50 points = 土瑞克獸人兵營 - 50 點數
		TELEPORTERS.put("TELE_26", new int[] { -88539, 83389, -2864, 70 }); // Windy Hill 70 points = 風之丘陵 - 70 點數
		TELEPORTERS.put("TELE_27", new int[] { -49853, 147089, -2784, 30 }); // Abandoned Camp 30 points = 荒廢的營區 - 30 點數
		TELEPORTERS.put("TELE_28", new int[] { -16526, 208032, -3664, 90 }); // Wastelands 90 points = 荒原 - 90 點數
		TELEPORTERS.put("TELE_29", new int[] { -42256, 198333, -2800, 100 }); // Red Rock Ridge 100 points = 赤岩稜線 - 100 點數
		// 古魯丁城鎮 NPCID 31729
		TELEPORTERS.put("TELE_30", new int[] { -41248, 122848, -2904, 20 }); // Ruins of Agony 20 points = 悲哀廢墟 - 20 點數
		TELEPORTERS.put("TELE_31", new int[] { -19120, 136816, -3752, 20 }); // Ruins of Despair 20 points = 絕望廢墟 - 20 點數
		TELEPORTERS.put("TELE_32", new int[] { -9959, 176184, -4160, 60 }); // Ant Cave 60 points = 螞蟻洞窟 - 60 點數
		TELEPORTERS.put("TELE_33", new int[] { -28327, 155125, -3496, 40 }); // Windawood Manor 40 points = 溫達伍德莊園 - 40 點數
		// 狄恩 NPCID 31797
		TELEPORTERS.put("TELE_34", new int[] { 5106, 126916, -3664, 20 }); // Cruma Marshlands 20 points = 克魯瑪沼澤 - 20 點數
		TELEPORTERS.put("TELE_35", new int[] { 17225, 114173, -3440, 60 }); // Cruma Tower 60 points = 克魯瑪高塔 - 60 點數
		TELEPORTERS.put("TELE_36", new int[] { 47382, 111278, -2104, 50 }); // Fortress of Resistance 50 points = 反抗軍根據地 - 50 點數
		TELEPORTERS.put("TELE_37", new int[] { 630, 179184, -3720, 40 }); // Plains of Dion 40 points = 狄恩牧草地 - 40 點數
		TELEPORTERS.put("TELE_38", new int[] { 34475, 188095, -2976, 80 }); // Bee Hive 80 points = 蜜蜂蜂窩 - 80 點數
		TELEPORTERS.put("TELE_39", new int[] { 60374, 164301, -2856, 100 }); // Tanor Canyon 100 points = 塔諾峽谷 - 100 點數
		// 芙蘿蘭村莊 NPCID 31801
		TELEPORTERS.put("TELE_40", new int[] { 50568, 152408, -2656, 40 }); // Execution Grounds 40 points = 刑場 - 40 點數
		TELEPORTERS.put("TELE_41", new int[] { 33565, 162393, -3600, 40 }); // Tanor Canyon (West side) 40 points = 塔諾峽谷西邊 - 40 點數
		TELEPORTERS.put("TELE_42", new int[] { 26810, 172787, -3376, 20 }); // Floran Agricultural Area 20 points = 芙蘿蘭開墾地 - 20 點數
		// 水上都市海音斯 NPCID 31820
		TELEPORTERS.put("TELE_43", new int[] { 87691, 162835, -3563, 300 }); // Field of Silence 300 points = 寧靜平原 - 300 點數
		TELEPORTERS.put("TELE_44", new int[] { 82192, 226128, -3664, 150 }); // Field of Whispers 150 points = 細語平原 - 150 點數
		TELEPORTERS.put("TELE_45", new int[] { 115583, 192261, -3488, 60 }); // Entrance to Alligator Islands 60 points = 鱷魚島 - 60 點數
		TELEPORTERS.put("TELE_46", new int[] { 84413, 234334, -3656, 60 }); // Garden of Eva 60 points = 伊娃的水中庭園 - 60 點數
		TELEPORTERS.put("TELE_47", new int[] { 149518, 195280, -3736, 180 }); // Isle of Prayer 180 points = 神諭之島 - 180 點數
		// 奇岩 NPCID 31806
		TELEPORTERS.put("TELE_48", new int[] { 73024, 118485, -3688, 50 }); // Dragon Valley 50 points = 龍之谷 - 50 點數
		TELEPORTERS.put("TELE_49", new int[] { 131557, 114509, -3712, 180 }); // Antharas Lair 180 points = 安塔瑞斯洞窟 - 180 點數
		TELEPORTERS.put("TELE_50", new int[] { 43408, 206881, -3752, 150 }); // Devil Isle 150 points = 惡魔島 - 150 點數
		TELEPORTERS.put("TELE_51", new int[] { 85546, 131328, -3672, 30 }); // Brekas Stronghold 30 points = 布賴卡的巢穴 - 30 點數
		// 歐瑞城鎮 NPCID 31815
		TELEPORTERS.put("TELE_52", new int[] { 76839, 63851, -3648, 20 }); // Sel Mahum Training Grounds (West Gate) 20 points = 權能培訓場（西門） - 20 點數
		TELEPORTERS.put("TELE_53", new int[] { 87252, 85514, -3056, 50 }); // Plains of Lizardmen 50 points = 蜥蝪草原 - 50 點數
		TELEPORTERS.put("TELE_54", new int[] { 91539, -12204, -2440, 130 }); // Outlaw Forest 130 points = 無法者的森林 - 130 點數
		TELEPORTERS.put("TELE_55", new int[] { 64328, 26803, -3768, 70 }); // Sea of Spores 70 points = 孢子之海 - 70 點數
		// 獵人村莊 NPCID 31826
		TELEPORTERS.put("TELE_56", new int[] { 124904, 61992, -3920, 40 }); // Southern Pathway of Enchanted Valley 40 points = 妖精谷（南方） - 40 點數
		TELEPORTERS.put("TELE_57", new int[] { 104426, 33746, -3800, 90 }); // Northern Pathway of Enchanted Valley 90 points = 妖精谷（北方） - 90 點數
		TELEPORTERS.put("TELE_58", new int[] { 142065, 81300, -3000, 50 }); // Entrance to the Forest of Mirrors 50 points = 鏡之森林 - 50 點數
		// 亞丁城鎮 NPCID 31829
		TELEPORTERS.put("TELE_59", new int[] { 168217, 37990, -4072, 50 }); // Forsaken Plains 50 points = 忘卻平原 - 50 點數
		TELEPORTERS.put("TELE_60", new int[] { 184742, 19745, -3168, 80 }); // Seal of Shilen 80 points = 席琳封印 - 80 點數
		TELEPORTERS.put("TELE_61", new int[] { 142065, 81300, -3000, 110 }); // Forest of Mirrors 110 points = 鏡之森林 - 110 點數
		TELEPORTERS.put("TELE_62", new int[] { 155310, -16339, -3320, 170 }); // Blazing Swamp 170 points = 燃燒的沼澤 - 170 點數
		TELEPORTERS.put("TELE_63", new int[] { 183543, -14974, -2776, 170 }); // Fields of Massacre 170 points = 殺戮的大地 - 170 點數
		TELEPORTERS.put("TELE_64", new int[] { 106517, -2871, -3416, 150 }); // Ancient Battleground 150 points = 古戰場 - 150 點數
		TELEPORTERS.put("TELE_65", new int[] { 170838, 55776, -5280, 160 }); // Silent Valley 160 points = 寂靜之谷 - 160 點數
		TELEPORTERS.put("TELE_66", new int[] { 114649, 11115, -5120, 110 }); // ToI 110 points = 傲慢之塔 - 110 點數
		TELEPORTERS.put("TELE_67", new int[] { 174491, 50942, -4360, 190 }); // The Giant's Cave 190 points = 巨人洞穴入口 - 190 點數
		// 高達特城鎮 NPCID 31839
		TELEPORTERS.put("TELE_68", new int[] { 125740, -40864, -3736, 110 }); // Varka Silenos Stronghold 110 points = 巴瑞卡賽勒諾斯兵營 - 110 點數
		TELEPORTERS.put("TELE_69", new int[] { 146990, -67128, -3640, 50 }); // Ketra Orc Outpost 50 points = 肯特拉獸人前哨基地 - 50 點數
		TELEPORTERS.put("TELE_70", new int[] { 144880, -113468, -2560, 240 }); // Hot Springs 240 points = 溫泉地帶 - 240 點數
		TELEPORTERS.put("TELE_71", new int[] { 165054, -47861, -3560, 60 }); // Wall of Argos 60 points = 亞爾古斯之壁 - 60 點數
		TELEPORTERS.put("TELE_72", new int[] { 106414, -87799, -2920, 250 }); // Monastery of silence 250 points = 沉默修道院 - 250 點數
		TELEPORTERS.put("TELE_73", new int[] { 169018, -116303, -2432, 250 }); // Forge of the Gods 250 points = 諸神的熔爐入口 - 250 點數
		// 魯因城鎮 NPCID 31833
		TELEPORTERS.put("TELE_74", new int[] { 53516, -82831, -2700, 120 }); // Wild Beast Pastures 120 points = 猛獸放牧場 - 120 點數
		TELEPORTERS.put("TELE_75", new int[] { 65307, -71445, -3688, 100 }); // Valley of Saints 100 points = 聖者之谷 - 100 點數
		TELEPORTERS.put("TELE_76", new int[] { 52107, -54328, -3152, 30 }); // Forest of the Dead 300 points = 亡者的森林 - 30 點數
		TELEPORTERS.put("TELE_77", new int[] { 69340, -50203, -3288, 80 }); // Swamp of Screams 80 points = 悲嗚的沼澤 - 80 點數
		TELEPORTERS.put("TELE_78", new int[] { 106414, -87799, -2920, 350 }); // Monastery of Silence 350 points = 沉默修道院 - 350 點數
		TELEPORTERS.put("TELE_79", new int[] { 89513, -44800, -2136, 230 }); // Stakato 230 points = 司塔卡拓巢穴 - 230 點數
		TELEPORTERS.put("TELE_80", new int[] { 11235, -24026, -3640, 160 }); // Primeval Isle 160 points = 原始之島碼頭 - 160 點數
		// 修加特城鎮 NPCID 31994
		TELEPORTERS.put("TELE_81", new int[] { 47692, -115745, -3744, 240 }); // Crypt of Disgrace 240 points = 恥辱墓地 - 240 點數
		TELEPORTERS.put("TELE_82", new int[] { 111965, -154172, -1528, 40 }); // Plunderous Plains 400 points = 掠奪的荒野 - 40 點數
		TELEPORTERS.put("TELE_83", new int[] { 68693, -110438, -1904, 190 }); // Den of Evil 190 points = 惡靈巢穴 - 190 點數
		TELEPORTERS.put("TELE_84", new int[] { 91280, -117152, -3928, 60 }); // Pavel Ruins 60 points = 帕比爾遺跡 - 60 點數
		TELEPORTERS.put("TELE_85", new int[] { 113903, -108752, -856, 90 }); // Ice Merchant Cabin 90 points = 冰雪商隊駐紮地 - 90 點數
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = event;
		QuestState st = player.getQuestState(qn);
		
		if (st == null)
			return htmltext;
		
		if (POINTSSKILL.containsKey(event))
		{
			if (player.getPcBangPoints() >= POINTSSKILL.get(event)[2])
			{
				final int cost = player.getPcBangPoints() - (int)(POINTSSKILL.get(event)[2]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)POINTSSKILL.get(event)[2]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)POINTSSKILL.get(event)[2], false, false, 1));
				npc.setTarget(player);
				npc.doCast(SkillTable.getInstance().getInfo(POINTSSKILL.get(event)[0],POINTSSKILL.get(event)[1]));
				return "Individual_skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (PETSKILL.containsKey(event))
		{
			if (player.getPet() == null || !(player.getPet() instanceof L2SummonInstance))
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= PETSKILL.get(event)[2])
			{
				final int cost = player.getPcBangPoints() - (int)(PETSKILL.get(event)[2]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)PETSKILL.get(event)[2]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)PETSKILL.get(event)[2], false, false, 1));
				npc.setTarget(player.getPet());
				npc.doCast(SkillTable.getInstance().getInfo(PETSKILL.get(event)[0],PETSKILL.get(event)[1]));
				return "Individual_pet_skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (TELEPORTERS.containsKey(event))
		{
			if (player.getPcBangPoints() >= TELEPORTERS.get(event)[3])
			{
				final int cost = player.getPcBangPoints() - (int)(TELEPORTERS.get(event)[3]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)TELEPORTERS.get(event)[3]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)TELEPORTERS.get(event)[3], false, false, 1));
				player.teleToLocation(TELEPORTERS.get(event)[0], TELEPORTERS.get(event)[1], TELEPORTERS.get(event)[2]);
				return null;
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("tele"))
		{
			htmltext = npc.getNpcId() + "-tele.htm";
		}
		else if (event.equalsIgnoreCase("wyvern"))
		{
			if (player.getPcBangPoints() >= 2500)
			{
				final int cost = player.getPcBangPoints() - (int)(2500);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)2500);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)2500, false, false, 1));
				player.mount(12621, 0, true);
				player.addSkill(SkillTable.FrequentSkill.WYVERN_BREATH.getSkill());
				return null;
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("warrior"))
		{
			if (player.getLevel() < 55)
			{
				htmltext = "skill_nolevel.htm";
			}
			else if (player.getPcBangPoints() >= 5600)
			{
				final int cost = player.getPcBangPoints() - (int)(5600);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)5600);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)5600, false, false, 1));
				npc.setTarget(player);
				npc.doCast(SkillTable.getInstance().getInfo(4397,2));	// 狂戰士魂2級
				npc.doCast(SkillTable.getInstance().getInfo(4393,3));	// 力量強化3級
				npc.doCast(SkillTable.getInstance().getInfo(4392,3));	// 保護盾3級
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// 風之疾走2級
				npc.doCast(SkillTable.getInstance().getInfo(4404,3));	// 弱點偵測3級
				npc.doCast(SkillTable.getInstance().getInfo(4396,2));	// 魔法屏障2級
				npc.doCast(SkillTable.getInstance().getInfo(4405,3));	// 死之呢喃3級
				npc.doCast(SkillTable.getInstance().getInfo(4403,3));	// 導引3級
				npc.doCast(SkillTable.getInstance().getInfo(4398,3));	// 祝福之盾3級
				npc.doCast(SkillTable.getInstance().getInfo(4394,4));	// 神佑之體4級
				npc.doCast(SkillTable.getInstance().getInfo(4402,2));	// 速度激發2級
				npc.doCast(SkillTable.getInstance().getInfo(4406,3));	// 敏捷術3級
				npc.doCast(SkillTable.getInstance().getInfo(4399,3));	// 吸血怒擊3級
				htmltext = "skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("pet_warrior"))
		{
			if (player.getPet() == null || !(player.getPet() instanceof L2SummonInstance))
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= 4000)
			{
				final int cost = player.getPcBangPoints() - (int)(4000);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)4000);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)4000, false, false, 1));
				npc.setTarget(player.getPet());
				npc.doCast(SkillTable.getInstance().getInfo(4397,1));	// 狂戰士魂1級
				npc.doCast(SkillTable.getInstance().getInfo(4393,2));	// 力量強化2級
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// 保護盾2級
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// 風之疾走
				npc.doCast(SkillTable.getInstance().getInfo(4404,2));	// 弱點偵測2級
				npc.doCast(SkillTable.getInstance().getInfo(4396,1));	// 魔法屏障1級
				npc.doCast(SkillTable.getInstance().getInfo(4405,2));	// 死之呢喃2級
				npc.doCast(SkillTable.getInstance().getInfo(4403,2));	// 導引2級
				npc.doCast(SkillTable.getInstance().getInfo(4398,2));	// 祝福之盾2級
				npc.doCast(SkillTable.getInstance().getInfo(4394,3));	// 神佑之體3級
				npc.doCast(SkillTable.getInstance().getInfo(4402,1));	// 速度激發1級
				npc.doCast(SkillTable.getInstance().getInfo(4406,2));	// 敏捷術2級
				npc.doCast(SkillTable.getInstance().getInfo(4399,2));	// 吸血怒擊2級
				htmltext = "pet_skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("mage"))
		{
			if (player.getLevel() < 55)
			{
				htmltext = "skill_nolevel.htm";
			}
			else if (player.getPcBangPoints() >= 3000)
			{
				final int cost = player.getPcBangPoints() - (int)(3000);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)3000);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)3000, false, false, 1));
				npc.setTarget(player);
				npc.doCast(SkillTable.getInstance().getInfo(4397,2));	// 狂戰士魂2級
				npc.doCast(SkillTable.getInstance().getInfo(4396,2));	// 魔法屏障2級
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// 保護盾3級
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// 風之疾走2級
				npc.doCast(SkillTable.getInstance().getInfo(4395,4));	// 神佑之魂4級
				npc.doCast(SkillTable.getInstance().getInfo(4401,3));	// 魔力催化3級
				npc.doCast(SkillTable.getInstance().getInfo(4400,3));	// 靈活思緒3級
				htmltext = "skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("pet_mage"))
		{
			if (player.getPet() == null || !(player.getPet() instanceof L2SummonInstance))
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= 2100)
			{
				final int cost = player.getPcBangPoints() - (int)(2100);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber((int)2100);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), (int)2100, false, false, 1));
				npc.setTarget(player.getPet());
				npc.doCast(SkillTable.getInstance().getInfo(4397,1));	// 狂戰士魂1級
				npc.doCast(SkillTable.getInstance().getInfo(4396,1));	// 魔法屏障1級
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// 保護盾2級
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// 風之疾走2級
				npc.doCast(SkillTable.getInstance().getInfo(4395,3));	// 神佑之魂3級
				npc.doCast(SkillTable.getInstance().getInfo(4401,2));	// 魔力催化2級
				npc.doCast(SkillTable.getInstance().getInfo(4400,2));	// 靈活思緒2級
				htmltext = "pet_skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		
		return htmltext;
	}
	
	@Override
	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		return "info.htm";
	}
	
	public PcBangPoint(int id, String name, String descr)
	{
		super(id, name, descr);
		
		for (int i : NPCs)
		{
			addStartNpc(i);
			addTalkId(i);
		}
	}
	
	public static void main(String[] args)
	{
		new PcBangPoint(-1, qn, "custom");
	}
}