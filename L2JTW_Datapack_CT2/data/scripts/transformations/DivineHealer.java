package transformations;

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.model.L2Transformation;

/**
 * Description: <br>
 * This will handle the transformation, giving the skills, and removing them, when the player logs out and is transformed these skills
 * do not save. 
 * 
 * @author Ahmed
 *
 */
public class DivineHealer extends L2Transformation
{
	public DivineHealer()
	{
		// id, colRadius, colHeight
		super(255, 8.0, 27.0);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 255 || getPlayer().isCursedWeaponEquipped())
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
		getPlayer().addSkill(SkillTable.getInstance().getInfo(698, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(699, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(700, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(701, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(702, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(703, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,698,699,700,701,702,703});//Update by rocknow
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
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(698, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(699, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(700, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(701, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(702, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(703, 1), false, false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new DivineHealer());
	}
}