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
package custom.Blessing;

import com.l2jserver.gameserver.instancemanager.QuestManager;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;

/**
 *【ID】   【ITEM_NAME】
 * 17094	奈比特之聲		內含奈比特之聲的貝殼，此道具可以提升自己的評價值10。無法交易或丟棄。
 * 17095	奈比特沙漏-1小時	1~19	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級1~19使用。無法交易或丟棄。
 * 17096	奈比特沙漏-1.5小時	1~19	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級1~19使用。無法交易或丟棄。
 * 17097	奈比特沙漏-2小時	1~19	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級1~19使用。無法交易或丟棄。
 * 17098	奈比特沙漏-2.5小時	1~19	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級1~19使用。無法交易或丟棄。
 * 17099	奈比特沙漏-3小時	1~19	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級1~19使用。無法交易或丟棄。
 * 17100	奈比特沙漏-1小時	20~39	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級20~39使用。無法交易或丟棄。
 * 17101	奈比特沙漏-1.5小時	20~39	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級20~39使用。無法交易或丟棄。
 * 17102	奈比特沙漏-2小時	20~39	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級20~39使用。無法交易或丟棄。
 * 17103	奈比特沙漏-2.5小時	20~39	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級20~39使用。無法交易或丟棄。
 * 17104	奈比特沙漏-3小時	20~39	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級20~39使用。無法交易或丟棄。
 * 17105	奈比特沙漏-1小時	40~51	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級40~51使用。無法交易或丟棄。
 * 17106	奈比特沙漏-1.5小時	40~51	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級40~51使用。無法交易或丟棄。
 * 17107	奈比特沙漏-2小時	40~51	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級40~51使用。無法交易或丟棄。
 * 17108	奈比特沙漏-2.5小時	40~51	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級40~51使用。無法交易或丟棄。
 * 17109	奈比特沙漏-3小時	40~51	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級40~51使用。無法交易或丟棄。
 * 17110	奈比特沙漏-1小時	52~60	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級52~60使用。無法交易或丟棄。
 * 17111	奈比特沙漏-1.5小時	52~60	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級52~60使用。無法交易或丟棄。
 * 17112	奈比特沙漏-2小時	52~60	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級52~60使用。無法交易或丟棄。
 * 17113	奈比特沙漏-2.5小時	52~60	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級52~60使用。無法交易或丟棄。
 * 17114	奈比特沙漏-3小時	52~60	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級52~60使用。無法交易或丟棄。
 * 17115	奈比特沙漏-1小時	61~75	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級61~75使用。無法交易或丟棄。
 * 17116	奈比特沙漏-1.5小時	61~75	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級61~75使用。無法交易或丟棄。
 * 17117	奈比特沙漏-2小時	61~75	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級61~75使用。無法交易或丟棄。
 * 17118	奈比特沙漏-2.5小時	61~75	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級61~75使用。無法交易或丟棄。
 * 17119	奈比特沙漏-3小時	61~75	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級61~75使用。無法交易或丟棄。
 * 17120	奈比特沙漏-1小時	76~79	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級76~79使用。無法交易或丟棄。
 * 17121	奈比特沙漏-1.5小時	76~79	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級76~79使用。無法交易或丟棄。
 * 17122	奈比特沙漏-2小時	76~79	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級76~79使用。無法交易或丟棄。
 * 17123	奈比特沙漏-2.5小時	76~79	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級76~79使用。無法交易或丟棄。
 * 17124	奈比特沙漏-3小時	76~79	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級76~79使用。無法交易或丟棄。
 * 17125	奈比特沙漏-1小時	80~85	可以延長奈比特祝福1小時的奈比特沙漏。僅限等級80~85使用。無法交易或丟棄。
 * 17126	奈比特沙漏-1.5小時	80~85	可以延長奈比特祝福1.5小時的奈比特沙漏。僅限等級80~85使用。無法交易或丟棄。
 * 17127	奈比特沙漏-2小時	80~85	可以延長奈比特祝福2小時的奈比特沙漏。僅限等級80~85使用。無法交易或丟棄。
 * 17128	奈比特沙漏-2.5小時	80~85	可以延長奈比特祝福2.5小時的奈比特沙漏。僅限等級80~85使用。無法交易或丟棄。
 * 17129	奈比特沙漏-3小時	80~85	可以延長奈比特祝福3小時的奈比特沙漏。僅限等級80~85使用。無法交易或丟棄。
 */

