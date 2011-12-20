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
package events.SavingSanta;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javolution.util.FastMap;

import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.ItemTable;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.model.L2Object;
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.L2Npc;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.quest.Quest;
import com.l2jserver.gameserver.model.quest.QuestState;
import com.l2jserver.gameserver.network.NpcStringId;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.ActionFailed;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.NpcSay;
import com.l2jserver.gameserver.network.serverpackets.SocialAction;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.util.Broadcast;
import com.l2jserver.gameserver.util.Util;
import com.l2jserver.util.Rnd;

/**
 * Christmas Event: Happy Holidays (Saving Santa)<br>
 * @author theone (Jython version)
 * @author janiii (Based on theone's work, Java version)
 * @author gigiikun (Added Saving Santa part, some issues fixed 2x)
 * @author qwerty13 (Update to Epilogue) ?
 * @author surskis (Update to Freya) ?
 * @author a13xsus (Added Sled spawn and reward to rescuer)
 * @author Zoey76 (Reworked, fixed issue with multiple tree's spawn, some other issues fixed, added most retail texts, added Sled Social Action)
 */
public class SavingSanta extends Quest
{
	private static final String qn = "SavingSanta";
	//Is Saving Santa event used? 
	private static boolean SAVING_SANTA = true;
	//Use Santa's Helpers Auto Buff?
	private static boolean SANTAS_HELPER_AUTOBUFF = false;
	private static final int[] RequiredPieces = { 5556, 5557, 5558, 5559 };
	private static final int[] RequiredQty = { 4, 4, 10, 1 };
	private static final int SantaTraineeId = 31863;
	private static final int SpecialChristmasTreeId = 13007;
	private static final int HolidaySantaId = 103;
	private static final int HolidaySledId = 105;
	private static final int ThomasDTurkeyId = 13183;
	private static final long MIN_TIME_BETWEEN_2_REWARDS = 43200000;
	private static final long MIN_TIME_BETWEEN_2_BLESSINGS = 14400000;
	private static final int HOLIDAYSANTASREWARD = 20101;
	private static final int HOLIDAYBUFFID = 23017;
	private static final int[] RANDOM_A_PLUS_10_WEAPON = { 81, 151, 164, 213, 236, 270, 289, 2500, 7895, 7902, 5706 };
	private static final int[] THOMAS_LOC = { 117935, -126003, -2585, 54625 };
	private static final int[] SantaMageBuffs = { 7055, 7054, 7051 };
	private static final int[] SantaFighterBuffs = { 7043, 7057, 7051 };
	
	private static final int[] StartDate = { 2011, 12, 15 };
	private static final int[] EndDate = { 2012, 1, 6 };
	
	private static final int[] SantaX = { 147698, 147443, 82218, 82754, 15064, 111067, -12965, 87362, -81037, 117412, 43983, -45907, 12153, -84458, 114750, -45656, -117195 };
	private static final int[] SantaY = { -56025, 26942, 148605, 53573, 143254, 218933, 122914, -143166, 150092, 76642, -47758, 49387, 16753, 244761, -178692, -113119, 46837 };
	private static final int[] SantaZ = { -2775, -2205, -3470, -1496, -2668, -3543, -3117, -1293, -3044, -2695, -797, -3060, -4584, -3730, -820, -240, 367 };
	
	private static final int[] TreeSpawnX = { 83254, 83278, 83241, 83281, 84304, 84311, 82948, 80905, 80908, 82957, 147849, 147580, 147581, 147847, 149085, 146340, 147826, 147584, 146235, 147840, 147055, 148694, 147733, 147197, 147266, 147646, 147456, 148078, 147348, 117056, 116473, 115785, 115939, 116833, 116666, -13130, -13165, -13126, 15733, 16208 };
	private static final int[] TreeSpawnY = { 148340, 147900, 148898, 149343, 149133, 148101, 147658, 147659, 149556, 149554, -55119, -55117, -57244, -57261, -55826, -55829, -54095, -54070, 25921, 25568, 25568, 25929, 27366, 27364, 29065, 29065, 27664, -55960, -55939, 75627, 75352, 76111, 76544, 77400, 76210, 122533, 122425, 122806, 142767, 142710 };
	private static final int[] TreeSpawnZ = { -3405, -3405, -3405, -3405, -3402, -3402, -3469, -3469, -3469, -3469, -2734, -2734, -2781, -2781, -2781, -2781, -2735, -2735, -2013, -2013, -2013, -2013, -2205, -2205, -2269, -2269, -2204, -2781, -2781, -2726, -2712, -2715, -2719, -2697, -2730, -3117, -2989, -3117, -2706, -2706 };
	
