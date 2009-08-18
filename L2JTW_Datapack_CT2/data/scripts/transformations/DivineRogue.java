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
public class DivineRogue extends L2Transformation
{
	public DivineRogue()
	{
		// id, colRadius, colHeight
		super(254, 13.0, 27.5);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 254 || getPlayer().isCursedWeaponEquipped())
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
		getPlayer().addSkill(SkillTable.getInstance().getInfo(686, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(687, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(688, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(689, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(690, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(691, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(797, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,686,687,688,689,690,691,797});//Update by rocknow
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
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(686, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(687, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(688, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(689, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(690, 1), false, false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(691, 1), false, false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(797, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new DivineRogue());
	}
}