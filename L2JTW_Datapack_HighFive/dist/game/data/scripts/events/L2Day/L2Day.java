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
package events.L2Day;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.l2jserver.gameserver.Announcements;
import com.l2jserver.gameserver.datatables.EventDroplist;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.script.DateRange;
import com.l2jserver.util.Rnd;

public class L2Day extends Quest
{
	private static final String EVENT_DATE = "28 08 2011-05 10 2011";   // Change date as you want
	private static final DateRange EVENT_DATES = DateRange.parse(EVENT_DATE, new SimpleDateFormat("dd MM yyyy", Locale.US));
	private static final String[] EVENT_ANNOUNCE = {"L2Day-���r�ʦL�u�Y�A�G����"};
	private static final Date EndDate = EVENT_DATES.getEndDate();
	private static final Date currentDate = new Date();
	
	//Items A�BC�BE�BF�BG�BI�BL�BN�BO�BS�BT�BII
	private final static int letterA  = 3875;
	private final static int letterC  = 3876;
	private final static int letterE  = 3877;
	private final static int letterF  = 3878;
	private final static int letterG  = 3879;
	private final static int letterI  = 3881;
	private final static int letterL  = 3882;
	private final static int letterN  = 3883;
	private final static int letterO  = 3884;
	private final static int letterS  = 3886;
	private final static int letterT  = 3887;
	private final static int letterII = 3888;
	private final static int[] dropList = { letterA, letterC, letterE, letterF, letterG, letterI, letterL, letterN, letterO, letterS, letterT, letterII };
	private int[] dropCount = {1,1};
	private final static int dropChance = 25000;	// actually 2.5%
												// Kamael            TI         Dark Elf      Dwarf           Elf           Orc          Gludin         Gludio         Dion           Giran             Heine         Oren         Hunters         Aden          Goddard        Rune       Schuttgart
	private final static int[] EventSpawnX = { -119492,-117242, -84415,-84021, 9924,11548, 115087,116198, 46907,45542, -45273,-45368, -81028,-83158, -13726,-14133, 16110,17273, 82143,83037,81757, 111003,108423, 81986,81081, 115883,117350, 147198,148558, 148210,147415, 43962,43165, 86863,87791,};
												// Kamael        TI         Dark Elf         Dwarf           Elf            Orc           Gludin         Gludio          Dion             Giran               Heine         Oren        Hunters       Aden         Goddard         Rune         Schuttgart
	private final static int[] EventSpawnY = { 44877,46843, 244813,243049, 16328,17597, -178360,-182696, 50860,48348, -112764,-114106, 150037,150994, 122116,123862, 142851,144997, 148614,149328,146487, 218924,221873, 53725,56116, 76384,76703, 25615,26803, -55784,-55432, -47707,-48465, -142917,-142236,};
												// Kamael   TI         Dark Elf     Dwarf         Elf         Orc       Gludin       Gludio        Dion           Giran            Heine        Oren        Hunters       Aden        Goddard      Rune     Schuttgart
	private final static int[] EventSpawnZ = { 363,363, -3737,-3734, -4578,-4589, -890,-1513, -3000,-3064, -244,-244, -3048,-3133, -2993,-3121, -2714,-3039, -3475,-3473,-3541, -3547,-3602, -1500,-1564, -2717,-2699, -2017,-2209, -2785,-2741, -801,-801, -1345,-1348,};
												// Kamael        TI      Dark Elf    Dwarf       Elf      Orc        Gludin       Gludio        Dion         Giran            Heine        Oren        Hunters       Aden        Goddard       Rune       Schuttgart
	private final static int[] EventSpawnH = { 23321,48137, 57343,2902, 63027,46936, 0,63635, 7497,49816, 0,15612, 62180,65142, 16383,39765, 18106,22165, 612,32199,32767, 14661,48655, 65051,32767, 64055,45557, 14613,32024, 60699,47429, 48698,17559, 27497,43140,};
	
	private final static int EventNPC = 4313;
	
	private static List<L2Npc> eventManagers = new ArrayList<>();
	
