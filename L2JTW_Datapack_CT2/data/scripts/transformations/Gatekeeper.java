package transformations;

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.model.L2Skill;
import net.sf.l2j.gameserver.model.L2Transformation;

/**
 * Description: <br>
 * This will handle the transformation, giving the skills, and removing them, when the player logs out and is transformed these skills
 * do not save. 
 * When the player logs back in, there will be a call from the enterworld packet that will add all their skills.
 * The enterworld packet will transform a player.
 * 
 * @author Psychokiller1888
 *
 */
public class Gatekeeper extends L2Transformation
{
	public Gatekeeper()
	{
		// id, duration (secs), colRadius, colHeight
		super(107, 1800, 8.0, 24.0);
	}

	public void onTransform()
	{
		// Disable all character skills.
		for (L2Skill sk : this.getPlayer().getAllSkills())
		{
			if (sk != null && !sk.isPassive())
				this.getPlayer().removeSkill(sk, false, false);
		}
		if (this.getPlayer().transformId() > 0 && !this.getPlayer().isCursedWeaponEquipped())
		{
			// give transformation skills
			transformedSkills();
			return;
		}
		// give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Transfrom Dispel
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(5655, 1), false);
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(5656, 85), false);
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(5657, 85), false);
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(5658, 85), false);
		this.getPlayer().addSkill(SkillTable.getInstance().getInfo(5659, 2), false);
		this.getPlayer().sendSkillList();
	}

	public void onUntransform()
	{
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Transfrom Dispel
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(5655, 1), false);
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(5656, 85), false);
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(5657, 85), false);
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(5658, 85), false);
		this.getPlayer().removeSkill(SkillTable.getInstance().getInfo(5659, 2), false);
		this.getPlayer().sendSkillList();
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new Gatekeeper());
	}
}