/*
 * Copyright (C) 2004-2013 L2J DataPack
 * 
 * This file is part of L2J DataPack.
 * 
 * L2J DataPack is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * L2J DataPack is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package handlers.voicedcommandhandlers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.l2jserver.Config;
import com.l2jserver.L2DatabaseFactory;
import com.l2jserver.gameserver.GameTimeController;
import com.l2jserver.gameserver.SevenSigns;
import com.l2jserver.gameserver.ThreadPoolManager;
import com.l2jserver.gameserver.ai.CtrlIntention;
import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.handler.IVoicedCommandHandler;
import com.l2jserver.gameserver.instancemanager.CoupleManager;
import com.l2jserver.gameserver.instancemanager.GrandBossManager;
import com.l2jserver.gameserver.instancemanager.SiegeManager;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.effects.AbnormalEffect;
import com.l2jserver.gameserver.model.entity.L2Event;
import com.l2jserver.gameserver.model.entity.TvTEvent;
import com.l2jserver.gameserver.model.skills.L2Skill;
import com.l2jserver.gameserver.model.zone.ZoneId;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.ActionFailed;
import com.l2jserver.gameserver.network.serverpackets.ConfirmDlg;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.SetupGauge;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.util.Broadcast;
import com.l2jserver.gameserver.datatables.MessageTable; // Add By L2JTW

/**
 * @author evill33t
 */
public class Wedding implements IVoicedCommandHandler
{
	static final Logger _log = Logger.getLogger(Wedding.class.getName());
	private static final String[] _voicedCommands =
	{
		"divorce",
		"engage",
		"gotolove"
	};
	
	@Override
	public boolean useVoicedCommand(String command, L2PcInstance activeChar, String params)
	{
		if (activeChar == null)
		{
			return false;
		}
		if (command.startsWith("engage"))
		{
			return engage(activeChar);
		}
		else if (command.startsWith("divorce"))
		{
			return divorce(activeChar);
		}
		else if (command.startsWith("gotolove"))
		{
			return goToLove(activeChar);
		}
		return false;
	}
	
