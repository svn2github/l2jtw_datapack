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
public class DivineKnight extends L2Transformation
{
	public DivineKnight()
	{
		// id, colRadius, colHeight
		super(252, 33.0, 30.0);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 252 || getPlayer().isCursedWeaponEquipped())
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
		getPlayer().addSkill(SkillTable.getInstance().getInfo(680, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(681, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(682, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(683, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(684, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(685, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(795, 1), false);//Update by rocknow
		getPlayer().addSkill(SkillTable.getInstance().getInfo(796, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{619,5491,680,681,682,683,684,685,795,796});//Update by rocknow
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
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(680, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(681, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(682, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(683, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(684, 1), false, false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(685, 1), false, false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(795, 1), false);//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(796, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new DivineKnight());
	}
}