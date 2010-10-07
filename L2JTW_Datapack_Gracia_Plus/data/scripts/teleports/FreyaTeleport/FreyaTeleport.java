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
package teleports.FreyaTeleport;

import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;

public class FreyaTeleport extends Quest
{
	private final static int NPC = 32734;

	public FreyaTeleport(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addStartNpc(NPC);
		addTalkId(NPC);
	}

	public String onTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		QuestState st = player.getQuestState(getName());
		if (player.getLevel() >= 80)
			player.teleToLocation(-180218, 185923, -10576);
		else
			htmltext = "<html><body>軍官 克萊米斯：<br>雖然情況緊急，但我覺得此地對你來說還是很危險。我認為不應該將珍貴的生命逼入絕境，請你諒解。當然，如果你培養一些實力後變得更強悍的話，那麼我隨時都會歡迎你。<br>(只有<font color=\"LEVEL\">等級80</font>以上的角色才能進入殄滅之種。)</body></html>";

		st.exitQuest(true);
		return htmltext;
	}

	public static void main(String[] args)
	{
		new FreyaTeleport(-1, "FreyaTeleport", "teleports");
	}
}