	private static boolean L2DayEvent = false;
	
	public L2Day(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		EventDroplist.getInstance().addGlobalDrop(dropList, dropCount, dropChance, EVENT_DATES);
		
		Announcements.getInstance().addEventAnnouncement(EVENT_DATES,EVENT_ANNOUNCE); 
		
		addStartNpc(EventNPC);
		addFirstTalkId(EventNPC);
		addTalkId(EventNPC);
		startQuestTimer("EventCheck",1800000,null,null);
		
		if (EVENT_DATES.isWithinRange(currentDate))
			L2DayEvent = true;
		
		if (L2DayEvent)
		{
			_log.info("L2Day-���r�ʦL�u�Y�A�G���� - ON");
			
			for (int i = 0; i < EventSpawnX.length; i++)
			{
				L2Npc eventManager = addSpawn(EventNPC,EventSpawnX[i],EventSpawnY[i],EventSpawnZ[i],EventSpawnH[i],false,0);
				eventManagers.add(eventManager);
			}
		}
		else
		{
			_log.info("L2Day-���r�ʦL�u�Y�A�G���� - OFF");
			
			Calendar endWeek = Calendar.getInstance();
			endWeek.setTime(EndDate);
			endWeek.add(Calendar.DATE, 7);
			
			if (EndDate.before(currentDate) && endWeek.getTime().after(currentDate))
			{
				for (int i = 0; i < EventSpawnX.length; i++)
				{
					L2Npc eventManager = addSpawn(EventNPC,EventSpawnX[i],EventSpawnY[i],EventSpawnZ[i],EventSpawnH[i],false,0);
					eventManagers.add(eventManager);
				}
			}
		}
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st;
		int prize;
		
		if (npc == null)
		{
			if (event.equalsIgnoreCase("EventCheck"))
			{
				startQuestTimer("EventCheck",1800000,null,null);
				boolean Event1 = false;
				
				if (EVENT_DATES.isWithinRange(currentDate))
					Event1 = true;
				
				if (!L2DayEvent && Event1)
				{
					L2DayEvent = true;
					_log.info("L2Day-���r�ʦL�u�Y�A�G���� - ON");
					Announcements.getInstance().announceToAll("L2Day-���r�ʦL�u�Y�A�G���ʡA�Ш�U������-��r���îa�u�ѨϿߡv");
					
					for (int i = 0; i < EventSpawnX.length; i++)
					{
						L2Npc eventManager = addSpawn(EventNPC,EventSpawnX[i],EventSpawnY[i],EventSpawnZ[i],EventSpawnH[i],false,0);
						eventManagers.add(eventManager);
					}
				}
				else if (L2DayEvent && !Event1)
				{
					L2DayEvent = false;
					_log.info("L2Day-���r�ʦL�u�Y�A�G���� - OFF");
					for (L2Npc eventManager : eventManagers)
					{
						eventManager.deleteMe();
					}
				}
			}
		}
		else if (player != null && event.equalsIgnoreCase("LINEAGEII"))
		{
			st = player.getQuestState(getName());
			
			if ( st.getQuestItemsCount(letterL) >= 1
				&& st.getQuestItemsCount(letterI) >= 1
				&& st.getQuestItemsCount(letterN) >= 1
				&& st.getQuestItemsCount(letterE) >= 2
				&& st.getQuestItemsCount(letterA) >= 1
				&& st.getQuestItemsCount(letterG) >= 1
				&& st.getQuestItemsCount(letterII) >= 1)
			{
				st.takeItems(letterL,1);
				st.takeItems(letterI,1);
				st.takeItems(letterN,1);
				st.takeItems(letterE,2);
				st.takeItems(letterA,1);
				st.takeItems(letterG,1);
				st.takeItems(letterII,1);
				
				prize = Rnd.get(1000);
				
				/**
				 * ��~��ƨӷ� http://lineage2.plaync.com.tw/Event/event/110902/event4.asp
				 * ������uLINEAGEII�v�A�N�i�o��U�C��~���@�G
				 * - �ڷŧ٫�
				 * - ���ǪZ��
				 * - �j���-���q14~16
				 * - L2Day-���֪��_�����b2�i
				 * - L2Day-���֪���^���b2�i
				 * - �W�j�O������O�v¡�Ĥ�5��
				 * - ��r���îa��§��
				 */
				
				if (prize <= 5)
					st.giveItems(6658,1);  // 1 - �ڷŧ٫�
				else if (prize <= 10)
					st.giveItems(52,1);    // 1 - ������M
				else if (prize <= 10)
					st.giveItems(13457,1); // 1 - ���Ǥ��b
				else if (prize <= 10)
					st.giveItems(13458,1); // 1 - ���Ǳ��b
				else if (prize <= 10)
					st.giveItems(13459,1); // 1 - �����z�b
				else if (prize <= 10)
					st.giveItems(13460,1); // 1 - ���ǹ^�M
				else if (prize <= 10)
					st.giveItems(13461,1); // 1 - ���ǾԤ�
				else if (prize <= 10)
					st.giveItems(13462,1); // 1 - ���ǭ��ɪ�
				else if (prize <= 10)
					st.giveItems(13463,1); // 1 - ���Ǵ_����
				else if (prize <= 10)
					st.giveItems(13464,1); // 1 - ���ǳ���
				else if (prize <= 10)
					st.giveItems(13465,1); // 1 - ���ǳN��
				else if (prize <= 10)
					st.giveItems(13466,1); // 1 - ���Ǹ֧�
				else if (prize <= 10)
					st.giveItems(13467,1); // 1 - ���ǧ�}
				else if (prize <= 10)
					st.giveItems(13468,1); // 1 - �����g�w
				else if (prize <= 10)
					st.giveItems(13884,1); // 1 - ������P��
				else if (prize <= 50)
					st.giveItems(13071,1); // 1 - ����j���-���q16
				else if (prize <= 50)
					st.giveItems(13072,1); // 1 - �Ŧ�j���-���q16
				else if (prize <= 50)
					st.giveItems(13073,1); // 1 - ���j���-���q16
				else if (prize <= 100)
					st.giveItems(10480,1); // 1 - ����j���-���q15
				else if (prize <= 100)
					st.giveItems(10481,1); // 1 - �Ŧ�j���-���q15
				else if (prize <= 100)
					st.giveItems(10482,1); // 1 - ���j���-���q15
				else if (prize <= 200)
					st.giveItems(9570,1);  // 1 - ����j���-���q14
				else if (prize <= 200)
					st.giveItems(9571,1);  // 1 - �Ŧ�j���-���q14
				else if (prize <= 200)
					st.giveItems(9572,1);  // 1 - ���j���-���q14
				else if (prize <= 350)
					st.giveItems(3959,1);  // 1 - L2Day-���֪��_�����b2�i
				else if (prize <= 400)
					st.giveItems(3958,1);  // 1 - L2Day-���֪���^���b2�i
				else if (prize <= 500)
					st.giveItems(21730,1); // 1 - ��r���îa��§��
				else
					st.giveItems(14701,5); // 5 - �W�j�O������O�v¡�Ĥ�5��
			}
			else
				htmltext = "4313-03.htm";
		}
		else if (player != null && event.equalsIgnoreCase("NCSOFT"))
		{
			st = player.getQuestState(getName());
			
			if (st.getQuestItemsCount(letterN) >= 1
				&& st.getQuestItemsCount(letterC) >= 1
				&& st.getQuestItemsCount(letterS) >= 1
				&& st.getQuestItemsCount(letterO) >= 1
				&& st.getQuestItemsCount(letterF) >= 1
				&& st.getQuestItemsCount(letterT) >= 1)
			{
				st.takeItems(letterN,1);
				st.takeItems(letterC,1);
				st.takeItems(letterS,1);
				st.takeItems(letterO,1);
				st.takeItems(letterF,1);
				st.takeItems(letterT,1);
				
				prize = Rnd.get(1000);
				
				/**
				 * ������uNCSOFT�v�A�N�i�o��U�C��~���@�G
				 * - ���Ƥk��٫�
				 * - ���Ǩ���
				 * - �ݩʤ���
				 * - L2Day-���֪��_�����b2�i
				 * - L2Day-���֪���^���b2�i
				 * - �W�j�O������O�v¡�Ĥ�5��
				 * - ��r���îa��§��
				 */
				
				if (prize <= 5)
					st.giveItems(6660,1);  // 1 - ���Ƥk��٫�
				else if (prize <= 10)
					st.giveItems(13143,1); // 1 - �ʦL�������Y��
				else if (prize <= 10)
					st.giveItems(13144,1); // 1 - �ʦL�����ǥ��Y��
				else if (prize <= 10)
					st.giveItems(13145,1); // 1 - �ʦL�������Y�T
				else if (prize <= 10)
					st.giveItems(14105,1); // 1 - �ʦL�����ǯݥ�
				else if (prize <= 10)
					st.giveItems(14106,1); // 1 - �ʦL�����ǥ֯ݥ�
				else if (prize <= 10)
					st.giveItems(14107,1); // 1 - �ʦL�����ǥ~��
				else if (prize <= 10)
					st.giveItems(14108,1); // 1 - �ʦL�������H��
				else if (prize <= 10)
					st.giveItems(14109,1); // 1 - �ʦL�������@��
				else if (prize <= 10)
					st.giveItems(14110,1); // 1 - �ʦL�����ǹu
				else if (prize <= 10)
					st.giveItems(14112,1); // 1 - �ʦL�����ǥ��H��
				else if (prize <= 10)
					st.giveItems(14113,1); // 1 - �ʦL�����ǥ֤�M
				else if (prize <= 10)
					st.giveItems(14114,1); // 1 - �ʦL�����ǥֹu
				else if (prize <= 10)
					st.giveItems(14115,1); // 1 - �ʦL�����Ǫ���
				else if (prize <= 10)
					st.giveItems(14116,1); // 1 - �ʦL�����Ǥ�M
				else if (prize <= 10)
					st.giveItems(14117,1); // 1 - �ʦL�����Ǿc
				else if (prize <= 10)
					st.giveItems(13887,1); // 1 - �ʦL�����ǲŦL
				else if (prize <= 10)
					st.giveItems(14111,1); // 1 - �ʦL�����ǽì�
				else if (prize <= 125)
					st.giveItems(9552,1);  // 1 - ��������
				else if (prize <= 125)
					st.giveItems(9553,1);  // 1 - ��������
				else if (prize <= 125)
					st.giveItems(9554,1);  // 1 - �a������
				else if (prize <= 125)
					st.giveItems(9555,1);  // 1 - ��������
				else if (prize <= 125)
					st.giveItems(9556,1);  // 1 - �t������
				else if (prize <= 125)
					st.giveItems(9557,1);  // 1 - �t������
				else if (prize <= 350)
					st.giveItems(3959,2);  // 2 - L2Day-���֪��_�����b2�i
				else if (prize <= 400)
					st.giveItems(3958,2);  // 2 - L2Day-���֪���^���b2�i
				else if (prize <= 500)
					st.giveItems(21730,1); // 1 - ��r���îa��§��
				else
					st.giveItems(14701,5); // 5 - �W�j�O������O�v¡�Ĥ�5��
			}
			else
				htmltext =  "4313-03.htm";
		}
		else if (event.equalsIgnoreCase("chat0"))
			htmltext =  "4313.htm";
		else if (event.equalsIgnoreCase("chat1"))
			htmltext =  "4313-02.htm";
		
		return htmltext;
	}
	
	@Override
	public String onFirstTalk(L2Npc npc,L2PcInstance player)
	{
		QuestState st = player.getQuestState(getName());
		if (st == null)
			st = newQuestState(player);
	
		return "4313.htm";
	}
	
	public static void main(String[] args)
	{
		new L2Day(-1, "L2Day", "events");
	}
}