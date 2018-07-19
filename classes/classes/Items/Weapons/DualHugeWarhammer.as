/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class DualHugeWarhammer extends Weapon {

		public function DualHugeWarhammer() {
			super(new WeaponBuilder("D.WHam", Weapon.TYPE_BLUNT, "dual huge warhammer", "Dual Large")
					.withShortName("D.WarHam").withLongName("a dual huge warhammer")
					.withVerb("smash")
					.withAttack(15).withValue(2400)
					.withDescription("A pair of huge war-hammers made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 80) boost += 8;
			return (7 + boost); 
		}
	}
}