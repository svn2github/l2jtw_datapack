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

package handlers.voicedcommandhandlers;

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
import com.l2jserver.gameserver.model.L2Skill;
import com.l2jserver.gameserver.model.L2World;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.entity.TvTEvent;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.ActionFailed;
import com.l2jserver.gameserver.network.serverpackets.ConfirmDlg;
import com.l2jserver.gameserver.network.serverpackets.MagicSkillUse;
import com.l2jserver.gameserver.network.serverpackets.SetupGauge;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.gameserver.skills.AbnormalEffect;
import com.l2jserver.gameserver.util.Broadcast;
import com.l2jserver.gameserver.datatables.MessageTable;

/**
 * @author evill33t
 *
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
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IVoicedCommandHandler#useVoicedCommand(java.lang.String, com.l2jserver.gameserver.model.actor.instance.L2PcInstance, java.lang.String)
	 */
	public boolean useVoicedCommand(String command, L2PcInstance activeChar, String params)
	{
		if (command.startsWith("engage"))
			return engage(activeChar);
		else if (command.startsWith("divorce"))
			return divorce(activeChar);
		else if (command.startsWith("gotolove"))
			return goToLove(activeChar);
		return false;
	}
	
	public boolean divorce(L2PcInstance activeChar)
	{
		if (activeChar.getPartnerId() == 0)
			return false;
		
		int _partnerId = activeChar.getPartnerId();
		int _coupleId = activeChar.getCoupleId();
		long AdenaAmount = 0;
		
		if (activeChar.isMarried())
		{
			activeChar.sendMessage(1215);
			
			AdenaAmount = (activeChar.getAdena() / 100) * Config.L2JMOD_WEDDING_DIVORCE_COSTS;
			activeChar.getInventory().reduceAdena("Wedding", AdenaAmount, activeChar, null);
			
		}
		else
			activeChar.sendMessage(1216);
		
		L2PcInstance partner;
		partner = (L2PcInstance) L2World.getInstance().findObject(_partnerId);
		
		if (partner != null)
		{
			partner.setPartnerId(0);
			if (partner.isMarried())
				partner.sendMessage(1217);
			else
				partner.sendMessage(1218);
			
			// give adena
			if (AdenaAmount > 0)
				partner.addAdena("WEDDING", AdenaAmount, null, false);
		}
		
		CoupleManager.getInstance().deleteCouple(_coupleId);
		return true;
	}
	
	public boolean engage(L2PcInstance activeChar)
	{
		// check target
		if (activeChar.getTarget() == null)
		{
			activeChar.sendMessage(1219);
			return false;
		}
		
		// check if target is a l2pcinstance
		if (!(activeChar.getTarget() instanceof L2PcInstance))
		{
			activeChar.sendMessage(1220);
			
			return false;
		}
		
		// check if player is already engaged
		if (activeChar.getPartnerId() != 0)
		{
			activeChar.sendMessage(1221);
			if (Config.L2JMOD_WEDDING_PUNISH_INFIDELITY)
			{
				activeChar.startAbnormalEffect(AbnormalEffect.BIG_HEAD); // give player a Big Head
				// lets recycle the sevensigns debuffs
				int skillId;
				
				int skillLevel = 1;
				
				if (activeChar.getLevel() > 40)
					skillLevel = 2;
				
				if (activeChar.isMageClass())
					skillId = 4362;
				else
					skillId = 4361;
				
				L2Skill skill = SkillTable.getInstance().getInfo(skillId, skillLevel);
				
				if (activeChar.getFirstEffect(skill) == null)
				{
					skill.getEffects(activeChar, activeChar);
					SystemMessage sm = new SystemMessage(SystemMessageId.YOU_FEEL_S1_EFFECT);
					sm.addSkillName(skill);
					activeChar.sendPacket(sm);
				}
			}
			return false;
		}
		
		L2PcInstance ptarget = (L2PcInstance) activeChar.getTarget();
		
		// check if player target himself
		if (ptarget.getObjectId() == activeChar.getObjectId())
		{
			activeChar.sendMessage(1222);
			return false;
		}
		
		if (ptarget.isMarried())
		{
			activeChar.sendMessage(1223);
			return false;
		}
		
		if (ptarget.isEngageRequest())
		{
			activeChar.sendMessage(1224);
			return false;
		}
		
		if (ptarget.getPartnerId() != 0)
		{
			activeChar.sendMessage(1225);
			return false;
		}
		
		if (ptarget.getAppearance().getSex() == activeChar.getAppearance().getSex() && !Config.L2JMOD_WEDDING_SAMESEX)
		{
			activeChar.sendMessage(1226);
			return false;
		}
		
		// check if target has player on friendlist
		boolean FoundOnFriendList = false;
		int objectId;
		java.sql.Connection con = null;
		try
		{
			con = L2DatabaseFactory.getInstance().getConnection();
			PreparedStatement statement;
			statement = con.prepareStatement("SELECT friendId FROM character_friends WHERE charId=?");
			statement.setInt(1, ptarget.getObjectId());
			ResultSet rset = statement.executeQuery();
			
			while (rset.next())
			{
				objectId = rset.getInt("friendId");
				if (objectId == activeChar.getObjectId())
					FoundOnFriendList = true;
			}
			statement.close();
		}
		catch (Exception e)
		{
			_log.warning("could not read friend data:" + e);
		}
		finally
		{
			try
			{
				con.close();
			}
			catch (Exception e)
			{
			}
		}
		
		if (!FoundOnFriendList)
		{
			activeChar.sendMessage(1227);
			return false;
		}
		
		ptarget.setEngageRequest(true, activeChar.getObjectId());
		// $s1
		ConfirmDlg dlg = new ConfirmDlg(SystemMessageId.S1.getId()).addString(MessageTable.Messages[1228].getExtra(1) + activeChar.getName() + MessageTable.Messages[1228].getExtra(2));
		ptarget.sendPacket(dlg);
		return true;
	}
	
	public boolean goToLove(L2PcInstance activeChar)
	{
		if (!activeChar.isMarried())
		{
			activeChar.sendMessage(1229);
			return false;
		}
		
		if (activeChar.getPartnerId() == 0)
		{
			activeChar.sendMessage(1230);
			_log.severe("Married but couldn't find parter for " + activeChar.getName());
			return false;
		}
		
		if (GrandBossManager.getInstance().getZone(activeChar) != null)
		{
			activeChar.sendMessage(1231);
			return false;
		}
		if (activeChar.isCombatFlagEquipped())
		{
			activeChar.sendMessage(1232);
			return false;
		}
		
		L2PcInstance partner;
		partner = (L2PcInstance) L2World.getInstance().findObject(activeChar.getPartnerId());
		if (partner == null)
		{
			activeChar.sendMessage(1233);
			return false;
		}
		else if (activeChar.getInstanceId() != partner.getInstanceId())
		{
			activeChar.sendMessage(1234);
			return false;
		}
		else if (partner.isInJail())
		{
			activeChar.sendMessage(1235);
			return false;
		}
		else if (GrandBossManager.getInstance().getZone(partner) != null)
		{
			activeChar.sendMessage(1236);
			return false;
		}
		else if (partner.isInOlympiadMode())
		{
			activeChar.sendMessage(1237);
			return false;
		}
		else if (partner.atEvent)
		{
			activeChar.sendMessage(1238);
			return false;
		}
		else if (partner.isInDuel())
		{
			activeChar.sendMessage(1239);
			return false;
		}
		else if (partner.isFestivalParticipant())
		{
			activeChar.sendMessage(1240);
			return false;
		}
		else if (partner.isInParty() && partner.getParty().isInDimensionalRift())
		{
			activeChar.sendMessage(1241);
			return false;
		}
		else if (partner.inObserverMode())
		{
			activeChar.sendMessage(1242);
			return false;
		}
		else if (SiegeManager.getInstance().getSiege(partner) != null && SiegeManager.getInstance().getSiege(partner).getIsInProgress())
		{
			activeChar.sendMessage(1243);
			return false;
		}
		else if (partner.isIn7sDungeon() && !activeChar.isIn7sDungeon())
		{
			int playerCabal = SevenSigns.getInstance().getPlayerCabal(activeChar.getObjectId());
			boolean isSealValidationPeriod = SevenSigns.getInstance().isSealValidationPeriod();
			int compWinner = SevenSigns.getInstance().getCabalHighestScore();
			
			if (isSealValidationPeriod)
			{
				if (playerCabal != compWinner)
				{
					activeChar.sendMessage(1244);
					return false;
				}
			}
			else
			{
				if (playerCabal == SevenSigns.CABAL_NULL)
				{
					activeChar.sendMessage(1245);
					return false;
				}
			}
		}
		else if (!TvTEvent.onEscapeUse(partner.getObjectId()))
		{
			activeChar.sendMessage(1246);
			return false;
		}
		else if (partner.isInsideZone(L2Character.ZONE_NOSUMMONFRIEND))
		{
			activeChar.sendMessage(1247);
			return false;
		}
		else if (activeChar.isInJail())
		{
			activeChar.sendMessage(1248);
			return false;
		}
		else if (activeChar.isInOlympiadMode())
		{
			activeChar.sendMessage(1249);
			return false;
		}
		else if (activeChar.atEvent)
		{
			activeChar.sendMessage(1250);
			return false;
		}
		else if (activeChar.isInDuel())
		{
			activeChar.sendMessage(1251);
			return false;
		}
		else if (activeChar.inObserverMode())
		{
			activeChar.sendMessage(1252);
			return false;
		}
		else if (SiegeManager.getInstance().getSiege(activeChar) != null && SiegeManager.getInstance().getSiege(activeChar).getIsInProgress())
		{
			activeChar.sendMessage(1253);
			return false;
		}
		else if (activeChar.isFestivalParticipant())
		{
			activeChar.sendMessage(1254);
			return false;
		}
		else if (activeChar.isInParty() && activeChar.getParty().isInDimensionalRift())
		{
			activeChar.sendMessage(1255);
			return false;
		}
		// Thanks nbd
		else if (!TvTEvent.onEscapeUse(activeChar.getObjectId()))
		{
			activeChar.sendPacket(ActionFailed.STATIC_PACKET);
			return false;
		}
		else if (activeChar.isInsideZone(L2Character.ZONE_NOSUMMONFRIEND))
		{
			activeChar.sendMessage(1256);
			return false;
		}
		//Add By Tiger 2010/01/13 (S)
		else if (activeChar.isCursedWeaponEquipped())
		{
			activeChar.sendMessage(1257);
			return false;
		}
		else if (partner.isCursedWeaponEquipped())
		{
			activeChar.sendMessage(1258);
			return false;
		}
		//Add By Tiger 2010/01/13 (E)
		
		int teleportTimer = Config.L2JMOD_WEDDING_TELEPORT_DURATION * 1000;
		
		activeChar.sendMessage(MessageTable.Messages[1259].getExtra(1) + teleportTimer / 60000 + MessageTable.Messages[1259].getExtra(2));
		activeChar.getInventory().reduceAdena("Wedding", Config.L2JMOD_WEDDING_TELEPORT_PRICE, activeChar, null);
		
		activeChar.getAI().setIntention(CtrlIntention.AI_INTENTION_IDLE);
		//SoE Animation section
		activeChar.setTarget(activeChar);
		activeChar.disableAllSkills();
		
		MagicSkillUse msk = new MagicSkillUse(activeChar, 1050, 1, teleportTimer, 0);
		Broadcast.toSelfAndKnownPlayersInRadius(activeChar, msk, 810000/*900*/);
		SetupGauge sg = new SetupGauge(0, teleportTimer);
		activeChar.sendPacket(sg);
		//End SoE Animation section
		
		EscapeFinalizer ef = new EscapeFinalizer(activeChar, partner.getX(), partner.getY(), partner.getZ(), partner.isIn7sDungeon());
		// continue execution later
		activeChar.setSkillCast(ThreadPoolManager.getInstance().scheduleGeneral(ef, teleportTimer));
		activeChar.forceIsCasting(GameTimeController.getGameTicks() + teleportTimer / GameTimeController.MILLIS_IN_TICK);
		
		return true;
	}
	
	static class EscapeFinalizer implements Runnable
	{
		private L2PcInstance _activeChar;
		private int _partnerx;
		private int _partnery;
		private int _partnerz;
		private boolean _to7sDungeon;
		
		EscapeFinalizer(L2PcInstance activeChar, int x, int y, int z, boolean to7sDungeon)
		{
			_activeChar = activeChar;
			_partnerx = x;
			_partnery = y;
			_partnerz = z;
			_to7sDungeon = to7sDungeon;
		}
		
		public void run()
		{
			if (_activeChar.isDead())
				return;
			
			if(SiegeManager.getInstance().getSiege(_partnerx, _partnery, _partnerz) != null && SiegeManager.getInstance().getSiege(_partnerx, _partnery, _partnerz).getIsInProgress())
			{
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
	
	/**
	 * 
	 * @see com.l2jserver.gameserver.handler.IVoicedCommandHandler#getVoicedCommandList()
	 */
	public String[] getVoicedCommandList()
	{
		return _voicedCommands;
	}
}
