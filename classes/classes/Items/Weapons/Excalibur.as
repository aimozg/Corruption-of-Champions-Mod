/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Excalibur extends Weapon
	{

		public function Excalibur() {
			super(new WeaponBuilder("Excalib", Weapon.TYPE_SWORD, "Excalibur", "Excalibur")
					.withShortName("Excalibur").withLongName("an Excalibur")
					.withVerb("slash")
					.withAttack(10).withValue(800)
					.withDescription("A legendary sword said to have been made by Marae for her champion. This weapon radiates divine power, purifying its wielder and protecting them from impurity."));
		}
		
		override public function get attack():int {
			var temp:int = 10 + int((30 - game.player.cor) / 3);
			if (temp < 10) temp = 10;
			return temp; 
		}
		
		override public function canUse(host:Creature):Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance())) return true;
			outputText("You grab hold of the handle of the sword only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the sword must be displeased.  ");
			return false;
		}
	}
}