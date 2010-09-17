/* This program is free software: you can redistribute it and/or modify it under
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
package ai.individual;

import ai.group_template.L2AttackableAIScript;

import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.util.Rnd;

/**
 * º…¿s
 * @author InsOmnia
 */
public class Trex extends L2AttackableAIScript
{
	private static final int[] npcIds = { 22215, 22216, 22217 };
	private static final int[] RESPAWN = { 1, 3 }; // 1h to 3h
	private long[] RESPAWNdata = { 0, 0, 0 };
	
	private static final int[][] locs =
	{
		{ 24767, -12441, -2532, 15314 },
		{ 7365, -8112, -3640, 2686 },
		{ 22827, -14698, -3080, 53946 }
	};
	
	public Trex(int questId, String name, String descr)
	{
		super(questId, name, descr);
		
		try
		{
			RESPAWNdata[0] = Long.valueOf(loadGlobalQuestVar("Trex0respawn"));
			RESPAWNdata[1] = Long.valueOf(loadGlobalQuestVar("Trex1respawn"));
			RESPAWNdata[2] = Long.valueOf(loadGlobalQuestVar("Trex2respawn"));
		}
		catch (Exception e)
		{
		}
		
		saveGlobalQuestVar("Trex0respawn", String.valueOf(RESPAWNdata[0]));
		saveGlobalQuestVar("Trex1respawn", String.valueOf(RESPAWNdata[1]));
		saveGlobalQuestVar("Trex2respawn", String.valueOf(RESPAWNdata[2]));
		
		for (int i = 0; i < npcIds.length; i++)
		{
			addSkillSeeId(npcIds[i]);
			addKillId(npcIds[i]);
			if (RESPAWNdata[i] == 0 || (RESPAWNdata[i] - System.currentTimeMillis() < 0))
				addSpawn(npcIds[i], locs[i][0], locs[i][1], locs[i][2], locs[i][3], false, 0);
			else
				startQuestTimer("Trex" + i, RESPAWNdata[i] - System.currentTimeMillis(), null, null);
		}
	}
	
	public String onSkillSee(L2Npc npc, L2PcInstance player, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		for (L2Object obj : targets)
		{
			if (npc != obj)
				return null;
		}
		int trexMaxHp = npc.getMaxHp();
		int skillId = skill.getId();
		int minhp = 0;
		int maxhp = 0;
		double trexCurrentHp = npc.getStatus().getCurrentHp();
		switch (skillId)
		{
			case 3626:
			{
				minhp = (60 * trexMaxHp) / 100;
				maxhp = (100 * trexMaxHp) / 100;
			}
				break;
			case 3267:
			{
				minhp = (25 * trexMaxHp) / 100;
				maxhp = (65 * trexMaxHp) / 100;
			}
				break;
			case 3268:
			{
				minhp = (0 * trexMaxHp) / 100;
				maxhp = (25 * trexMaxHp) / 100;
			}
				break;
		}
		if (trexCurrentHp < minhp || trexCurrentHp > maxhp)
		{
			npc.stopSkillEffects(skillId);
			player.sendMessage("The conditions are not right to use this skill now.");
		}
		return super.onSkillSee(npc, player, skill, targets, isPet);
	}
	
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		if (event.equalsIgnoreCase("Trex0"))
		{
			addSpawn(npcIds[0], locs[0][0], locs[0][1], locs[0][2], locs[0][3], false, 0);
			saveGlobalQuestVar("Trex0respawn", String.valueOf(0));
		}
		else if (event.equalsIgnoreCase("Trex1"))
		{
			addSpawn(npcIds[1], locs[1][0], locs[1][1], locs[1][2], locs[1][3], false, 0);
			saveGlobalQuestVar("Trex1respawn", String.valueOf(0));
		}
		else if (event.equalsIgnoreCase("Trex2"))
		{
			addSpawn(npcIds[2], locs[2][0], locs[2][1], locs[2][2], locs[2][3], false, 0);
			saveGlobalQuestVar("Trex2respawn", String.valueOf(0));
		}
		return null;
	}
	
	public String onKill(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		long respawnTime = Rnd.get(RESPAWN[0], RESPAWN[1]) * 3600000;
		int npcId = npc.getNpcId();
		switch (npcId)
		{
			case 22215:
			{
				startQuestTimer("Trex0", respawnTime, npc, null);
				saveGlobalQuestVar("Trex0respawn", String.valueOf(System.currentTimeMillis() + respawnTime));
			}
				break;
			case 22216:
			{
				startQuestTimer("Trex1", respawnTime, npc, null);
				saveGlobalQuestVar("Trex1respawn", String.valueOf(System.currentTimeMillis() + respawnTime));
			}
				break;
			case 22217:
			{
				startQuestTimer("Trex2", respawnTime, npc, null);
				saveGlobalQuestVar("Trex2respawn", String.valueOf(System.currentTimeMillis() + respawnTime));
			}
				break;
		}
		return super.onKill(npc, player, isPet);
	}
	
	public static void main(String[] args)
	{
		new Trex(-1, "Trex", "ai");
	}
}