	private static GregorianCalendar calendar;
	private static GregorianCalendar startCalendar;
	private static GregorianCalendar endCalendar;
	
	private static boolean ChristmasEvent = true;
	private static boolean isSantaFree = true;
	private static boolean isWaitingForPlayerSkill = false;
	private static List<L2Npc> SantaHelpers = new ArrayList<L2Npc>();
	private static List<L2Npc> specialTrees = new ArrayList<L2Npc>();
	private Map<String, Long> _rewardedPlayers = new FastMap<String, Long>();
	private Map<String, Long> _blessedPlayers = new FastMap<String, Long>();
	
	private static final NpcStringId[] Text1 =
	{
		NpcStringId.NOW_THOSE_OF_YOU_WHO_LOST_GO_AWAY,
		NpcStringId.WHAT_A_BUNCH_OF_LOSERS 
	};
	
	private static final NpcStringId[] Text2 =
	{
		NpcStringId.AH_OKAY,
		NpcStringId.UAGH_I_WASNT_GOING_TO_DO_THAT,
		NpcStringId.YOURE_CURSED_OH_WHAT,
		NpcStringId.HAVE_YOU_DONE_NOTHING_BUT_ROCK_PAPER_SCISSORS 
	};
	
	private static final NpcStringId[] Text3 =
	{
		NpcStringId.I_HAVE_TO_RELEASE_SANTA_HOW_INFURIATING,
		NpcStringId.I_HATE_HAPPY_MERRY_CHRISTMAS 
	};
	
	private static final NpcStringId[] Text4 =
	{
		NpcStringId.ITS_HURTING_IM_IN_PAIN_WHAT_CAN_I_DO_FOR_THE_PAIN,
		NpcStringId.NO_WHEN_I_LOSE_THAT_ONE_ILL_BE_IN_MORE_PAIN,
		NpcStringId.HAHAHAH_I_CAPTURED_SANTA_CLAUS_THERE_WILL_BE_NO_GIFTS_THIS_YEAR,
		NpcStringId.NOW_WHY_DONT_YOU_TAKE_UP_THE_CHALLENGE,
		NpcStringId.COME_ON_ILL_TAKE_ALL_OF_YOU_ON,
		NpcStringId.HOW_ABOUT_IT_I_THINK_I_WON 
	};
	
	public SavingSanta(int questId, String name, String descr)
	{
		super(questId, name, descr);
		addStartNpc(SantaTraineeId);
		addFirstTalkId(SantaTraineeId);
		addTalkId(SantaTraineeId);
		addFirstTalkId(ThomasDTurkeyId);
		addFirstTalkId(HolidaySantaId);
		addFirstTalkId(HolidaySledId);
		addSkillSeeId(ThomasDTurkeyId);
		addSpellFinishedId(ThomasDTurkeyId);
		addSpawnId(SpecialChristmasTreeId);
		
		calendar = new GregorianCalendar();
		startCalendar = new GregorianCalendar(StartDate[0], (StartDate[1] - 1), StartDate[2]);
		endCalendar = new GregorianCalendar(EndDate[0], (EndDate[1] - 1), EndDate[2]);
		
		if (calendar.after(startCalendar) && calendar.before(endCalendar))
		{
			_log.info("[Christmas Event] ON");
			
			ChristmasEvent = true;
			for (int i = 0; i < TreeSpawnX.length; i++)
			{
				this.addSpawn(13006, TreeSpawnX[i], TreeSpawnY[i], TreeSpawnZ[i], 0, false, 0);
			}
			
			this.startQuestTimer("SpecialTreeHeal", 5000, null, null);
			
			for (int i = 0; i < SantaX.length; i++)
			{
				L2Npc mob = this.addSpawn(SantaTraineeId, SantaX[i], SantaY[i], SantaZ[i], 0, false, 0);
				SantaHelpers.add(mob);
			}
			
			if (SANTAS_HELPER_AUTOBUFF)
			{
				this.startQuestTimer("SantaBlessings", 5000, null, null);
			}
			
			if (SAVING_SANTA)
			{
				this.startQuestTimer("ThomasQuest", 1000, null, null);
			}
		}
		else
		{
			_log.info("[Christmas Event] OFF");
			
			GregorianCalendar endWeek = (GregorianCalendar) endCalendar.clone();
			endWeek.add(Calendar.DAY_OF_MONTH, 7);
			if (calendar.after(endCalendar) && calendar.before(endWeek))
			{
				for (int i = 0; i < SantaX.length; i++)
				{
					this.addSpawn(SantaTraineeId, SantaX[i], SantaY[i], SantaZ[i], 0, false, 0);
				}
			}
		}
	}
	