/**
 * Event Code for "Blessing"
 * @author  Gnat
 * Update by pmq 12-10-2010
 */
public class Blessing extends Quest
{
	private static final int BLESSING               = 32783;    // 祝福的神官
	private static final int NEVITS_VOICE           = 17094;    // 奈比特之聲
	private static final int NEVITS_HOURGLASS       = 17129;    // 奈比特沙漏

	private static final int ADENA                  = 57;       // 金幣
	private static final int NEVITS_VOICE_PRICE     = 100000;   // 奈比特之聲價錢
	private static final int NEVITS_VOICE_TIME      = 20;       // 奈比特之聲可再買時間【已小時為單位】
	private static final int NEVITS_HOURGLASS_PRICE = 5000000;  // 奈比特沙漏價錢
	private static final int NEVITS_HOURGLASS_TIME  = 20;       // 奈比特沙漏可再買時間【已小時為單位】

	public Blessing(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addStartNpc(BLESSING);
		addFirstTalkId(BLESSING);
		addTalkId(BLESSING);
	}

	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());
		Quest q = QuestManager.getInstance().getQuest(getName());

		htmltext = event;
		if (event.equalsIgnoreCase("voice"))
		{
			long _curr_time = System.currentTimeMillis();
			String value = q.loadGlobalQuestVar(player.getAccountName());
			long _reuse_time = value == "" ? 0 : Long.parseLong(value);
			if (_curr_time > _reuse_time)
			{
				if (st.getQuestItemsCount(ADENA) > NEVITS_VOICE_PRICE)
				{
					st.takeItems(ADENA, NEVITS_VOICE_PRICE);
					st.giveItems(NEVITS_VOICE, 1);
					q.saveGlobalQuestVar(player.getAccountName(), Long.toString(System.currentTimeMillis() + (NEVITS_VOICE_TIME * 3600000)));
					htmltext = "";
				}
				else
					htmltext = "<html><body>祝福的神官：您的好意我心領了，但您要捐獻的金幣好像還不太夠呢。協助貧困人們的機會一直都為您敞開著，等您有能力協助的時候，請隨時來找我。願神的祝福與您同在...</body></html>";
			}
			else
			{
				long _remaining_time = (_reuse_time - _curr_time) / 1000;
				int hours = (int) _remaining_time / 3600;
				int minutes = ((int) _remaining_time % 3600) / 60;
				if (hours > 0)
				{
					SystemMessage sm = new SystemMessage(SystemMessageId.ITEM_PURCHASABLE_IN_S1_HOURS_S2_MINUTES);
					sm.addNumber(hours);
					sm.addNumber(minutes);
					player.sendPacket(sm);
					htmltext = "";
				}
				else if (minutes > 0)
				{
					SystemMessage sm = new SystemMessage(SystemMessageId.ITEM_PURCHASABLE_IN_S1_MINUTES);
					sm.addNumber(minutes);
					player.sendPacket(sm);
					htmltext = "";
				}
				else
				{
					// Little glitch. There is no SystemMessage with seconds only.
					// If time is less than 1 minute player can buy scrolls
					if (st.getQuestItemsCount(ADENA) > NEVITS_VOICE_PRICE)
					{
						st.takeItems(ADENA, NEVITS_VOICE_PRICE);
						st.giveItems(NEVITS_VOICE, 1);
						q.saveGlobalQuestVar(player.getAccountName(), Long.toString(System.currentTimeMillis() + (NEVITS_VOICE_TIME * 3600000)));
						htmltext = "";
					}
					else
						htmltext = "<html><body>祝福的神官：您的好意我心領了，但您要捐獻的金幣好像還不太夠呢。協助貧困人們的機會一直都為您敞開著，等您有能力協助的時候，請隨時來找我。願神的祝福與您同在...</body></html>";
				}
			}
		}
		else if (event.equalsIgnoreCase("hourglass"))
		{
			long _curr_time = System.currentTimeMillis();
			String value = q.loadGlobalQuestVar(player.getAccountName());
			long _reuse_time = value == "" ? 0 : Long.parseLong(value);
			if (_curr_time > _reuse_time)
			{
				if (st.getQuestItemsCount(ADENA) > NEVITS_HOURGLASS_PRICE)
				{
					st.takeItems(ADENA, NEVITS_HOURGLASS_PRICE);
					st.giveItems(NEVITS_HOURGLASS, 1);
					q.saveGlobalQuestVar(player.getAccountName(), Long.toString(System.currentTimeMillis() + (NEVITS_HOURGLASS_TIME * 3600000)));
					htmltext = "";
				}
				else
					htmltext = "<html><body>祝福的神官：您的好意我心領了，但您要捐獻的金幣好像還不太夠呢。協助貧困人們的機會一直都為您敞開著，等您有能力協助的時候，請隨時來找我。願神的祝福與您同在...</body></html>";
			}
			else
			{
				long _remaining_time = (_reuse_time - _curr_time) / 1000;
				int hours = (int) _remaining_time / 3600;
				int minutes = ((int) _remaining_time % 3600) / 60;
				if (hours > 0)
				{
					SystemMessage sm = new SystemMessage(SystemMessageId.ITEM_PURCHASABLE_IN_S1_HOURS_S2_MINUTES);
					sm.addNumber(hours);
					sm.addNumber(minutes);
					player.sendPacket(sm);
					htmltext = "";
				}
				else if (minutes > 0)
				{
					SystemMessage sm = new SystemMessage(SystemMessageId.ITEM_PURCHASABLE_IN_S1_MINUTES);
					sm.addNumber(minutes);
					player.sendPacket(sm);
					htmltext = "";
				}
				else
				{
					// Little glitch. There is no SystemMessage with seconds only.
					// If time is less than 1 minute player can buy scrolls
					if (st.getQuestItemsCount(ADENA) > NEVITS_HOURGLASS_PRICE)
					{
						st.takeItems(ADENA, NEVITS_HOURGLASS_PRICE);
						st.giveItems(NEVITS_HOURGLASS, 1);
						q.saveGlobalQuestVar(player.getAccountName(), Long.toString(System.currentTimeMillis() + (NEVITS_HOURGLASS_TIME * 3600000)));
						htmltext = "";
					}
					else
						htmltext = "<html><body>祝福的神官：您的好意我心領了，但您要捐獻的金幣好像還不太夠呢。協助貧困人們的機會一直都為您敞開著，等您有能力協助的時候，請隨時來找我。願神的祝福與您同在...</body></html>";
				}
			}
		}

		return htmltext;
	}

	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());
		if (st == null)
		{
			Quest q = QuestManager.getInstance().getQuest(getName());
			st = q.newQuestState(player);
		}
		if (player.getLevel() <= 19)
			htmltext = "32783-l1.htm";
		if (player.getLevel() >= 20 && player.getLevel() <= 39)
			htmltext = "32783-l2.htm";
		if (player.getLevel() >= 40 && player.getLevel() <= 51)
			htmltext = "32783-l3.htm";
		if (player.getLevel() >= 52 && player.getLevel() <= 60)
			htmltext = "32783-l4.htm";
		if (player.getLevel() >= 61 && player.getLevel() <= 75)
			htmltext = "32783-l5.htm";
		if (player.getLevel() >= 76 && player.getLevel() <= 79)
			htmltext = "32783-l6.htm";
		if (player.getLevel() >= 80 && player.getLevel() <= 85)
			htmltext = "32783-l7.htm";
		return htmltext;
	}

	public static void main(String[] args)
	{
		new Blessing(-1, "Blessing", "custom");
	}
}