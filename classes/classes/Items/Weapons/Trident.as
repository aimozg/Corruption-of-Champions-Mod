/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Trident extends Weapon
	{

		public function Trident() {
			super(new WeaponBuilder("Trident", Weapon.TYPE_POLEARM, "deadly trident", " ")
					.withShortName("Trident").withLongName("a deadly trident")
					.withVerb("piercing stab")
					.withAttack(12).withValue(480)
					.withDescription("A very ordinary trident. This weapon has a decent reach and can be used to impale foes. It is capable of piercing armor just as well as any other spear.  Req. 75+ speed to unleash full attack power."));
		}
		
		override public function get attack():int {
			var base:int = 0;
			if (game.player.spe >= 100) base += 3;
			if (game.player.spe >= 50) base += 3;
			return (6 + base);
		}
	}
}