/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange  
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.WeaponRange;

	public class Nothing extends WeaponRange
	{
		public function Nothing()
		{
			super("norange", "norange", "nothing", "no range weapon \nAttack: 0", "nothing", 0);
		}
		
		override public function unequip(host:Creature):Equipable {
			return null; //There is nothing!
		}
	}
}