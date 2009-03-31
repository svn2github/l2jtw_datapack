package transformations;

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.model.L2Transformation;

/**
 * Description: <br>
 * This will handle the transformation, giving the skills, and removing them, when the player logs out and is transformed these skills
 * do not save. 
 * When the player logs back in, there will be a call from the enterworld packet that will add all their skills.
 * The enterworld packet will transform a player.
 * 
 * @author Ahmed
 *
 */
public class DivineWizard extends L2Transformation
{
	public DivineWizard()
	{
		// id, duration (secs), colRadius, colHeight
		super(256, 1800, 10.0, 27.0);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 256 || getPlayer().isCursedWeaponEquipped())
			return;

		// give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Transfrom Dispel
		getPlayer().addSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(692, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(693, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(694, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(695, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(696, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(697, 1), false);

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,692,693,694,695,696,697});
	}

	public void onUntransform()
	{
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Transfrom Dispel
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(692, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(693, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(694, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(695, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(696, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(697, 1), false, false);

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new DivineWizard());
	}
}