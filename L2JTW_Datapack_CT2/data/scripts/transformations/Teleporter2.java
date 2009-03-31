package transformations;

import net.sf.l2j.gameserver.datatables.SkillTable;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.model.L2Transformation;

public class Teleporter2 extends L2Transformation
{
	public Teleporter2()
	{
		// id, duration (secs), colRadius, colHeight
		super(107, 1800, 11.0, 25.0);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 107 || getPlayer().isCursedWeaponEquipped())
			return;

		// give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Transfrom Dispel
		getPlayer().addSkill(SkillTable.getInstance().getInfo(8248, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5656, 85), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5657, 85), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5658, 85), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5659, 2), false);

		getPlayer().setTransformAllowedSkills(new int[]{8248,5491,5656,5657,5658,5659});
	}

	public void onUntransform()
	{
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Transfrom Dispel
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(8248, 1), false);
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5656, 85), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5657, 85), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5658, 85), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5659, 2), false, false);

		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new Teleporter2());
	}
}
