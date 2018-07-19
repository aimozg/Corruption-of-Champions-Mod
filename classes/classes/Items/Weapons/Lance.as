/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Lance extends Weapon
	{

		public function Lance() {
			super(new WeaponBuilder("Lance", Weapon.TYPE_POLEARM, "deadly lance", " ")
					.withShortName("Lance").withLongName("a deadly lance")
					.withVerb("piercing stab")
					.withAttack(12).withValue(480)
					.withDescription("A long wooden shaft with a pointed metal head, used as a weapon by knights and cavalry soldiers in charging.  This would ignore most armors.  Req. 100+ speed to unleash full attack power."));
		}
		
		override public function get attack():int {
			var base:int = 0;
			base += 6;
			if (game.player.spe >= 100) base += 3;
			if (game.player.spe >= 50) base += 3;
			return (base);
		}
	}
}