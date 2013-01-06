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
		31729, 31730, 31731, 31732, 31733, 31734, 31735, 31736, 31737, 31738, 31775, 
		31776, 31777, 31778, 31779, 31780, 31781, 31782, 31783, 31784, 31785, 31786, 
		31787, 31788, 31789, 31790, 31791, 31792, 31793, 31794, 31795, 31796, 31797, 
		31798, 31799, 31800, 31801, 31802, 31803, 31804, 31805, 31806, 31807, 31808, 
		31809, 31810, 31811, 31812, 31813, 31814, 31815, 31816, 31817, 31818, 31819, 
		31820, 31821, 31822, 31823, 31824, 31825, 31826, 31827, 31828, 31829, 31830, 
		31831, 31832, 31833, 31834, 31835, 31836, 31837, 31838, 31839, 31840, 31841, 
		31991, 31992, 31993, 31994, 31995, 32337, 32338, 32339, 32340
	};
	/**
	 * ï¿½ï¿½ï¿½Ü¤ï¿½ï¿½q Talking Island NPCID 31775, 31776,
	 * ï¿½ï¿½ï¿½Fï¿½ï¿½ï¿þýElven Village NPCID 31780, 31781,
	 * ï¿½Â·tï¿½ï¿½ï¿½Fï¿½ï¿½ï¿þýDark Elf Village NPCID 31777, 31778, 31779,
	 * ï¿½~ï¿½Hï¿½ï¿½ï¿þýOrc Village NPCID 31784, 31785, 31786,
	 * ï¿½Gï¿½Hï¿½ï¿½ï¿þýDwarven Village NPCID 31782, 31783,
	 * ï¿½ï¿½Ñ¨Ï§ï¿½ï¿½ Kamael Village NPCID 32337, 32338, 32339, 32340,
	 * ï¿½jï¿½|ï¿½Bï¿½ï¿½ï¿þýThe Village of Gludin NPCID 31787, 31788, 31789, 31790, 31791,
	 * ï¿½jï¿½|ï¿½Bï¿½ï¿½ï¿½ï¿½ Gludio NPCID 31792, 31793, 31794, 31795, 31796,
	 * ï¿½fï¿½ï¿½ Dion NPCID 31797, 31798, 31799, 31800,
	 * ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿þýFloran Village NPCID 31801, 31802, 31803,
	 * ï¿½ï¿½ï¿½Wï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Heine NPCID 31819, 31820, 31821, 31822,
	 * ï¿½_ï¿½ï¿½ Giran NPCID 31804, 31805, 31806, 31807, 31808, 31809,
	 * ï¿½ï¿½ï¿½Å¾Ç°| Hardin's Private Academy NPCID 31810,
	 * ï¿½Ú·ç«°ï¿½ï¿½ Oren NPCID 31814, 31815, 31816, 31817, 31818,
	 * ï¿½Hï¿½ï¿½ï¿þýIvory Tower NPCID 31811, 31812, 31813,
	 * ï¿½yï¿½Hï¿½ï¿½ï¿þýHunters Village NPCID 31823, 31824, 31825, 31826,
	 * ï¿½È¤Bï¿½ï¿½ï¿½ï¿½ Aden NPCID 31827, 31828, 31829, 31830, 31831,
	 * ï¿½ï¿½ï¿½Fï¿½Sï¿½ï¿½ï¿½ï¿½ Goddard NPCID 31837, 31838, 31839, 31840, 31841,
	 * ï¿½|ï¿½]ï¿½ï¿½ï¿½ï¿½ Rune NPCID 31832, 31833, 31834, 31835, 31836,
	 * ï¿½×¥[ï¿½Sï¿½ï¿½ï¿½ï¿½ Schuttgart NPCID 31991, 31992, 31993, 31994, 31995,
	 * ï¿½×¥[ï¿½Sï¿½ï¿½ï¿½ï¿½ Schuttgart NPCID 31732=31994, 31733=31991, 31734=31992, 31738=31993, 31729=31995,
	 * Missing Spawn NPCID 31729, 31730, 31731, 31732, 31733, 31734, 31735, 31736, 31737, 31738,
	 */
	
	private static final Map<String, int[]> PETSKILL = new FastMap<>();
	private static final Map<String, int[]> POINTSSKILL = new FastMap<>();
	private static final Map<String, int[]> TELEPORTERS = new FastMap<>();
	
	static
	{
		// Player Skill                      ID   LV  QTY Points
		POINTSSKILL.put("S4391", new int[] { 4391, 2, 300 }); // Wind Walk ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½2ï¿½ï¿½ - 300ï¿½I
		POINTSSKILL.put("S4392", new int[] { 4392, 3, 200 }); // Shield ï¿½Oï¿½@ï¿½ï¿½3ï¿½ï¿½ - 200ï¿½I
		POINTSSKILL.put("S4393", new int[] { 4393, 3, 400 }); // Might ï¿½Oï¿½qï¿½jï¿½ï¿½3ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4394", new int[] { 4394, 4, 400 }); // Blessed Body ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½4ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4395", new int[] { 4395, 4, 400 }); // Blessed Soul ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½4ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4396", new int[] { 4396, 2, 400 }); // Magic Barrier ï¿½]ï¿½kï¿½Ì»ï¿½2ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4397", new int[] { 4397, 2, 500 }); // Berserker Spirit ï¿½gï¿½Ô¤hï¿½ï¿½2ï¿½ï¿½ - 500ï¿½I
		POINTSSKILL.put("S4398", new int[] { 4398, 3, 200 }); // Bless Shield ï¿½ï¿½ï¿½Ö¤ï¿½ï¿½ï¿½3ï¿½ï¿½ - 200ï¿½I
		POINTSSKILL.put("S4399", new int[] { 4399, 3, 400 }); // Vampiric Rage ï¿½lï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4440", new int[] { 4400, 3, 950 }); // Acumen ï¿½Fï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½ - 950ï¿½I
		POINTSSKILL.put("S4401", new int[] { 4401, 3, 400 }); // Empower ï¿½]ï¿½Oï¿½Ê¤ï¿½3ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4402", new int[] { 4402, 2, 950 }); // Haste ï¿½tï¿½×¿Eï¿½o2ï¿½ï¿½ - 950ï¿½I
		POINTSSKILL.put("S4403", new int[] { 4403, 3, 400 }); // Guidance ï¿½É¤ï¿½3ï¿½ï¿½ - 400ï¿½I
		POINTSSKILL.put("S4404", new int[] { 4404, 3, 800 }); // Focus ï¿½zï¿½Iï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½ - 800ï¿½I
		POINTSSKILL.put("S4405", new int[] { 4405, 3, 950 }); // Death Whisper ï¿½ï¿½ï¿½ï¿½ï¿½Oï¿½ï¿½3ï¿½ï¿½ - 950ï¿½I
		POINTSSKILL.put("S4406", new int[] { 4406, 3, 400 }); // Agility ï¿½Ó±ï¿½ï¿½N3ï¿½ï¿½ - 400ï¿½I
		
		// Pet Skill                      ID   LV  QTY Points
		PETSKILL.put("P4391", new int[] { 4391, 2, 300 }); // Wind Walk ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½2ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4392", new int[] { 4392, 2, 150 }); // Shield ï¿½Oï¿½@ï¿½ï¿½2ï¿½ï¿½ - 150ï¿½I
		PETSKILL.put("P4393", new int[] { 4393, 2, 300 }); // Might ï¿½Oï¿½qï¿½jï¿½ï¿½2ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4394", new int[] { 4394, 3, 300 }); // Blessed Body ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4395", new int[] { 4395, 3, 300 }); // Blessed Soul ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4396", new int[] { 4396, 1, 300 }); // Magic Barrier ï¿½]ï¿½kï¿½Ì»ï¿½1ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4397", new int[] { 4397, 1, 300 }); // Berserker Spirit ï¿½gï¿½Ô¤hï¿½ï¿½1ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4398", new int[] { 4398, 2, 150 }); // Bless Shield ï¿½ï¿½ï¿½Ö¤ï¿½ï¿½ï¿½2ï¿½ï¿½ - 150ï¿½I
		PETSKILL.put("P4399", new int[] { 4399, 2, 300 }); // Vampiric Rage ï¿½lï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4440", new int[] { 4400, 2, 600 }); // Acumen ï¿½Fï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½ - 600ï¿½I
		PETSKILL.put("P4401", new int[] { 4401, 2, 300 }); // Empower ï¿½]ï¿½Oï¿½Ê¤ï¿½2ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4402", new int[] { 4402, 1, 400 }); // Haste ï¿½tï¿½×¿Eï¿½o1ï¿½ï¿½ - 400ï¿½I
		PETSKILL.put("P4403", new int[] { 4403, 2, 300 }); // Guidance ï¿½É¤ï¿½2ï¿½ï¿½ - 300ï¿½I
		PETSKILL.put("P4404", new int[] { 4404, 2, 650 }); // Focus ï¿½zï¿½Iï¿½ï¿½ï¿½ï¿½2ï¿½ï¿½ - 650ï¿½I
		PETSKILL.put("P4405", new int[] { 4405, 2, 800 }); // Death Whisper ï¿½ï¿½ï¿½ï¿½ï¿½Oï¿½ï¿½2ï¿½ï¿½ - 800ï¿½I
		PETSKILL.put("P4406", new int[] { 4406, 2, 300 }); // Agility ï¿½Ó±ï¿½ï¿½N2ï¿½ï¿½ - 300ï¿½I
		
		// Teleporters                            x       y       z    QTY Points
		// ï¿½ï¿½ï¿½Ü¤ï¿½ï¿½q Talking Island Teleporters
		TELEPORTERS.put("TELE_01", new int[] { -112367, 234703, -3688, 30 }); // Elven Ruins 30 points = ï¿½ï¿½ï¿½Fï¿½oï¿½V - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_02", new int[] { -111728, 244330, -3448, 20 }); // Singing Waterfall 20 points = ï¿½qï¿½Ûªï¿½ï¿½rï¿½ï¿½ - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_03", new int[] { -106696, 214691, -3424, 30 }); // Western Territory 30 points = ï¿½ï¿½ï¿½Ü¤ï¿½ï¿½qï¿½è³¡(ï¿½_ï¿½ï¿½) - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_04", new int[] { -99586, 237637, -3568, 20 }); // Obelisk of Victory 20 points = ï¿½Ô³Ó¬ï¿½ï¿½ï¿½ï¿½ï¿½ - 20 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½ï¿½Fï¿½ï¿½ï¿þýElven Village Teleporters
		TELEPORTERS.put("TELE_05", new int[] { 21362, 51122, -3688, 20 }); // Elven Forest 20 points = ï¿½ï¿½ï¿½Fï¿½ËªL - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_06", new int[] { 29294, 74968, -3776, 30 }); // Elven Fortress 30 points = ï¿½ï¿½ï¿½Fï¿½ï¿½ï¿½aï¿½ï¿½ï¿½nï¿½ï¿½ - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_07", new int[] { -10612, 75881, -3592, 50 }); // Neutral Zone 50 points = ï¿½ï¿½ï¿½ß¦aï¿½a - 50 ï¿½Iï¿½ï¿½
		// ï¿½Â·tï¿½ï¿½ï¿½Fï¿½ï¿½ï¿þýDark Elf Village Teleporters
		TELEPORTERS.put("TELE_08", new int[] { -22224, 14168, -3232, 30 }); // Dark Forest 30 points = ï¿½Â·tï¿½ï¿½ï¿½Fï¿½ËªL - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_09", new int[] { -21966, 40544, -3192, 30 }); // Swampland 30 points = ï¿½hï¿½Aï¿½aï¿½a - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_10", new int[] { -61095, 75104, -3352, 90 }); // Spider Nest 90 points = ï¿½jï¿½ï¿½_ï¿½ï¿½ - 90 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_11", new int[] { -10612, 75881, -3592, 50 }); // Neutral Zone 50 points = ï¿½ï¿½ï¿½ß¦aï¿½a - 50 ï¿½Iï¿½ï¿½
		// ï¿½~ï¿½Hï¿½ï¿½ï¿þýOrc Village Teleporters
		TELEPORTERS.put("TELE_12", new int[] { -4190, -80040, -2696, 50 }); // Immortal Plateau Southern Region 50 points = ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½nï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_13", new int[] { -10983, -117484, -2464, 30 }); // The Immortal Plateau 30 points = ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_14", new int[] { 9340, -112509, -2536, 40 }); // Cave of Trials 40 points = ï¿½Õ½mï¿½}ï¿½] - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_15", new int[] { 8652, -139941, -1144, }); // Frozen Waterfall 40 points = ï¿½Bï¿½ï¿½ï¿½rï¿½ï¿½ - 40 ï¿½Iï¿½ï¿½
		// ï¿½Gï¿½Hï¿½ï¿½ï¿þýDwarven Village Teleporters
		TELEPORTERS.put("TELE_16", new int[] { 139714, -177456, -1536, 20 }); // Abandoned Coal Mines 20 points = ï¿½oï¿½ï¿½ï¿½qï¿½| - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_17", new int[] { 169008, -208272, -3504, 60 }); // Eastern Mining Zone (Northeastern Shore) 60 points = ï¿½sï¿½ï¿½ï¿½qï¿½ÏªFï¿½ï¿½ï¿½]ï¿½Fï¿½_ï¿½ï¿½ï¿½ï¿½^ - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_18", new int[] { 136910, -205082, -3664, 30 }); // Western Mining Zone (Central Shore) 30 points = ï¿½sï¿½ï¿½ï¿½qï¿½Ï¦è³¡ï¿½]ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½^ - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_19", new int[] { 171946, -173352, 3440, 280 }); // Mithril Mines Western Entrance 280 points = ï¿½Ì¯ï¿½ï¿½ï¿½ï¿½qï¿½sï¿½ï¿½ï¿½ï¿½Jï¿½f - 280 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_20", new int[] { 178591, -184615, -360, 300 }); // Mithril Mines Eastern Entrance 300 points = ï¿½Ì¯ï¿½ï¿½ï¿½ï¿½qï¿½sï¿½_ï¿½ï¿½Jï¿½f - 300 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½Ñ¨Ï§ï¿½ï¿½Sï¿½ï¿½ï¿½Ç°e Kamael Village No Teleporters
		// ï¿½jï¿½|ï¿½Bï¿½ï¿½ï¿þýThe Village of Gludin Teleporters
		TELEPORTERS.put("TELE_21", new int[] { -44763, 203497, -3592, 50 }); // Langk Lizardman Dwelling 50 points = ï¿½Ô§Jï¿½hç°¤Hï¿½Lï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_22", new int[] { -63736, 101522, -3552, 40 }); // Fellmere Harvest Grounds 40 points = ï¿½ï¿½ï¿½Ìºï¿½ï¿½Ä¶ï¿½ï¿½ï¿½ - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_23", new int[] { -75437, 168800, -3632, 20 }); // Windmill Hill 20 points = ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½sï¿½Y - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_24", new int[] { -53001, 191425, -3568, 50 }); // Forgotten Temple 50 points = ï¿½ï¿½Ñ¯ï¿½ï¿½ï¿þý- 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_25", new int[] { -89763, 105359, -3576, 50 }); // Orc Barracks 50 points = ï¿½gï¿½ï¿½Jï¿½~ï¿½Hï¿½Lï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_26", new int[] { -88539, 83389, -2864, 70 }); // Windy Hill 70 points = ï¿½ï¿½ï¿½ï¿½ï¿½Cï¿½ï¿½ - 70 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_27", new int[] { -49853, 147089, -2784, 30 }); // Abandoned Camp 30 points = ï¿½ï¿½oï¿½ï¿½ï¿½ï¿½ï¿þý- 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_28", new int[] { -16526, 208032, -3664, 90 }); // Wastelands 90 points = ï¿½ï¿½ï¿þý- 90 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_29", new int[] { -42256, 198333, -2800, 100 }); // Red Rock Ridge 100 points = ï¿½ï¿½ï¿½ï¿½ï¿½Wï¿½u - 100 ï¿½Iï¿½ï¿½
		// ï¿½jï¿½|ï¿½Bï¿½ï¿½ï¿½ï¿½ Gludio Teleporters
		TELEPORTERS.put("TELE_30", new int[] { -41248, 122848, -2904, 20 }); // Ruins of Agony 20 points = ï¿½dï¿½sï¿½oï¿½V - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_31", new int[] { -19120, 136816, -3752, 20 }); // Ruins of Despair 20 points = ï¿½ï¿½ï¿½ï¿½oï¿½V - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_32", new int[] { -9959, 176184, -4160, 60 }); // Ant Cave 60 points = ï¿½ï¿½ï¿½Æ¬}ï¿½] - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_33", new int[] { -28327, 155125, -3496, 40 }); // Windawood Manor 40 points = ï¿½Å¹Fï¿½ï¿½wï¿½ï¿½ï¿þý- 40 ï¿½Iï¿½ï¿½
		// ï¿½fï¿½ï¿½ Dion Teleporters
		TELEPORTERS.put("TELE_34", new int[] { 5106, 126916, -3664, 20 }); // Cruma Marshlands 20 points = ï¿½Jï¿½|ï¿½ï¿½ï¿½hï¿½A - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_35", new int[] { 17225, 114173, -3440, 60 }); // Cruma Tower 60 points = ï¿½Jï¿½|ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_36", new int[] { 47382, 111278, -2104, 50 }); // Fortress of Resistance 50 points = ï¿½Ï§Ü­xï¿½Ú¾Ú¦a - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_37", new int[] { 630, 179184, -3720, 40 }); // Plains of Dion 40 points = ï¿½fï¿½ï¿½ï¿½ï¿½ï¿½ï¿½a - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_38", new int[] { 34475, 188095, -2976, 80 }); // Bee Hive 80 points = ï¿½eï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - 80 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_39", new int[] { 60374, 164301, -2856, 100 }); // Tanor Canyon 100 points = ï¿½ï¿½Õ®lï¿½ï¿½ - 100 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿þýFloran Village Teleporters
		TELEPORTERS.put("TELE_40", new int[] { 50568, 152408, -2656, 40 }); // Execution Grounds 40 points = ï¿½Dï¿½ï¿½ - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_41", new int[] { 33565, 162393, -3600, 40 }); // Tanor Canyon (West side) 40 points = ï¿½ï¿½Õ®lï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_42", new int[] { 26810, 172787, -3376, 20 }); // Floran Agricultural Area 20 points = ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½}ï¿½ï¿½ï¿½a - 20 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½ï¿½Wï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ Heine Teleporters
		TELEPORTERS.put("TELE_43", new int[] { 87691, 162835, -3563, 300 }); // Field of Silence 300 points = ï¿½ï¿½ï¿½Rï¿½ï¿½ï¿½ï¿½ - 300 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_44", new int[] { 82192, 226128, -3664, 150 }); // Field of Whispers 150 points = ï¿½Ó»yï¿½ï¿½ï¿½ï¿½ - 150 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_45", new int[] { 115583, 192261, -3488, 60 }); // Entrance to Alligator Islands 60 points = ï¿½sï¿½ï¿½ï¿½q - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_46", new int[] { 84413, 234334, -3656, 60 }); // Garden of Eva 60 points = ï¿½ì«½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½xï¿½ï¿½ - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_47", new int[] { 149518, 195280, -3736, 180 }); // Isle of Prayer 180 points = ï¿½ï¿½ï¿½Ù¤ï¿½ï¿½q - 180 ï¿½Iï¿½ï¿½
		// ï¿½_ï¿½ï¿½ Giran Teleporters
		TELEPORTERS.put("TELE_48", new int[] { 73024, 118485, -3688, 50 }); // Dragon Valley 50 points = ï¿½sï¿½ï¿½ï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_49", new int[] { 131557, 114509, -3712, 180 }); // Antharas Lair 180 points = ï¿½wï¿½ï¿½ç´µï¿½}ï¿½] - 180 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_50", new int[] { 43408, 206881, -3752, 150 }); // Devil Isle 150 points = ï¿½cï¿½]ï¿½q - 150 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_51", new int[] { 85546, 131328, -3672, 30 }); // Brekas Stronghold 30 points = ï¿½ï¿½ï¿½ï¿½dï¿½ï¿½ï¿½_ï¿½ï¿½ - 30 ï¿½Iï¿½ï¿½
		// ï¿½Ú·ç«°ï¿½ï¿½ Oren Teleporters
		TELEPORTERS.put("TELE_52", new int[] { 76839, 63851, -3648, 20 }); // Sel Mahum Training Grounds (West Gate) 20 points = ï¿½vï¿½ï¿½ï¿½ï¿½Vï¿½ï¿½ï¿½]ï¿½ï¿½ï¿½^ - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_53", new int[] { 87252, 85514, -3056, 50 }); // Plains of Lizardmen 50 points = ï¿½hç°¯ï¿½ï¿þý- 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_54", new int[] { 91539, -12204, -2440, 130 }); // Outlaw Forest 130 points = ï¿½Lï¿½kï¿½Ìªï¿½ï¿½ËªL - 130 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_55", new int[] { 64328, 26803, -3768, 70 }); // Sea of Spores 70 points = ï¿½Uï¿½lï¿½ï¿½ï¿½ï¿½ - 70 ï¿½Iï¿½ï¿½
		// ï¿½yï¿½Hï¿½ï¿½ï¿þýHunters Village Teleporters
		TELEPORTERS.put("TELE_56", new int[] { 124904, 61992, -3920, 40 }); // Southern Pathway of Enchanted Valley 40 points = ï¿½ï¿½ï¿½ë¨¦ï¿½]ï¿½nï¿½ï¿½^ - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_57", new int[] { 104426, 33746, -3800, 90 }); // Northern Pathway of Enchanted Valley 90 points = ï¿½ï¿½ï¿½ë¨¦ï¿½]ï¿½_ï¿½ï¿½^ - 90 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_58", new int[] { 142065, 81300, -3000, 50 }); // Entrance to the Forest of Mirrors 50 points = ï¿½è¤§ï¿½ËªL - 50 ï¿½Iï¿½ï¿½
		// ï¿½È¤Bï¿½ï¿½ï¿½ï¿½ Aden Teleporters
		TELEPORTERS.put("TELE_59", new int[] { 168217, 37990, -4072, 50 }); // Forsaken Plains 50 points = ï¿½Ñ«oï¿½ï¿½ï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_60", new int[] { 184742, 19745, -3168, 80 }); // Seal of Shilen 80 points = ï¿½uï¿½Yï¿½Ê¦L - 80 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_61", new int[] { 142065, 81300, -3000, 110 }); // Forest of Mirrors 110 points = ï¿½è¤§ï¿½ËªL - 110 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_62", new int[] { 155310, -16339, -3320, 170 }); // Blazing Swamp 170 points = ï¿½Uï¿½Nï¿½ï¿½ï¿½hï¿½A - 170 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_63", new int[] { 183543, -14974, -2776, 170 }); // Fields of Massacre 170 points = ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½jï¿½a - 170 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_64", new int[] { 106517, -2871, -3416, 150 }); // Ancient Battleground 150 points = ï¿½jï¿½Ô³ï¿½ - 150 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_65", new int[] { 170838, 55776, -5280, 160 }); // Silent Valley 160 points = ï¿½Iï¿½Rï¿½ï¿½ï¿½ï¿½ - 160 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_66", new int[] { 114649, 11115, -5120, 110 }); // ToI 110 points = ï¿½ÆºCï¿½ï¿½ï¿½ï¿½ - 110 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_67", new int[] { 174491, 50942, -4360, 190 }); // The Giant's Cave 190 points = ï¿½ï¿½ï¿½Hï¿½}ï¿½Þ¤Jï¿½f - 190 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½ï¿½Fï¿½Sï¿½ï¿½ï¿½ï¿½ Goddard Teleporters
		TELEPORTERS.put("TELE_68", new int[] { 125740, -40864, -3736, 110 }); // Varka Silenos Stronghold 110 points = ï¿½Ú·ï¿½dï¿½É°Ç¿Õ´ï¿½ï¿½Lï¿½ï¿½ - 110 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_69", new int[] { 146990, -67128, -3640, 50 }); // Ketra Orc Outpost 50 points = ï¿½Ö¯Sï¿½ï¿½ï¿½~ï¿½Hï¿½eï¿½ï¿½ï¿½a - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_70", new int[] { 144880, -113468, -2560, 240 }); // Hot Springs 240 points = ï¿½Å¬uï¿½aï¿½a - 240 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_71", new int[] { 165054, -47861, -3560, 60 }); // Wall of Argos 60 points = ï¿½Èºï¿½ï¿½jï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ - 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_72", new int[] { 106414, -87799, -2920, 250 }); // Monastery of silence 250 points = ï¿½Iï¿½qï¿½×¹Dï¿½| - 250 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_73", new int[] { 169018, -116303, -2432, 250 }); // Forge of the Gods 250 points = ï¿½Ñ¯ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½lï¿½Jï¿½f - 250 ï¿½Iï¿½ï¿½
		// ï¿½|ï¿½]ï¿½ï¿½ï¿½ï¿½ Rune Teleporters
		TELEPORTERS.put("TELE_74", new int[] { 53516, -82831, -2700, 120 }); // Wild Beast Pastures 120 points = ï¿½rï¿½~ï¿½ñªª³ï¿½ - 120 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_75", new int[] { 65307, -71445, -3688, 100 }); // Valley of Saints 100 points = ï¿½tï¿½Ì¤ï¿½ï¿½ï¿½ - 100 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_76", new int[] { 52107, -54328, -3152, 30 }); // Forest of the Dead 300 points = ï¿½`ï¿½Ìªï¿½ï¿½ËªL - 30 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_77", new int[] { 69340, -50203, -3288, 80 }); // Swamp of Screams 80 points = ï¿½dï¿½ãªºï¿½hï¿½A - 80 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_78", new int[] { 106414, -87799, -2920, 350 }); // Monastery of Silence 350 points = ï¿½Iï¿½qï¿½×¹Dï¿½| - 350 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_79", new int[] { 89513, -44800, -2136, 230 }); // Stakato 230 points = ï¿½qï¿½ï¿½dï¿½Ý±_ï¿½ï¿½ - 230 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_80", new int[] { 11235, -24026, -3640, 160 }); // Primeval Isle 160 points = ï¿½ï¿½lï¿½ï¿½ï¿½qï¿½Xï¿½Y - 160 ï¿½Iï¿½ï¿½
		// ï¿½×¥[ï¿½Sï¿½ï¿½ï¿½ï¿½ Schuttgart Teleporters
		TELEPORTERS.put("TELE_81", new int[] { 47692, -115745, -3744, 240 }); // Crypt of Disgrace 240 points = ï¿½ï¿½ï¿½dï¿½Ó¦a - 240 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_82", new int[] { 111965, -154172, -1528, 40 }); // Plunderous Plains 400 points = ï¿½ï¿½ï¿½Üªï¿½ï¿½î³¥ - 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_83", new int[] { 68693, -110438, -1904, 190 }); // Den of Evil 190 points = ï¿½cï¿½Fï¿½_ï¿½ï¿½ - 190 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_84", new int[] { 91280, -117152, -3928, 60 }); // Pavel Ruins 60 points = ï¿½ï¿½ï¿½ñº¸¿ï¿½ï¿þý- 60 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_85", new int[] { 113903, -108752, -856, 90 }); // Ice Merchant Cabin 90 points = ï¿½Bï¿½ï¿½ï¿½Ó¶ï¿½ï¿½nï¿½Ï¦a - 90 ï¿½Iï¿½ï¿½
		// ï¿½ï¿½ï¿½Å¾Ç°| Hardin's Private Academy Teleporters
		TELEPORTERS.put("TELE_86", new int[] { 73024, 118485, -3688, 50 }); // Dragon Valley 50 points = ï¿½sï¿½ï¿½ï¿½ï¿½ - 50 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_87", new int[] { 131557, 114509, -3712, 80 }); // Antharas Lair 80 points = ï¿½wï¿½ï¿½ç´µï¿½}ï¿½] - 80 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_88", new int[] { 113553, 134813, -3540, 40 }); // Gorgon Flower Garden 40 points = ï¿½ï¿½ï¿½Öªï¿½ï¿½ï¿½ï¿þý- 40 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_89", new int[] { 60374, 164301, -2856, 140 }); // Tanor Canyon 140 points = ï¿½ï¿½Õ®lï¿½ï¿½ - 140 ï¿½Iï¿½ï¿½
		// ï¿½Hï¿½ï¿½ï¿þýIvory Tower Teleporters
		TELEPORTERS.put("TELE_90", new int[] { 106517, -2871, -3416, 90 }); // Ancient Battleground 90 points = ï¿½jï¿½Ô³ï¿½ - 90 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_91", new int[] { 93218, 16969, -3904, 20 }); // Forest of Evil 20 points = ï¿½]ï¿½Dï¿½ï¿½ï¿½ËªL - 20 ï¿½Iï¿½ï¿½
		TELEPORTERS.put("TELE_92", new int[] { 67097, 68815, -3648, 120 }); // Timak Outpost 110 points = ï¿½ï¿½ï¿½ï¿½ï¿½Jï¿½eï¿½ï¿½ï¿½a - 110 ï¿½Iï¿½ï¿½
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
			if (player.getLevel() < 55)
			{
				htmltext = "skill_nolevel.htm";
			}
			else if (player.getPcBangPoints() >= POINTSSKILL.get(event)[2])
			{
				final int cost = player.getPcBangPoints() - (POINTSSKILL.get(event)[2]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(POINTSSKILL.get(event)[2]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), POINTSSKILL.get(event)[2], false, false, 1));
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
			if (player.getSummon() == null || !player.getSummon().isServitor())
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= PETSKILL.get(event)[2])
			{
				final int cost = player.getPcBangPoints() - (PETSKILL.get(event)[2]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(PETSKILL.get(event)[2]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), PETSKILL.get(event)[2], false, false, 1));
				npc.setTarget(player.getSummon());
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
				final int cost = player.getPcBangPoints() - (TELEPORTERS.get(event)[3]);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(TELEPORTERS.get(event)[3]);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), TELEPORTERS.get(event)[3], false, false, 1));
				player.teleToLocation(TELEPORTERS.get(event)[0], TELEPORTERS.get(event)[1], TELEPORTERS.get(event)[2]);
				return null;
			}
			htmltext = "nopoint.htm";
		}
		else if (event.equalsIgnoreCase("tele"))
		{
			htmltext = npc.getNpcId() + "-tele.htm";
		}
		else if (event.equalsIgnoreCase("wyvern"))
		{
			if (player.getPcBangPoints() >= 2500)
			{
				final int cost = player.getPcBangPoints() - (2500);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(2500);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), 2500, false, false, 1));
				player.mount(12621, 0, true);
				player.addSkill(SkillTable.FrequentSkill.WYVERN_BREATH.getSkill());
				return null;
			}
			htmltext = "nopoint.htm";
		}
		else if (event.equalsIgnoreCase("warrior"))
		{
			if (player.getLevel() < 55)
			{
				htmltext = "skill_nolevel.htm";
			}
			else if (player.getPcBangPoints() >= 5600)
			{
				final int cost = player.getPcBangPoints() - (5600);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(5600);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), 5600, false, false, 1));
				npc.setTarget(player);
				npc.doCast(SkillTable.getInstance().getInfo(4397,2));	// ï¿½gï¿½Ô¤hï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4393,3));	// ï¿½Oï¿½qï¿½jï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4392,3));	// ï¿½Oï¿½@ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4404,3));	// ï¿½zï¿½Iï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4396,2));	// ï¿½]ï¿½kï¿½Ì»ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4405,3));	// ï¿½ï¿½ï¿½ï¿½ï¿½Oï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4403,3));	// ï¿½É¤ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4398,3));	// ï¿½ï¿½ï¿½Ö¤ï¿½ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4394,4));	// ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½4ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4402,2));	// ï¿½tï¿½×¿Eï¿½o2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4406,3));	// ï¿½Ó±ï¿½ï¿½N3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4399,3));	// ï¿½lï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½
				htmltext = "skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("pet_warrior"))
		{
			if (player.getSummon() == null || !player.getSummon().isServitor())
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= 4000)
			{
				final int cost = player.getPcBangPoints() - (4000);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(4000);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), 4000, false, false, 1));
				npc.setTarget(player.getSummon());
				npc.doCast(SkillTable.getInstance().getInfo(4397,1));	// ï¿½gï¿½Ô¤hï¿½ï¿½1ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4393,2));	// ï¿½Oï¿½qï¿½jï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// ï¿½Oï¿½@ï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4404,2));	// ï¿½zï¿½Iï¿½ï¿½ï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4396,1));	// ï¿½]ï¿½kï¿½Ì»ï¿½1ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4405,2));	// ï¿½ï¿½ï¿½ï¿½ï¿½Oï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4403,2));	// ï¿½É¤ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4398,2));	// ï¿½ï¿½ï¿½Ö¤ï¿½ï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4394,3));	// ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4402,1));	// ï¿½tï¿½×¿Eï¿½o1ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4406,2));	// ï¿½Ó±ï¿½ï¿½N2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4399,2));	// ï¿½lï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½
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
				final int cost = player.getPcBangPoints() - (3000);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(3000);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), 3000, false, false, 1));
				npc.setTarget(player);
				npc.doCast(SkillTable.getInstance().getInfo(4397,2));	// ï¿½gï¿½Ô¤hï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4396,2));	// ï¿½]ï¿½kï¿½Ì»ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// ï¿½Oï¿½@ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4395,4));	// ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½4ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4401,3));	// ï¿½]ï¿½Oï¿½Ê¤ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4400,3));	// ï¿½Fï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½
				htmltext = "skill_info.htm";
			}
			else
			{
				htmltext = "nopoint.htm";
			}
		}
		else if (event.equalsIgnoreCase("pet_mage"))
		{
			if (player.getSummon() == null || !player.getSummon().isServitor())
			{
				htmltext = "nosummon.htm";
			}
			else if (player.getPcBangPoints() >= 2100)
			{
				final int cost = player.getPcBangPoints() - (2100);
				player.setPcBangPoints(cost);
				SystemMessage smsgpc = SystemMessage.getSystemMessage(SystemMessageId.USING_S1_PCPOINT);
				smsgpc.addNumber(2100);
				player.sendPacket(smsgpc);
				player.sendPacket(new ExPCCafePointInfo(player.getPcBangPoints(), 2100, false, false, 1));
				npc.setTarget(player.getSummon());
				npc.doCast(SkillTable.getInstance().getInfo(4397,1));	// ï¿½gï¿½Ô¤hï¿½ï¿½1ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4396,1));	// ï¿½]ï¿½kï¿½Ì»ï¿½1ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4392,2));	// ï¿½Oï¿½@ï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4391,2));	// ï¿½ï¿½ï¿½ï¿½ï¿½eï¿½ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4395,3));	// ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½3ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4401,2));	// ï¿½]ï¿½Oï¿½Ê¤ï¿½2ï¿½ï¿½
				npc.doCast(SkillTable.getInstance().getInfo(4400,2));	// ï¿½Fï¿½ï¿½ï¿½ï¿½ï¿þýï¿½ï¿½
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