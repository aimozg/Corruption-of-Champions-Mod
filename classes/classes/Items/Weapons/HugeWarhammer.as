/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class HugeWarhammer extends Weapon {
		
		public function HugeWarhammer() {
			super(new WeaponBuilder("Warhamr", Weapon.TYPE_BLUNT, "huge warhammer", "Large")
					.withShortName("Warhammer").withLongName("a huge warhammer")
					.withVerb("smash")
					.withAttack(15).withValue(1200)
					.withDescription("A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Getting hit with this might stun the victim."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 80) boost += 8;
			return (7 + boost); 
		}	
	}
}
