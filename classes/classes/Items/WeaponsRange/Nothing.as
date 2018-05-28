/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange  
{
	import classes.Items.Weapon;
	import classes.Items.WeaponRange;

	public class Nothing extends WeaponRange
	{
		public function Nothing()
		{
			super("norange", "norange", "nothing", "no range weapon \nAttack: 0", "nothing", 0);
		}
		
		override public function playerRemove():Weapon {
			return null; //There is nothing!
		}
	}
}