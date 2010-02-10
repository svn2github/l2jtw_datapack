package transformations;

import com.l2jserver.gameserver.datatables.SkillTable;
import com.l2jserver.gameserver.instancemanager.TransformationManager;
import com.l2jserver.gameserver.model.L2Transformation;

public class TawnyManedLion extends L2Transformation
{
	private static final int[] SKILLS = {5491,839,5437};//Update by rocknow
	public TawnyManedLion()
	{
		// id, colRadius, colHeight
		super(109, 25, 22.5);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 109 || getPlayer().isCursedWeaponEquipped())
			return;

		transformedSkills();
	}

	public void transformedSkills()
	{
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		// Dismount
		getPlayer().addSkill(SkillTable.getInstance().getInfo(839, 1), false);
		getPlayer().addSkill(SkillTable.getInstance().getInfo(5437, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(SKILLS);
	}

	public void onUntransform()
	{
		removeSkills();
	}

	public void removeSkills()
	{
		// Decrease Bow/Crossbow Attack Speed
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5491, 1), false);
		// Dismount
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(839, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(5437, 1), false);//Update by rocknow

		getPlayer().setTransformAllowedSkills(EMPTY_ARRAY);
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new TawnyManedLion());
	}
}
