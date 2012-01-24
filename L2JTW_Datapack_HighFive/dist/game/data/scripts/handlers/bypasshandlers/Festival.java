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
package handlers.bypasshandlers;

import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;

import com.l2jserver.Config;
import com.l2jserver.gameserver.SevenSigns;
import com.l2jserver.gameserver.SevenSignsFestival;
import com.l2jserver.gameserver.handler.IBypassHandler;
import com.l2jserver.gameserver.model.L2Party;
import com.l2jserver.gameserver.model.L2Party.messageType;
import com.l2jserver.gameserver.model.StatsSet;
import com.l2jserver.gameserver.model.actor.L2Character;
import com.l2jserver.gameserver.model.actor.instance.L2FestivalGuideInstance;
import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.items.instance.L2ItemInstance;
import com.l2jserver.gameserver.network.SystemMessageId;
import com.l2jserver.gameserver.network.serverpackets.NpcHtmlMessage;
import com.l2jserver.gameserver.network.serverpackets.SystemMessage;
import com.l2jserver.util.StringUtil;
import com.l2jserver.gameserver.datatables.MessageTable;

public class Festival implements IBypassHandler
{
	private static final String[] COMMANDS =
	{
		"festival", 
		"festivaldesc"
	};
	
	@Override
	public boolean useBypass(String command, L2PcInstance activeChar, L2Character target)
	{
		if (!(target instanceof L2FestivalGuideInstance))
		{
			return false;
		}
		
		final L2FestivalGuideInstance npc = (L2FestivalGuideInstance) target;
		
		try
		{
			final int val;
			if (command.toLowerCase().startsWith(COMMANDS[1]))
			{
				val = Integer.parseInt(command.substring(13));
				npc.showChatWindow(activeChar, val, null, true);
				return true;
			}
			
			final L2Party party;
			val = Integer.parseInt(command.substring(9, 10));
			switch (val)
			{
				case 1: // Become a Participant
					// Check if the festival period is active, if not then don't allow registration.
					if (SevenSigns.getInstance().isSealValidationPeriod())
					{
						npc.showChatWindow(activeChar, 2, "a", false);
						return true;
					}
					
					// Check if a festival is in progress, then don't allow registration yet.
					if (SevenSignsFestival.getInstance().isFestivalInitialized())
					{
						activeChar.sendMessage(1927);
						return true;
					}
					
					// Check if the player is in a formed party already.
					if (!activeChar.isInParty())
					{
						npc.showChatWindow(activeChar, 2, "b", false);
						return true;
					}
					
					party = activeChar.getParty();
					
					// Check if the player is the party leader.
					if (!party.isLeader(activeChar))
					{
						npc.showChatWindow(activeChar, 2, "c", false);
						return true;
					}
					
					// Check to see if the party has at least 5 members.
					if (party.getMemberCount() < Config.ALT_FESTIVAL_MIN_PLAYER)
					{
						npc.showChatWindow(activeChar, 2, "b", false);
						return true;
					}
					
					// Check if all the party members are in the required level range.
					if (party.getLevel() > SevenSignsFestival.getMaxLevelForFestival(npc.getFestivalType()))
					{
						npc.showChatWindow(activeChar, 2, "d", false);
						return true;
					}
					
					// Check to see if the player has already signed up
					if (activeChar.isFestivalParticipant())
					{
						SevenSignsFestival.getInstance().setParticipants(npc.getFestivalOracle(), npc.getFestivalType(), party);
						npc.showChatWindow(activeChar, 2, "f", false);
						return true;
					}
					
					npc.showChatWindow(activeChar, 1, null, false);
					break;
				case 2: // Seal Stones
					final int stoneType = Integer.parseInt(command.substring(11));
					final int stoneCount = npc.getStoneCount(stoneType);
					if (stoneCount <= 0)
					{
						return false;
					}
					
					if (!activeChar.destroyItemByItemId("SevenSigns", stoneType, stoneCount, npc, true))
					{
						return false;
					}
					
					SevenSignsFestival.getInstance().setParticipants(npc.getFestivalOracle(), npc.getFestivalType(), activeChar.getParty());
					SevenSignsFestival.getInstance().addAccumulatedBonus(npc.getFestivalType(), stoneType, stoneCount);
					
					npc.showChatWindow(activeChar, 2, "e", false);
					break;
				case 3: // Score Registration
					// Check if the festival period is active, if not then don't register the score.
					if (SevenSigns.getInstance().isSealValidationPeriod())
					{
						npc.showChatWindow(activeChar, 3, "a", false);
						return true;
					}
					
					// Check if a festival is in progress, if it is don't register the score.
					if (SevenSignsFestival.getInstance().isFestivalInProgress())
					{
						activeChar.sendMessage(1928);
						return true;
					}
					
					// Check if the player is in a party.
					if (!activeChar.isInParty())
					{
						npc.showChatWindow(activeChar, 3, "b", false);
						return true;
					}
					
					final List<Integer> prevParticipants = SevenSignsFestival.getInstance().getPreviousParticipants(npc.getFestivalOracle(), npc.getFestivalType());
					
					// Check if there are any past participants.
					if ((prevParticipants == null) || prevParticipants.isEmpty() || !prevParticipants.contains(activeChar.getObjectId()))
					{
						npc.showChatWindow(activeChar, 3, "b", false);
						return true;
					}
					
					// Check if this player was the party leader in the festival.
					if (activeChar.getObjectId() != prevParticipants.get(0))
					{
						npc.showChatWindow(activeChar, 3, "b", false);
						return true;
					}
					
					final L2ItemInstance bloodOfferings = activeChar.getInventory().getItemByItemId(SevenSignsFestival.FESTIVAL_OFFERING_ID);
					
					// Check if the player collected any blood offerings during the festival.
					if (bloodOfferings == null)
					{
						activeChar.sendMessage(1929);
						return true;
					}
					
					final long offeringScore = bloodOfferings.getCount() * SevenSignsFestival.FESTIVAL_OFFERING_VALUE;
					if (!activeChar.destroyItem("SevenSigns", bloodOfferings, npc, false))
					{
						return true;
					}
					
					final boolean isHighestScore = SevenSignsFestival.getInstance().setFinalScore(activeChar, npc.getFestivalOracle(), npc.getFestivalType(), offeringScore);
					SystemMessage sm = SystemMessage.getSystemMessage(SystemMessageId.CONTRIB_SCORE_INCREASED_S1);
					sm.addItemNumber(offeringScore);
					activeChar.sendPacket(sm);
					
					if (isHighestScore)
					{
						npc.showChatWindow(activeChar, 3, "c", false);
					}
					else
					{
						npc.showChatWindow(activeChar, 3, "d", false);
					}
					break;
				case 4: // Current High Scores
					final StringBuilder strBuffer = StringUtil.startAppend(500,	"<html><body>"+ MessageTable.Messages[1930].getMessage() +"<br>"+ MessageTable.Messages[1931].getMessage());
					
					final StatsSet dawnData = SevenSignsFestival.getInstance().getHighestScoreData(SevenSigns.CABAL_DAWN, npc.getFestivalType());
					final StatsSet duskData = SevenSignsFestival.getInstance().getHighestScoreData(SevenSigns.CABAL_DUSK, npc.getFestivalType());
					final StatsSet overallData = SevenSignsFestival.getInstance().getOverallHighestScoreData(npc.getFestivalType());
					
					final int dawnScore = dawnData.getInteger("score");
					final int duskScore = duskData.getInteger("score");
					int overallScore = 0;
					
					// If no data is returned, assume there is no record, or all scores are 0.
					if (overallData != null)
					{
						overallScore = overallData.getInteger("score");
					}
					
					StringUtil.append(strBuffer, SevenSignsFestival.getFestivalName(npc.getFestivalType()),	MessageTable.Messages[1932].getMessage() +"<br>");
					
					if (dawnScore > 0)
					{
						StringUtil.append(strBuffer, MessageTable.Messages[1934].getMessage(), calculateDate(dawnData.getString("date")), MessageTable.Messages[1933].getMessage(), String.valueOf(dawnScore), "<br>", dawnData.getString("members"), "<br>");
					}
					else
					{
						strBuffer.append(MessageTable.Messages[1935].getMessage() +"<br>");
					}
					
					if (duskScore > 0)
					{
						StringUtil.append(strBuffer, MessageTable.Messages[1936].getMessage(), calculateDate(duskData.getString("date")), MessageTable.Messages[1933].getMessage(), String.valueOf(duskScore), "<br>", duskData.getString("members"), "<br>");
					}
					else
					{
						strBuffer.append(MessageTable.Messages[1937].getMessage() +"<br>");
					}
					
					if (overallScore > 0)
					{
						final String cabalStr;
						if (overallData.getString("cabal").equals("dawn"))
						{
							cabalStr = MessageTable.Messages[1939].getMessage();
						}
						else
						{
							cabalStr = MessageTable.Messages[1938].getMessage();
						}
						
						StringUtil.append(strBuffer, MessageTable.Messages[1940].getMessage(), calculateDate(overallData.getString("date")), MessageTable.Messages[1933].getMessage(), String.valueOf(overallScore), "<br>"+ MessageTable.Messages[1941].getMessage(), cabalStr, "<br>", overallData.getString("members"), "<br>");
					}
					else
					{
						strBuffer.append(MessageTable.Messages[1942].getMessage() +"<br>");
					}
					
					StringUtil.append(strBuffer, "<a action=\"bypass -h npc_", String.valueOf(npc.getObjectId()), "_Chat 0\">"+ MessageTable.Messages[1943].getMessage() +"</a></body></html>");
					
					NpcHtmlMessage html = new NpcHtmlMessage(npc.getObjectId());
					html.setHtml(strBuffer.toString());
					activeChar.sendPacket(html);
					break;
				case 8: // Increase the Festival Challenge
					if (!activeChar.isInParty())
					{
						return true;
					}
					
					if (!SevenSignsFestival.getInstance().isFestivalInProgress())
					{
						return true;
					}
					
					party = activeChar.getParty();
					if (!party.isLeader(activeChar))
					{
						npc.showChatWindow(activeChar, 8, "a", false);
						return true;
					}
					
					if (SevenSignsFestival.getInstance().increaseChallenge(npc.getFestivalOracle(), npc.getFestivalType()))
					{
						npc.showChatWindow(activeChar, 8, "b", false);
					}
					else
					{
						npc.showChatWindow(activeChar, 8, "c", false);
					}
					break;
				case 9: // Leave the Festival
					if (!activeChar.isInParty())
					{
						return true;
					}
					
					party = activeChar.getParty();
					if (party.isLeader(activeChar))
					{
						SevenSignsFestival.getInstance().updateParticipants(activeChar, null);
					}
					else
					{
						if (party.getMemberCount() > Config.ALT_FESTIVAL_MIN_PLAYER)
						{
							party.removePartyMember(activeChar, messageType.Expelled);
						}
						else
						{
							activeChar.sendMessage(1944);
						}
					}
					break;
				case 0: // Distribute Accumulated Bonus
					if (!SevenSigns.getInstance().isSealValidationPeriod())
					{
						activeChar.sendPacket(SystemMessageId.SETTLE_ACCOUNT_ONLY_IN_SEAL_VALIDATION);
						return true;
					}
					
					if (SevenSignsFestival.getInstance().distribAccumulatedBonus(activeChar) > 0)
					{
						npc.showChatWindow(activeChar, 0, "a", false);
					}
					else
					{
						npc.showChatWindow(activeChar, 0, "b", false);
					}
					break;
				default:
					npc.showChatWindow(activeChar, val, null, false);
			}
			return true;
		}
		catch (Exception e)
		{
			_log.log(Level.WARNING, "Exception in " + getClass().getSimpleName(), e);
		}
		return false;
	}
	
	private final String calculateDate(String milliFromEpoch)
	{
		long numMillis = Long.valueOf(milliFromEpoch);
		Calendar calCalc = Calendar.getInstance();
		calCalc.setTimeInMillis(numMillis);
		return calCalc.get(Calendar.YEAR) + "/" + calCalc.get(Calendar.MONTH) + "/" + calCalc.get(Calendar.DAY_OF_MONTH);
	}
	
	@Override
	public String[] getBypassList()
	{
		return COMMANDS;
	}
}
