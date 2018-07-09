/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class OniTetsubo extends Weapon
	{
		public function OniTetsubo() {
			super(new WeaponBuilder("O.Tetsu", Weapon.TYPE_BLUNT, "Oni Tetsubo", "Large")
					.withShortName("OniTetsubo").withLongName("an Oni Tetsubo")
					.withVerb("smash")
					.withAttack(45).withValue(3600)
					.withDescription("This unrealistically large two handed mace was clearly made for Oni warriors to wield. You likely will need some ridiculous strength just to lift it."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 180) boost += 15;
			if (game.player.str >= 120) boost += 15;
			if (game.player.str >= 60) boost += 10;
			return (5 + boost); 
		}
	}
}