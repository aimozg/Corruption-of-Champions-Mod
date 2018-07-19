/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange  
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.WeaponBuilder;
	import classes.Items.WeaponRange;

	public class Nothing extends WeaponRange
	{
		public function Nothing()
		{
			super(new WeaponBuilder("norange", "nothing"))
		}
		
		override public function unequip(host:Creature):Equipable {
			return null;
		}
	}
}