/*
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Logger;

import javolution.util.FastList;
import javolution.util.FastMap;


public class ExternalConfig
{
	protected static final Logger _log = Logger.getLogger(Config.class.getName());
	
	/** Extneral Config Path **/
	
    /** Properties file for Character Configurations */
    public static final String  GRANDBOSS_CONFIG_FILE							= "./config/Grandboss.properties";
    
    
    /** Extneral Config Settings **/
    
    public static int load = 0;
    
    /** GrandBoss Settings **/

    public static int Antharas_Wait_Time = 600000;
    public static int Valakas_Wait_Time = 600000;
    
    public void loadconfig()
    {
    	InputStream is = null;
    	if (load == 1)
    		return;
    	
    	 try 
    	 {
             Properties grandbossSettings    = new Properties();
             is                           = new FileInputStream(new File(GRANDBOSS_CONFIG_FILE));
             grandbossSettings.load(is);
             
             Antharas_Wait_Time     = Integer.parseInt(grandbossSettings.getProperty("AntharasWaitTime","600000"));
             Valakas_Wait_Time     = Integer.parseInt(grandbossSettings.getProperty("ValakasWaitTime","600000"));
             

         }
         catch (Exception e)
         {
             e.printStackTrace();
             throw new Error("Failed to Load "+GRANDBOSS_CONFIG_FILE+" File.");
         }
         
         
         load = 1;
    
    }
}