	@Override
	public String onSpawn(L2Npc npc)
	{
		specialTrees.add(npc);
		return super.onSpawn(npc);
	}

	@Override
	public String onSkillSee(L2Npc npc, L2PcInstance caster, L2Skill skill, L2Object[] targets, boolean isPet)
	{
		if (isWaitingForPlayerSkill && (skill.getId() > 21013) && (skill.getId() < 21017))
		{
			caster.broadcastPacket(new MagicSkillUse(caster, caster, 23019, skill.getId() - 21013, 3000, 1));
			SkillTable.getInstance().getInfo(23019, skill.getId() - 21013).getEffects(caster, caster);
		}
		return "";
	}
	
	@Override
	public String onSpellFinished(L2Npc npc, L2PcInstance player, L2Skill skill)
	{
		/**
		 * Level 1: Scissors
		 * Level 2: Rock
		 * Level 3: Paper
		 */
		if (skill.getId() == 6100)//Turkey's Choice
		{
			isWaitingForPlayerSkill = false;
			for (L2PcInstance pl : npc.getKnownList().getKnownPlayersInRadius(600))
			{
				/**
				 * Level 1: Scissors
				 * Level 2: Rock
				 * Level 3: Paper
				 */
				if (pl.getFirstEffect(23019) == null)
				{
					continue;
				}
				
				int result = pl.getFirstEffect(23019).getSkill().getLevel() - skill.getLevel();
				
				if (result == 0)
				{
					//Oh. I'm bored.
					NpcSay Agh = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.OH_IM_BORED);
					npc.broadcastPacket(Agh);
				}
				else if ((result == -1) || (result == 2))
				{
					//Now!! Those of you who lost, go away!
					//What a bunch of losers.
					NpcSay IHate = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), Text1[Rnd.get(2)]);
					npc.broadcastPacket(IHate);
					pl.broadcastPacket(new MagicSkillUse(pl, pl, 23023, 1, 3000, 1));
					pl.stopSkillEffects(23022);
				}
				else if ((result == 1) || (result == -2))
				{
					int level = (pl.getFirstEffect(23022) != null ? (pl.getFirstEffect(23022).getSkill().getLevel() + 1) : 1);
					pl.broadcastPacket(new MagicSkillUse(pl, pl, 23022, level, 3000, 1));
					SkillTable.getInstance().getInfo(23022, level).getEffects(pl, pl);
					if ((level == 1) || (level == 2))
					{
						//Ah, okay...
						//Agh!! I wasn・t going to do that!
						//You・re cursed!! Oh.. What?
						//Have you done nothing but rock-paper-scissors??
						NpcSay Agh = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), Text2[Rnd.get(4)]);
						npc.broadcastPacket(Agh);
					}
					else if (level == 3)
					{
						SkillTable.getInstance().getInfo(23018, 1).getEffects(pl, pl);
						//Stop it, no more... I did it because I was too lonely...
						NpcSay StopIt = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.STOP_IT_NO_MORE_I_DID_IT_BECAUSE_I_WAS_TOO_LONELY);
						npc.broadcastPacket(StopIt);
					}
					else if (level == 4)
					{
						SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.THOMAS_D_TURKEY_DEFETED);
						Broadcast.toAllOnlinePlayers(sm);
						//I have to release Santa... How infuriating!!!
						//I hate happy Merry Christmas!!!
						NpcSay IHate = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), Text3[Rnd.get(2)]);
						npc.broadcastPacket(IHate);
						
						this.startQuestTimer("SantaSpawn", 120000, null, null);
						L2Npc HolidaySled = this.addSpawn(HolidaySledId, 117935, -126003, -2585, 54625, false, 12000);
						//Message from Santa Claus: Many blessings to $s1, who saved me~
						NpcSay SantaSaved = new NpcSay(HolidaySled.getObjectId(), 10, HolidaySled.getNpcId(), NpcStringId.MESSAGE_FROM_SANTA_CLAUS_MANY_BLESSINGS_TO_S1_WHO_SAVED_ME);
						SantaSaved.addStringParameter(pl.getName());
						HolidaySled.broadcastPacket(SantaSaved);
						//Oh ho ho.... Merry Christmas!!
						NpcSay MerryChristmas = new NpcSay(HolidaySled.getObjectId(), 0, HolidaySled.getNpcId(), NpcStringId.OH_HO_HO_MERRY_CHRISTMAS);
						HolidaySled.broadcastPacket(MerryChristmas);
						
						QuestState st = pl.getQuestState(qn);
						if (st == null)
						{
							st = newQuestState(pl);
						}
						
						st.giveItems(HOLIDAYSANTASREWARD, 1);
						
						ThreadPoolManager.getInstance().scheduleGeneral(new SledAnimation(HolidaySled), 7000);
						
						npc.decayMe();
						isSantaFree = true;
						break;
					}
				}
			}
		}
		return "";
	}
	
	//TODO: Find nice collision_height for Holiday Sled.
	private static class SledAnimation implements Runnable
	{
		private L2Npc _sled;
		
		public SledAnimation(L2Npc sled)
		{
			_sled = sled;
		}
		
		@Override
		public void run()
		{
			try
			{
				_sled.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
				_sled.broadcastPacket(new SocialAction(_sled.getObjectId(), 1));
			}
			catch (Exception e)
			{
				//
			}
		}
	}
	
	@Override
	public String onAdvEvent(String event, L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		
		if (event.equalsIgnoreCase("ThomasQuest"))
		{
			this.startQuestTimer("ThomasQuest", 14400000, null, null);
			L2Npc ThomasDTurkey = this.addSpawn(ThomasDTurkeyId, THOMAS_LOC[0], THOMAS_LOC[1], THOMAS_LOC[2], THOMAS_LOC[3], false, 1800000);
			SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.THOMAS_D_TURKEY_APPEARED);
			Broadcast.toAllOnlinePlayers(sm);
			
			this.startQuestTimer("ThomasCast1", 15000, ThomasDTurkey, null);
			
			isSantaFree = false;
		}
		else if (event.equalsIgnoreCase("SantaSpawn"))
		{
			if (isSantaFree)
			{
				this.startQuestTimer("SantaSpawn", 120000, null, null);
				for (L2PcInstance pl : L2World.getInstance().getAllPlayers().values())
				{
					if (pl.isOnline() && (pl.getLevel() >= 20) && pl.isInCombat() && !pl.isInsideZone(L2Character.ZONE_PEACE) && !pl.isFlyingMounted())
					{
						if (_rewardedPlayers.containsKey(pl.getAccountName()))
						{
							long elapsedTimeSinceLastRewarded = System.currentTimeMillis() - _rewardedPlayers.get(pl.getAccountName());
							if (elapsedTimeSinceLastRewarded < MIN_TIME_BETWEEN_2_REWARDS)
							{
								continue;
							}
						}
						else
						{
							String data = loadGlobalQuestVar(pl.getAccountName());
							if (!data.isEmpty() && ((System.currentTimeMillis() - Long.parseLong(data)) < MIN_TIME_BETWEEN_2_REWARDS))
							{
								_rewardedPlayers.put(pl.getAccountName(), Long.parseLong(data));
								continue;
							}
						}
						int locx = (int) (pl.getX() + Math.pow(-1, Rnd.get(1, 2)) * 50);
						int locy = (int) (pl.getY() + Math.pow(-1, Rnd.get(1, 2)) * 50);
						int heading = Util.calculateHeadingFrom(locx, locy, pl.getX(), pl.getY());
						L2Npc santa = this.addSpawn(HolidaySantaId, locx, locy, pl.getZ(), heading, false, 30000);
						_rewardedPlayers.put(pl.getAccountName(), System.currentTimeMillis());
						saveGlobalQuestVar(pl.getAccountName(), String.valueOf(System.currentTimeMillis()));
						this.startQuestTimer("SantaRewarding0", 500, santa, pl);
					}
				}
			}
		}
		else if (event.equalsIgnoreCase("ThomasCast1"))
		{
			if (!npc.isDecayed())
			{
				isWaitingForPlayerSkill = true;
				this.startQuestTimer("ThomasCast2", 4000, npc, null);
				npc.doCast(SkillTable.getInstance().getInfo(6116, 1));
				//It's hurting... I'm in pain... What can I do for the pain...
				//No... When I lose that one... I'll be in more pain...
				//Hahahah!!! I captured Santa Claus!! There will be no gifts this year!!!
				//Now! Why don・t you take up the challenge?
				//Come on, I'll take all of you on! 
				//How about it? I think I won?
				NpcSay chat = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), Text4[Rnd.get(6)]);
				npc.broadcastPacket(chat);
			}
			else
			{
				if (!isSantaFree)
				{
					SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.THOMAS_D_TURKEY_DISAPPEARED);
					Broadcast.toAllOnlinePlayers(sm);
					isWaitingForPlayerSkill = false;
				}
			}
		}
		else if (event.equalsIgnoreCase("ThomasCast2"))
		{
			if (!npc.isDecayed())
			{
				this.startQuestTimer("ThomasCast1", 13000, npc, null);
				npc.doCast(SkillTable.getInstance().getInfo(6100, Rnd.get(1, 3)));
				//It's hurting... I'm in pain... What can I do for the pain...
				//No... When I lose that one... I'll be in more pain...
				//Hahahah!!! I captured Santa Claus!! There will be no gifts this year!!!
				//Now! Why don・t you take up the challenge?
				//Come on, I'll take all of you on! 
				//How about it? I think I won?
				NpcSay chat = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), Text4[Rnd.get(6)]);
				npc.broadcastPacket(chat);
			}
			else
			{
				if (!isSantaFree)
				{
					SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.THOMAS_D_TURKEY_DISAPPEARED);
					Broadcast.toAllOnlinePlayers(sm);
					isWaitingForPlayerSkill = false;
				}
			}
		}
		else if (event.equalsIgnoreCase("SantaRewarding0"))
		{
			this.startQuestTimer("SantaRewarding1", 9500, npc, player);
			npc.broadcastPacket(new SocialAction(npc.getObjectId(), 3));
		}
		else if (event.equalsIgnoreCase("SantaRewarding1"))
		{
			this.startQuestTimer("SantaRewarding2", 5000, npc, player);
			npc.broadcastPacket(new SocialAction(npc.getObjectId(), 1));
			//FIXME: Find retail npcstring
			//$s1 rescued Santa Claus of $s2 territory from the turkey. ?
			NpcSay ThanksAden = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.S1_RESCUED_SANTA_CLAUS_OF_S2_TERRITORY_FROM_THE_TURKEY);
			npc.broadcastPacket(ThanksAden);
		}
		else if (event.equalsIgnoreCase("SantaRewarding2"))
		{
			this.startQuestTimer("SantaRewarding3", 5000, npc, player);
			//I have a gift for $s1.
			NpcSay IHaveAGift = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.I_HAVE_A_GIFT_FOR_S1);
			IHaveAGift.addStringParameter(player.getName());
			npc.broadcastPacket(IHaveAGift);
		}
		else if (event.equalsIgnoreCase("SantaRewarding3"))
		{
			QuestState st = player.getQuestState(qn);
			if (st == null)
			{
				st = newQuestState(player);
			}
			st.giveItems(HOLIDAYSANTASREWARD, 1);
			npc.broadcastPacket(new SocialAction(npc.getObjectId(), 2));
			//Take a look at the inventory. I hope you like the gift I gave you.
			NpcSay TakeALook = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.TAKE_A_LOOK_AT_THE_INVENTORY_I_HOPE_YOU_LIKE_THE_GIFT_I_GAVE_YOU);
			npc.broadcastPacket(TakeALook);
		}
		else if (event.equalsIgnoreCase("SantaBlessings"))
		{
			if (ChristmasEvent)
			{
				this.startQuestTimer("SantaBlessings", 15000, null, null);
				for (L2Npc santaHelper1 : SantaHelpers)
				{
					Collection<L2PcInstance> blessList = santaHelper1.getKnownList().getKnownPlayers().values();
					for (L2PcInstance plb : blessList)
					{
						if ((plb.getLevel() >= 20) && !plb.isFlyingMounted())
						{
							if (_blessedPlayers.containsKey(plb.getAccountName()))
							{
								long elapsedTimeSinceLastBlessed = System.currentTimeMillis() - _blessedPlayers.get(plb.getAccountName());
								if (elapsedTimeSinceLastBlessed < MIN_TIME_BETWEEN_2_BLESSINGS)
								{
									continue;
								}
							}
							else
							{
								String data = loadGlobalQuestVar(plb.getAccountName());
								if (!data.isEmpty() && ((System.currentTimeMillis() - Long.parseLong(data)) < MIN_TIME_BETWEEN_2_BLESSINGS))
								{
									_blessedPlayers.put(plb.getAccountName(), Long.parseLong(data));
									continue;
								}
							}
							for (L2Npc santaHelper : SantaHelpers)
							{
								Collection<L2PcInstance> playerList = santaHelper.getKnownList().getKnownPlayers().values();
								for (L2PcInstance playerx : playerList)
								{
									if (playerx.getClassId().isMage())
									{
										for (int buffId : SantaMageBuffs)
										{
											if (playerx.getFirstEffect(buffId) == null)
											{
												playerx.broadcastPacket(new MagicSkillUse(santaHelper, playerx, buffId, 1, 2000, 1));
												SkillTable.getInstance().getInfo(buffId, 1).getEffects(playerx, playerx);
												_blessedPlayers.put(playerx.getAccountName(), System.currentTimeMillis());
												saveGlobalQuestVar(playerx.getAccountName(), String.valueOf(System.currentTimeMillis()));
											}
										}
									}
									else
									{
										for (int buffId : SantaFighterBuffs)
										{
											if (playerx.getFirstEffect(buffId) == null)
											{
												playerx.broadcastPacket(new MagicSkillUse(santaHelper, playerx, buffId, 1, 2000, 1));
												SkillTable.getInstance().getInfo(buffId, 1).getEffects(playerx, playerx);
												_blessedPlayers.put(playerx.getAccountName(), System.currentTimeMillis());
												saveGlobalQuestVar(playerx.getAccountName(), String.valueOf(System.currentTimeMillis()));
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		else if (event.equalsIgnoreCase("SpecialTreeHeal"))
		{
			this.startQuestTimer("SpecialTreeHeal", 9000, null, null);
			for (L2Npc tree : specialTrees)
			{
				Collection<L2PcInstance> playerList = tree.getKnownList().getKnownPlayers().values();
				for (L2PcInstance playerr : playerList)
				{
					int xxMin = tree.getX() - 60;
					int yyMin = tree.getY() - 60;
					int xxMax = tree.getX() + 60;
					int yyMax = tree.getY() + 60;
					int playerX = playerr.getX();
					int playerY = playerr.getY();
					
					if ((playerX > xxMin) && (playerX < xxMax) && (playerY > yyMin) && (playerY < yyMax))
					{
						SkillTable.getInstance().getInfo(2139, 1).getEffects(tree, playerr);
					}
				}
			}
		}
		else if (player != null)
		{
			QuestState st = player.getQuestState(qn);
			if (st == null)
			{
				st = newQuestState(player);
			}
			//FIXME: Unhardcore html!
			if (event.equalsIgnoreCase("Tree"))
			{
				int itemsOk = 0;
				htmltext = "<html><title>Christmas Event</title><body><br><br><table width=260><tr><td></td><td width=40></td><td width=40></td></tr><tr><td><font color=LEVEL>Christmas Tree</font></td><td width=40><img src=\"Icon.etc_x_mas_tree_i00\" width=32 height=32></td><td width=40></td></tr></table><br><br><table width=260>";
				
				for (int i = 0; i < RequiredPieces.length; i++)
				{
					long pieceCount = st.getQuestItemsCount(RequiredPieces[i]);
					if (pieceCount >= RequiredQty[i])
					{
						itemsOk = itemsOk + 1;
						htmltext = htmltext + "<tr><td>" + ItemTable.getInstance().getTemplate(RequiredPieces[i]).getName() + "</td><td width=40>" + pieceCount + "</td><td width=40><font color=0FF000>OK</font></td></tr>";
					}
					
					else
					{
						htmltext = htmltext + "<tr><td>" + ItemTable.getInstance().getTemplate(RequiredPieces[i]).getName() + "</td><td width=40>" + pieceCount + "</td><td width=40><font color=8ae2ffb>NO</font></td></tr>";
					}
				}
				
				if (itemsOk == 4)
				{
					htmltext = htmltext + "<tr><td><br></td><td width=40></td><td width=40></td></tr></table><table width=260>";
					htmltext = htmltext + "<tr><td><center><button value=\"Get the tree\" action=\"bypass -h Quest SavingSanta buyTree\" width=110 height=20 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></center></td></tr></table></body></html>";
				}
				else if (itemsOk < 4)
				{
					htmltext = htmltext + "</table><br><br>You do not have enough items.</center></body></html>";
				}
				
				return htmltext;
			}
			else if (event.equalsIgnoreCase("buyTree"))
			{
				st.playSound("ItemSound.quest_middle");
				
				for (int i = 0; i < RequiredPieces.length; i++)
				{
					if (st.getQuestItemsCount(RequiredPieces[i]) < RequiredQty[i])
					{
						return "";
					}
				}
				
				for (int i = 0; i < RequiredPieces.length; i++)
				{
					st.takeItems(RequiredPieces[i], RequiredQty[i]);
				}
				st.giveItems(5560, 1);
			}
			else if (event.equalsIgnoreCase("SpecialTree") && !SAVING_SANTA)
			{
				htmltext = "<html><title>Christmas Event</title><body><br><br><table width=260><tr><td></td><td width=40></td><td width=40></td></tr><tr><td><font color=LEVEL>Special Christmas Tree</font></td><td width=40><img src=\"Icon.etc_x_mas_tree_i00\" width=32 height=32></td><td width=40></td></tr></table><br><br><table width=260>";
				long pieceCount = st.getQuestItemsCount(5560);
				int itemsOk = 0;
				
				if (pieceCount >= 10)
				{
					itemsOk = 1;
					htmltext = htmltext + "<tr><td>Christmas Tree</td><td width=40>" + pieceCount + "</td><td width=40><font color=0FF000>OK</font></td></tr>";
				}
				else
				{
					htmltext = htmltext + "<tr><td>Christmas Tree</td><td width=40>" + pieceCount + "</td><td width=40><font color=8ae2ffb>NO</font></td></tr>";
				}
				
				if (itemsOk == 1)
				{
					htmltext = htmltext + "<tr><td><br></td><td width=40></td><td width=40></td></tr></table><table width=260>";
					htmltext = htmltext + "<tr><td><br></td><td width=40></td><td width=40></td></tr></table><table width=260>";
					htmltext = htmltext + "<tr><td><center><button value=\"Get the tree\" action=\"bypass -h Quest SavingSanta buySpecialTree\" width=110 height=20 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></center></td></tr></table></body></html>";
				}
				else if (itemsOk == 0)
				{
					htmltext = htmltext + "</table><br><br>You do not have enough items.</center></body></html>";
				}
				
				return htmltext;
			}
			else if (event.equalsIgnoreCase("buySpecialTree") && !SAVING_SANTA)
			{
				st.playSound("ItemSound.quest_middle");
				if (st.getQuestItemsCount(5560) < 10)
				{
					return "";
				}
				st.takeItems(5560, 10);
				st.giveItems(5561, 1);
			}
			else if (event.equalsIgnoreCase("SantaHat"))
			{
				htmltext = "<html><title>Christmas Event</title><body><br><br><table width=260><tr><td></td><td width=40></td><td width=40></td></tr><tr><td><font color=LEVEL>Santa's Hat</font></td><td width=40><img src=\"Icon.Accessory_santas_cap_i00\" width=32 height=32></td><td width=40></td></tr></table><br><br><table width=260>";
				long pieceCount = st.getQuestItemsCount(5560);
				int itemsOk = 0;
				
				if (pieceCount >= 10)
				{
					itemsOk = 1;
					htmltext = htmltext + "<tr><td>Christmas Tree</td><td width=40>" + pieceCount + "</td><td width=40><font color=0FF000>OK</font></td></tr>";
				}
				else
				{
					htmltext = htmltext + "<tr><td>Christmas Tree</td><td width=40>" + pieceCount + "</td><td width=40><font color=8ae2ffb>NO</font></td></tr>";
				}
				
				if (itemsOk == 1)
				{
					htmltext = htmltext + "<tr><td><br></td><td width=40></td><td width=40></td></tr></table><table width=260>";
					htmltext = htmltext + "<tr><td><center><button value=\"Get the hat\" action=\"bypass -h Quest SavingSanta buyHat\" width=110 height=20 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></center></td></tr></table></body></html>";
				}
				else if (itemsOk == 0)
				{
					htmltext = htmltext + "</table><br><br>You do not have enough items.</center></body></html>";
				}
				return htmltext;
			}
			else if (event.equalsIgnoreCase("buyHat"))
			{
				st.playSound("ItemSound.quest_middle");
				if (st.getQuestItemsCount(5560) < 10)
				{
					return "";
				}
				st.takeItems(5560, 10);
				st.giveItems(7836, 1);
			}
			//FIXME: Unhardcore html!
			else if (event.equalsIgnoreCase("SavingSantaHat") && SAVING_SANTA)
			{
				htmltext = "<html><title>Christmas Event</title><body><br><br><table width=260><tr><td></td><td width=40></td><td width=40></td></tr><tr><td><font color=LEVEL>Saving Santa's Hat</font></td><td width=40><img src=\"Icon.Accessory_santas_cap_i00\" width=32 height=32></td><td width=40></td></tr></table><br><br><table width=260>";
				long pieceCount = st.getQuestItemsCount(57);
				int itemsOk = 0;
				
				if (pieceCount >= 50000)
				{
					itemsOk = 1;
					htmltext = htmltext + "<tr><td>Adena</td><td width=40>" + pieceCount + "</td><td width=40><font color=0FF000>OK</font></td></tr>";
				}
				
				else
				{
					htmltext = htmltext + "<tr><td>Adena</td><td width=40>" + pieceCount + "</td><td width=40><font color=8ae2ffb>NO</font></td></tr>";
				}
				
				if (itemsOk == 1)
				{
					htmltext = htmltext + "<tr><td><br></td><td width=40></td><td width=40></td></tr></table><table width=260>";
					htmltext = htmltext + "<tr><td><center><button value=\"Get the hat\" action=\"bypass -h Quest SavingSanta buySavingHat\" width=110 height=20 back=\"L2UI_ct1.button_df\" fore=\"L2UI_ct1.button_df\"></center></td></tr></table></body></html>";
				}
				
				else if (itemsOk == 0)
				{
					htmltext = htmltext + "</table><br><br>You do not have enough Adena.</center></body></html>";
				}
				
				return htmltext;
			}
			
			else if (event.equalsIgnoreCase("buySavingHat") && SAVING_SANTA)
			{
				st.playSound("ItemSound.quest_middle");
				if (st.getQuestItemsCount(57) < 50000)
				{
					return "";
				}
				st.takeItems(57, 50000);
				st.giveItems(20100, 1);
			}
			else if (event.equalsIgnoreCase("HolidayFestival") && SAVING_SANTA)
			{
				if (isSantaFree)
				{
					npc.broadcastPacket(new MagicSkillUse(npc, player, HOLIDAYBUFFID, 1, 2000, 1));
					SkillTable.getInstance().getInfo(HOLIDAYBUFFID, 1).getEffects(player, player);
				}
				else
				{
					return "savingsanta-nobuff.htm";
				}
			}
			else if (event.equalsIgnoreCase("getWeapon") && SAVING_SANTA)
			{
				if ((st.getQuestItemsCount(20107) == 0) && (st.getQuestItemsCount(20108) == 0))
				{
					return "savingsanta-noweapon.htm";
				}
				return "savingsanta-weapon.htm";
			}
			else if (event.startsWith("weapon_") && SAVING_SANTA)
			{
				if (st.getQuestItemsCount(20108) != 0)
				{
					st.takeItems(20108, 1);
					st.giveItems(RANDOM_A_PLUS_10_WEAPON[Rnd.get(RANDOM_A_PLUS_10_WEAPON.length)], 1, 10);
					return "";
				}
				else if ((st.getQuestItemsCount(20107) == 0) || (player.getLevel() < 20))
				{
					return "";
				}
				
				int grade = player.getSkillLevel(239) - 1;
				
				if (grade < -1)
				{
					return "";
				}
				int itemId = Integer.parseInt(event.replace("weapon_", ""));
				
				if ((itemId < 1) || (itemId > 14))
				{
					return "";
				}
				else if (grade > 4)
				{
					grade = 4;
				}
				
				itemId += (20108 + grade * 14);
				st.takeItems(20107, 1);
				st.giveItems(itemId, 1, Rnd.get(4, 16));
			}
		}
		return "";
	}
	
	@Override
	public String onFirstTalk(L2Npc npc, L2PcInstance player)
	{
		String htmltext = "";
		int npcId = npc.getNpcId();
		QuestState st = player.getQuestState(getName());
		if (st == null)
		{
			st = newQuestState(player);
		}
		
		if ((npcId == ThomasDTurkeyId) || (npcId == HolidaySantaId) || (npcId == HolidaySledId))
		{
			player.sendPacket(ActionFailed.STATIC_PACKET);
			htmltext = null;
		}
		else if (npcId == SantaTraineeId)
		{
			if (SAVING_SANTA)
			{
				htmltext = "savingsanta.htm";
			}
			else
			{
				htmltext = "santa.htm";
			}
		}
		return htmltext;
	}
	
	@Override
	public boolean unload()
	{
		for (L2Npc eventnpc : SantaHelpers)
		{
			eventnpc.deleteMe();
		}
		for (L2Npc tree : specialTrees)
		{
			tree.deleteMe();
		}
		return super.unload();
	}
	
	@Override
	public String onAggroRangeEnter(L2Npc npc, L2PcInstance player, boolean isPet)
	{
		//FIXME: Increase Thomas D. Turkey aggro rage.
		if (npc.getNpcId() == ThomasDTurkeyId)
		{
			//I guess you came to rescue Santa. But you picked the wrong person.
			NpcSay IGuessYouCame = new NpcSay(npc.getObjectId(), 0, npc.getNpcId(), NpcStringId.I_GUESS_YOU_CAME_TO_RESCUE_SANTA_BUT_YOU_PICKED_THE_WRONG_PERSON);
			npc.broadcastPacket(IGuessYouCame);
		}
		return null;
	}
			
	public static void main(String[] args)
	{
		new SavingSanta(-1, qn, "events");
	}
}
