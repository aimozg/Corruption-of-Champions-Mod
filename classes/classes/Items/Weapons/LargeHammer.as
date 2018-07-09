/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class LargeHammer extends Weapon {

		public function LargeHammer() {
			super(new WeaponBuilder("L.Hammr", Weapon.TYPE_BLUNT, "large hammer", "Large")
					.withShortName("L.Hammr").withLongName("Marble's large hammer")
					.withVerb("smash")
					.withAttack(18).withValue(720)
					.withDescription("This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 70) boost += 9;
			return (9 + boost); 
		}
	}
}