	public boolean divorce(L2PcInstance activeChar)
	{
		if (activeChar.getPartnerId() == 0)
		{
			return false;
		}
		
		int _partnerId = activeChar.getPartnerId();
		int _coupleId = activeChar.getCoupleId();
		long AdenaAmount = 0;
		
		if (activeChar.isMarried())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are now divorced.");
			*/
			activeChar.sendMessage(1215);
			
			AdenaAmount = (activeChar.getAdena() / 100) * Config.L2JMOD_WEDDING_DIVORCE_COSTS;
			activeChar.getInventory().reduceAdena("Wedding", AdenaAmount, activeChar, null);
			
		}
		else
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You have broken up as a couple.");
			*/
			activeChar.sendMessage(1216);
		}
		
		final L2PcInstance partner = L2World.getInstance().getPlayer(_partnerId);
		if (partner != null)
		{
			partner.setPartnerId(0);
			if (partner.isMarried())
			{
				/* Move To MessageTable For L2JTW
				partner.sendMessage("Your spouse has decided to divorce you.");
				*/
				partner.sendMessage(1217);
			}
			else
			{
				/* Move To MessageTable For L2JTW
				partner.sendMessage("Your fiance has decided to break the engagement with you.");
				*/
				partner.sendMessage(1218);
			}
			
			// give adena
			if (AdenaAmount > 0)
			{
				partner.addAdena("WEDDING", AdenaAmount, null, false);
			}
		}
		CoupleManager.getInstance().deleteCouple(_coupleId);
		return true;
	}
	
	public boolean engage(L2PcInstance activeChar)
	{
		if (activeChar.getTarget() == null)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You have no one targeted.");
			*/
			activeChar.sendMessage(1219);
			return false;
		}
		else if (!(activeChar.getTarget() instanceof L2PcInstance))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You can only ask another player to engage you.");
			*/
			activeChar.sendMessage(1220);
			return false;
		}
		else if (activeChar.getPartnerId() != 0)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are already engaged.");
			*/
			activeChar.sendMessage(1221);
			if (Config.L2JMOD_WEDDING_PUNISH_INFIDELITY)
			{
				activeChar.startAbnormalEffect(AbnormalEffect.BIG_HEAD); // give player a Big Head
				// lets recycle the sevensigns debuffs
				int skillId;
				
				int skillLevel = 1;
				
				if (activeChar.getLevel() > 40)
				{
					skillLevel = 2;
				}
				
				if (activeChar.isMageClass())
				{
					skillId = 4362;
				}
				else
				{
					skillId = 4361;
				}
				
				final L2Skill skill = SkillTable.getInstance().getInfo(skillId, skillLevel);
				if (activeChar.getFirstEffect(skill) == null)
				{
					skill.getEffects(activeChar, activeChar);
					final SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT);
					sm.addSkillName(skill);
					activeChar.sendPacket(sm);
				}
			}
			return false;
		}
		final L2PcInstance ptarget = (L2PcInstance) activeChar.getTarget();
		// check if player target himself
		if (ptarget.getObjectId() == activeChar.getObjectId())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Is there something wrong with you, are you trying to go out with youself?");
			*/
			activeChar.sendMessage(1222);
			return false;
		}
		
		if (ptarget.isMarried())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Player already married.");
			*/
			activeChar.sendMessage(1223);
			return false;
		}
		
		if (ptarget.isEngageRequest())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Player already asked by someone else.");
			*/
			activeChar.sendMessage(1224);
			return false;
		}
		
		if (ptarget.getPartnerId() != 0)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Player already engaged with someone else.");
			*/
			activeChar.sendMessage(1225);
			return false;
		}
		
		if ((ptarget.getAppearance().getSex() == activeChar.getAppearance().getSex()) && !Config.L2JMOD_WEDDING_SAMESEX)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Gay marriage is not allowed on this server!");
			*/
			activeChar.sendMessage(1226);
			return false;
		}
		
		// check if target has player on friendlist
		boolean FoundOnFriendList = false;
		int objectId;
		try (Connection con = L2DatabaseFactory.getInstance().getConnection())
		{
			final PreparedStatement statement = con.prepareStatement("SELECT friendId FROM character_friends WHERE charId=?");
			statement.setInt(1, ptarget.getObjectId());
			final ResultSet rset = statement.executeQuery();
			while (rset.next())
			{
				objectId = rset.getInt("friendId");
				if (objectId == activeChar.getObjectId())
				{
					FoundOnFriendList = true;
				}
			}
			statement.close();
		}
		catch (Exception e)
		{
			_log.warning("could not read friend data:" + e);
		}
		
		if (!FoundOnFriendList)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("The player you want to ask is not on your friends list, you must first be on each others friends list before you choose to engage.");
			*/
			activeChar.sendMessage(1227);
			return false;
		}
		
		ptarget.setEngageRequest(true, activeChar.getObjectId());
		// $s1
		/* Move To MessageTable For L2JTW
		ConfirmDlg dlg = new ConfirmDlg(SystemMessageId.S1.getId()).addString(activeChar.getName() + " is asking to engage you. Do you want to start a new relationship?");
		*/
		ConfirmDlg dlg = new ConfirmDlg(SystemMessageId.S1.getId()).addString(MessageTable.Messages[1228].getExtra(1) + activeChar.getName() + MessageTable.Messages[1228].getExtra(2));
		ptarget.sendPacket(dlg);
		return true;
	}
	
	public boolean goToLove(L2PcInstance activeChar)
	{
		if (!activeChar.isMarried())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You're not married.");
			*/
			activeChar.sendMessage(1229);
			return false;
		}
		
		if (activeChar.getPartnerId() == 0)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Couldn't find your fiance in the Database - Inform a Gamemaster.");
			*/
			activeChar.sendMessage(1230);
			_log.severe("Married but couldn't find parter for " + activeChar.getName());
			return false;
		}
		
		if (GrandBossManager.getInstance().getZone(activeChar) != null)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are inside a Boss Zone.");
			*/
			activeChar.sendMessage(1231);
			return false;
		}
		
		if (activeChar.isCombatFlagEquipped())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("While you are holding a Combat Flag or Territory Ward you can't go to your love!");
			*/
			activeChar.sendMessage(1232);
			return false;
		}
		
		if (activeChar.isCursedWeaponEquipped())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("While you are holding a Cursed Weapon you can't go to your love!");
			*/
			activeChar.sendMessage(1257);
			return false;
		}
		
		if (GrandBossManager.getInstance().getZone(activeChar) != null)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are inside a Boss Zone.");
			*/
			activeChar.sendMessage(1261);
			return false;
		}
		
		if (activeChar.isInJail())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in Jail!");
			*/
			activeChar.sendMessage(1248);
			return false;
		}
		
		if (activeChar.isInOlympiadMode())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in the Olympiad now.");
			*/
			activeChar.sendMessage(1249);
			return false;
		}
		
		if (L2Event.isParticipant(activeChar))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in an event.");
			*/
			activeChar.sendMessage(1250);
			return false;
		}
		
		if (activeChar.isInDuel())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in a duel!");
			*/
			activeChar.sendMessage(1251);
			return false;
		}
		
		if (activeChar.inObserverMode())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in the observation.");
			*/
			activeChar.sendMessage(1252);
			return false;
		}
		
		if ((SiegeManager.getInstance().getSiege(activeChar) != null) && SiegeManager.getInstance().getSiege(activeChar).getIsInProgress())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in a siege, you cannot go to your partner.");
			*/
			activeChar.sendMessage(1253);
			return false;
		}
		
		if (activeChar.isFestivalParticipant())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in a festival.");
			*/
			activeChar.sendMessage(1254);
			return false;
		}
		
		if (activeChar.isInParty() && activeChar.getParty().isInDimensionalRift())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in the dimensional rift.");
			*/
			activeChar.sendMessage(1255);
			return false;
		}
		
		// Thanks nbd
		if (!TvTEvent.onEscapeUse(activeChar.getObjectId()))
		{
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return false;
		}
		
		if (activeChar.isInsideZone(ZoneId.NO_SUMMON_FRIEND))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("You are in area which blocks summoning.");
			*/
			activeChar.sendMessage(1256);
			return false;
		}
		
		final L2PcInstance partner = L2World.getInstance().getPlayer(activeChar.getPartnerId());
		if ((partner == null) || !partner.isOnline())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is not online.");
			*/
			activeChar.sendMessage(1233);
			return false;
		}
		
		if (activeChar.getInstanceId() != partner.getInstanceId())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in another World!");
			*/
			activeChar.sendMessage(1234);
			return false;
		}
		
		if (partner.isInJail())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in Jail.");
			*/
			activeChar.sendMessage(1235);
			return false;
		}
		
		if (partner.isCursedWeaponEquipped())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is holding a Cursed Weapon and you can't go to your love!");
			*/
			activeChar.sendMessage(1258);
			return false;
		}
		
		if (GrandBossManager.getInstance().getZone(partner) != null)
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is inside a Boss Zone.");
			*/
			activeChar.sendMessage(1236);
			return false;
		}
		
		if (partner.isInOlympiadMode())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in the Olympiad now.");
			*/
			activeChar.sendMessage(1237);
			return false;
		}
		
		if (L2Event.isParticipant(partner))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in an event.");
			*/
			activeChar.sendMessage(1238);
			return false;
		}
		
		if (partner.isInDuel())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in a duel.");
			*/
			activeChar.sendMessage(1239);
			return false;
		}
		
		if (partner.isFestivalParticipant())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in a festival.");
			*/
			activeChar.sendMessage(1240);
			return false;
		}
		
		if (partner.isInParty() && partner.getParty().isInDimensionalRift())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in dimensional rift.");
			*/
			activeChar.sendMessage(1241);
			return false;
		}
		
		if (partner.inObserverMode())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in the observation.");
			*/
			activeChar.sendMessage(1242);
			return false;
		}
		
		if ((SiegeManager.getInstance().getSiege(partner) != null) && SiegeManager.getInstance().getSiege(partner).getIsInProgress())
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in a siege, you cannot go to your partner.");
			*/
			activeChar.sendMessage(1243);
			return false;
		}
		
		if (partner.isIn7sDungeon() && !activeChar.isIn7sDungeon())
		{
			final int playerCabal = SevenSigns.getInstance().getPlayerCabal(activeChar.getObjectId());
			final boolean isSealValidationPeriod = SevenSigns.getInstance().isSealValidationPeriod();
			final int compWinner = SevenSigns.getInstance().getCabalHighestScore();
			
			if (isSealValidationPeriod)
			{
				if (playerCabal != compWinner)
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Your Partner is in a Seven Signs Dungeon and you are not in the winner Cabal!");
					*/
					activeChar.sendMessage(1244);
					return false;
				}
			}
			else
			{
				if (playerCabal == SevenSigns.CABAL_NULL)
				{
					/* Move To MessageTable For L2JTW
					activeChar.sendMessage("Your Partner is in a Seven Signs Dungeon and you are not registered!");
					*/
					activeChar.sendMessage(1245);
					return false;
				}
			}
		}
		
		if (!TvTEvent.onEscapeUse(partner.getObjectId()))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in an event.");
			*/
			activeChar.sendMessage(1246);
			return false;
		}
		
		if (partner.isInsideZone(ZoneId.NO_SUMMON_FRIEND))
		{
			/* Move To MessageTable For L2JTW
			activeChar.sendMessage("Your partner is in area which blocks summoning.");
			*/
			activeChar.sendMessage(1247);
			return false;
		}
		
		final int teleportTimer = Config.L2JMOD_WEDDING_TELEPORT_DURATION * 1000;
		/* Move To MessageTable For L2JTW
		activeChar.sendMessage("After " + (teleportTimer / 60000) + " min. you will be teleported to your partner.");
		*/
		activeChar.sendMessage(MessageTable.Messages[1259].getExtra(1) + (teleportTimer / 60000) + MessageTable.Messages[1259].getExtra(2));
		activeChar.getInventory().reduceAdena("Wedding", Config.L2JMOD_WEDDING_TELEPORT_PRICE, activeChar, null);
		
		activeChar.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		// SoE Animation section
		activeChar.setTarget(activeChar);
		activeChar.disableAllSkills();
		
		final MagicSkillUse msk = new MagicSkillUse(activeChar, 1050, 1, teleportTimer, 0);
		Broadcast.toSelfAndKnownPlayersInRadius(activeChar, msk, 900);
		final SetupGauge sg = new SetupGauge(0, teleportTimer);
		activeChar.sendPacket(sg);
		// End SoE Animation section
		
		final EscapeFinalizer ef = new EscapeFinalizer(activeChar, partner.getX(), partner.getY(), partner.getZ(), partner.isIn7sDungeon());
		// continue execution later
		activeChar.setSkillCast(ThreadPoolManager.getInstance().scheduleGeneral(ef, teleportTimer));
		activeChar.forceIsCasting(GameTimeController.getGameTicks() + (teleportTimer / GameTimeController.MILLIS_IN_TICK));
		
		return true;
	}
	
	static class EscapeFinalizer implements Runnable
	{
		private final L2PcInstance _activeChar;
		private final int _partnerx;
		private final int _partnery;
		private final int _partnerz;
		private final boolean _to7sDungeon;
		
		EscapeFinalizer(L2PcInstance activeChar, int x, int y, int z, boolean to7sDungeon)
		{
			_activeChar = activeChar;
			_partnerx = x;
			_partnery = y;
			_partnerz = z;
			_to7sDungeon = to7sDungeon;
		}
		
		@Override
		public void run()
		{
			if (_activeChar.isDead())
			{
				return;
			}
			
			if ((SiegeManager.getInstance().getSiege(_partnerx, _partnery, _partnerz) != null) && SiegeManager.getInstance().getSiege(_partnerx, _partnery, _partnerz).getIsInProgress())
			{
				/* Move To MessageTable For L2JTW
				_activeChar.sendMessage("Your partner is in siege, you can't go to your partner.");
				*/
				_activeChar.sendMessage(1260);
				return;
			}
			
			_activeChar.setIsIn7sDungeon(_to7sDungeon);
			_activeChar.enableAllSkills();
			_activeChar.setIsCastingNow(false);
			
			try
			{
				_activeChar.teleToLocation(_partnerx, _partnery, _partnerz);
			}
			catch (Exception e)
			{
				_log.log(Level.SEVERE, "", e);
			}
		}
	}
	
	@Override
	public String[] getVoicedCommandList()
	{
		return _voicedCommands;
	}
}
