/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class DefiledOniChieftainDestroyer extends Weapon
	{

		public function DefiledOniChieftainDestroyer() {
			super(new WeaponBuilder("DOCDest", Weapon.TYPE_BLUNT, "Defiled Oni Chieftain Destroyer", "Large")
					.withShortName("DOCDestroyer").withLongName("a Defiled Oni Chieftain Destroyer")
					.withVerb("smash")
					.withAttack(60).withValue(4800)
					.withDescription("This unrealistically large two handed mace was clearly made for some legendary oni chieftain to wield. Even bigger than the standard oni tetsubo this thing could topple buildings. You likely will need some absurd strength just to lift it."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (game.player.str >= 210) boost += 10;
			if (game.player.str >= 140) boost += 10;
			if (game.player.str >= 70) boost += 10;
			boost += (game.player.cor) / 5;
			return (10 + boost); 
		}
	}
}