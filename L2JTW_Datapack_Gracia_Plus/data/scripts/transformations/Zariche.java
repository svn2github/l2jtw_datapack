package transformations;

import com.l2jserver.gameserver.model.L2Transformation;
import com.l2jserver.gameserver.instancemanager.TransformationManager;
import com.l2jserver.gameserver.datatables.MessageTable;//Update by rocknow

public class Zariche extends L2Transformation
{
	public Zariche()
	{
		// TODO: Unhardcode Akamanah and Zariche transformations as much as we can
		// id, colRadius, colHeight
		super(301, 12, 31.58);
	}

	public void onTransform()
	{
		// Set charachter name to transformed name
		getPlayer().getAppearance().setVisibleName(MessageTable.Messages[589].getMessage());//Update by rocknow
		getPlayer().getAppearance().setVisibleTitle("");
	}

	public void onUntransform()
	{
	// set character back to true name.
		getPlayer().getAppearance().setVisibleName(null);
		getPlayer().getAppearance().setVisibleTitle(null);
	}

	public static void main(String[] args)
	{
		TransformationManager.getInstance().registerTransformation(new Zariche());
	}
}
