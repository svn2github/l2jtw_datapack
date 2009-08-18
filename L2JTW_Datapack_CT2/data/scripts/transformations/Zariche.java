package transformations;

import net.sf.l2j.gameserver.model.L2Transformation;
import net.sf.l2j.gameserver.instancemanager.TransformationManager;
import net.sf.l2j.gameserver.datatables.MessageTable;//Update by rocknow

/**
 * This is currently only a test of the java script engine
 * 
 * @author KenM
 *
 */
public class Zariche extends L2Transformation
{
    public Zariche()
    {
        // id, colRadius, colHeight
        super(301, 9.0, 31.0);
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
