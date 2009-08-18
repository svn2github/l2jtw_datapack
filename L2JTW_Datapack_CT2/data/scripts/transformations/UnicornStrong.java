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
public class UnicornStrong extends L2Transformation
{
	public UnicornStrong()
	{
		// id, colRadius, colHeight
		super(204, 8.0, 25.5);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 204 || getPlayer().isCursedWeaponEquipped())
			return;

		// give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Horn of Doom
		getPlayer().addSkill(SkillTable.getInstance().getInfo(563, 4), false);
		// Gravity Control
		getPlayer().addSkill(SkillTable.getInstance().getInfo(564, 4), false);
		// Horn Assault
		getPlayer().addSkill(SkillTable.getInstance().getInfo(565, 4), false);
		// Light of Heal
		getPlayer().addSkill(SkillTable.getInstance().getInfo(567, 4), false);
		// Transfrom Dispel
		getPlayer().addSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5491, 1), false);

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,563,564,565,567});
	}

	public void onUntransform()
	{
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Horn of Doom
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(563, 4), false);
		// Gravity Control
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(564, 4), false);
		// Horn Assault
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(565, 4), false);
		// Light of Heal
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(567, 4), false);
		// Transfrom Dispel
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(619, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5491, 1), false);

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new UnicornStrong());
	}
}
