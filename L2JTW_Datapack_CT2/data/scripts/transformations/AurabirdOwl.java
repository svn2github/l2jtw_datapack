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
 * @author Kerberos
 *
 */
public class AurabirdOwl extends L2Transformation
{
	public AurabirdOwl()
	{
		// id, duration (secs), colRadius, colHeight
		super(9, -1, 40.0, 19.0);
	}

	public void onTransform()
	{
		if (getPlayer().getTransformationId() != 9 || getPlayer().isCursedWeaponEquipped())
			return;
		getPlayer().setIsFlyingMounted(true);
		// 	give transformation skills
		transformedSkills();
	}

	public void transformedSkills()
	{
		// Transfrom Dispel
		getPlayer().addSkill(SkillTable.getInstance().getInfo(619, 1), false);
		//Update by rocknow
		if (getPlayer().getLevel() >= 75)
			getPlayer().addSkill(SkillTable.getInstance().getInfo(932, 1), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(885, 1), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(895, 1), false);

		int lvl = getPlayer().getLevel() -74;
		if (lvl > 0)
		{
			getPlayer().addSkill(SkillTable.getInstance().getInfo(884, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(885, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(887, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(889, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(892, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(893, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(911, lvl), false);
			getPlayer().addSkill(SkillTable.getInstance().getInfo(932, lvl), false);
		}
		getPlayer().setTransformAllowedSkills(new int[]{619,884,885,887,889,892,893,895,911,932});
	}

	public void onUntransform()
	{
		getPlayer().setIsFlyingMounted(false);
		// remove transformation skills
		removeSkills();
	}

	public void removeSkills()
	{
		// Transfrom Dispel
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(619, 1), false);
		//Update by rocknow
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(932, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(885, 1), false);
		getPlayer().removeSkill(SkillTable.getInstance().getInfo(895, 1), false);

		int lvl = getPlayer().getLevel() -74;
		if (lvl > 0)
		{
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(884, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(885, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(887, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(889, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(892, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(893, lvl), false);
			getPlayer().removeSkill(SkillTable.getInstance().getInfo(911, lvl), false);
		}
		getPlayer().setTransformAllowedSkills(new int[]{});
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new AurabirdOwl());
	}
}