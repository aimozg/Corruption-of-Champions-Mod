/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class GuanDao extends Weapon {

		public function GuanDao() {
			super(new WeaponBuilder("GuanDao", Weapon.TYPE_POLEARM, "Guan Dao", "Large")
					.withShortName("GuanDao").withLongName("a Guan Dao")
					.withVerb("slash")
					.withAttack(25).withValue(1000)
					.withDescription("Made of a 5 foot long wooden pole, attached on top is an imposing sword blade measuring about 16 inches long, gleaming with a sharp light. You figure this weapon should be effective versus groups of foes.  Req. 100 strength to unleash full attack power."));
		}
		
		override public function get attack():int {
			var base:int = 0;
			if (game.player.str >= 100) base += 11;
			if (game.player.str >= 50) base += 8;
			return (6 + base);
		}
	}
}