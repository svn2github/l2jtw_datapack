package transformations;

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.model.L2Transformation;

/**
 * Description: <br>
 * This will handle the transformation, giving the skills, and removing them, when the player logs out and is transformed these skills
 * do not save. 
 * 
 * @author durgus
 *
 */
public class LilimKnightStrong extends L2Transformation
{
	public LilimKnightStrong()
	{
		// id, colRadius, colHeight
		super(207, 8.0, 24.4);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 207 || getPlayer().isCursedWeaponEquipped())
			return;

		// give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Attack Buster
		getPlayer().addSkill(SkillTable.getInstance().getInfo(568, 4), false);
		// Attack Storm
		getPlayer().addSkill(SkillTable.getInstance().getInfo(569, 4), false);
		// Attack Rage
		getPlayer().addSkill(SkillTable.getInstance().getInfo(570, 4), false);
		// Poison Dust
		getPlayer().addSkill(SkillTable.getInstance().getInfo(571, 4), false);
		// Transfrom Dispel
		getPlayer().addSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5491, 1), false);

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,568,569,570,571});
	}

	public void onUntransform()
	{
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Attack Buster
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(568, 4), false);
		// Attack Storm
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(569, 4), false);
		// Attack Rage
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(570, 4), false);
		// Poison Dust
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(571, 4), false);
		// Transfrom Dispel
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5491, 1), false);

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new LilimKnightStrong());
	}
}
