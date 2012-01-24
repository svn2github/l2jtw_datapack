package handlers.effecthandlers;

import com.l2jserver.gameserver.model.actor.instance.L2PcInstance;
import com.l2jserver.gameserver.model.effects.EffectTemplate;
import com.l2jserver.gameserver.model.effects.L2Effect;
import com.l2jserver.gameserver.model.effects.L2EffectType;
import com.l2jserver.gameserver.model.stats.Env;


/**
 * @author JaJa (l2.brick)
 */

public class RecoBonus extends L2Effect
{
	public RecoBonus(Env env, EffectTemplate template)
	{
		super(env, template);
	}
	
	/**
	 * @see com.l2jserver.gameserver.model.effects.L2Effect#getEffectType()
	 */
	@Override
	public L2EffectType getEffectType()
	{
		return L2EffectType.BUFF;
	}
	
	/**
	 * @see com.l2jserver.gameserver.model.effects.L2Effect#onStart()
	 */
	@Override
	public boolean onStart()
	{
		if (!(getEffected() instanceof L2PcInstance))
			return false;
			
		((L2PcInstance) getEffected()).setRecomBonusType(1).setRecoBonusActive(true);
		return true;
	}
	
	/**
	 * @see com.l2jserver.gameserver.model.effects.L2Effect#onExit()
	 */
	@Override
	public void onExit()
	{
		((L2PcInstance) getEffected()).setRecomBonusType(0).setRecoBonusActive(false);
	}
	
	@Override
	protected boolean effectCanBeStolen()
	{
		return false;
	}
	
	/**
	 * @see com.l2jserver.gameserver.model.effects.L2Effect#onActionTime()
	 */
	@Override
	public boolean onActionTime()
	{
		return false;
	}       
}