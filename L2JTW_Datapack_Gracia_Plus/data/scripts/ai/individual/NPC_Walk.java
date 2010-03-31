package ai.individual;

import ai.group_template.L2AttackableAIScript;
import java.util.Map;
import javolution.util.FastMap;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.L2CharPosition;

/**
 * NPC Walk script
 * Update by rocknow
 */
public class NPC_Walk extends L2AttackableAIScript
{
	private L2Npc wharf_patrol01, wharf_patrol02, wharf_patrol03, wharf_patrol04;
	private static Map<String, Object[]> walks99 = new FastMap<String, Object[]>();
	private void load99()
	{
	walks99.put("3262801", new Object[]{-148230,255276,-184,"3262802"});
	walks99.put("3262802", new Object[]{-148280,254818,-184,"3262803"});
	walks99.put("3262803", new Object[]{-148670,254376,-184,"3262804"});
	walks99.put("3262804", new Object[]{-149230,254098,-184,"3262805"});
	walks99.put("3262805", new Object[]{-148670,254376,-184,"3262806"});
	walks99.put("3262806", new Object[]{-148280,254818,-184,"3262801"});
	walks99.put("3262807", new Object[]{-148266,255312,-184,"3262808"});
	walks99.put("3262808", new Object[]{-148316,254854,-184,"3262809"});
	walks99.put("3262809", new Object[]{-148706,254412,-184,"3262810"});
	walks99.put("3262810", new Object[]{-149266,254134,-184,"3262811"});
	walks99.put("3262811", new Object[]{-148706,254412,-184,"3262812"});
	walks99.put("3262812", new Object[]{-148316,254854,-184,"3262807"});
	walks99.put("3262901", new Object[]{-150500,255276,-184,"3262902"});
	walks99.put("3262902", new Object[]{-150450,254818,-184,"3262903"});
	walks99.put("3262903", new Object[]{-150060,254376,-184,"3262904"});
	walks99.put("3262904", new Object[]{-149500,254098,-184,"3262905"});
	walks99.put("3262905", new Object[]{-150060,254376,-184,"3262906"});
	walks99.put("3262906", new Object[]{-150450,254818,-184,"3262901"});
	walks99.put("3262907", new Object[]{-150464,255312,-184,"3262908"});
	walks99.put("3262908", new Object[]{-150414,254854,-184,"3262909"});
	walks99.put("3262909", new Object[]{-150024,254412,-184,"3262910"});
	walks99.put("3262910", new Object[]{-149464,254134,-184,"3262911"});
	walks99.put("3262911", new Object[]{-150024,254412,-184,"3262912"});
	walks99.put("3262912", new Object[]{-150414,254854,-184,"3262907"});
	}

	public NPC_Walk(int id, String name, String descr)
	{
		super(id,name,descr);
		load99();
		wharf_patrol01 = addSpawn(32628,-148230,255276,-184,0,false,0);
		wharf_patrol02 = addSpawn(32628,-148266,255312,-184,0,false,0);
		wharf_patrol03 = addSpawn(32629,-150502,255276,-184,0,false,0);
		wharf_patrol04 = addSpawn(32629,-150466,255312,-184,0,false,0);
		this.startQuestTimer("3262801", 5000, wharf_patrol01, null);
		this.startQuestTimer("3262807", 5000, wharf_patrol02, null);
		this.startQuestTimer("3262904", 5000, wharf_patrol03, null);
		this.startQuestTimer("3262910", 5000, wharf_patrol04, null);
	}

	public String onAdvEvent (String event, L2Npc npc, L2PcInstance player)
	{
		if (walks99.containsKey(event))
		{
			int x = (Integer) walks99.get(event)[0];
			int y = (Integer) walks99.get(event)[1];
			int z = (Integer) walks99.get(event)[2];
			String nextEvent = (String) walks99.get(event)[3];
			npc.getAI().setIntention(CtrlIntention.AI_INTENTION_MOVE_TO,new L2CharPosition(x,y,z,0));
			if ((npc.getX()-100) <= x && (npc.getX()+100) >= x && (npc.getY()-100) <= y && (npc.getY()+100) >= y)
				this.startQuestTimer(nextEvent, 1000, npc, null);
			else
				this.startQuestTimer(event, 1000, npc, null);
		}
		return super.onAdvEvent(event, npc, player);
	}

	public static void main(String[] args)
	{
		// now call the constructor (starts up the ai)
		new NPC_Walk(-1,"npc_walk","ai");
	}
}