/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class PurifiedOniChieftainDestroyer extends Weapon
	{
		
		public function PurifiedOniChieftainDestroyer() {
			super(new WeaponBuilder("POCDest", Weapon.TYPE_BLUNT, "Purified Oni Chieftain Destroyer", "Large")
					.withShortName("POCDestroyer").withLongName("a Purified Oni Chieftain Destroyer")
					.withVerb("smash")
					.withAttack(60).withValue(4800)
					.withDescription("This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 210) boost += 10;
			if (game.player.str >= 140) boost += 10;
			if (game.player.str >= 70) boost += 10;
			boost += (100 - game.player.cor) / 5;
			return (10 + boost); 
		}
	}
}