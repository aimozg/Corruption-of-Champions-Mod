package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class Spear extends Weapon {

		public function Spear() {
			super(new WeaponBuilder("Spear", Weapon.TYPE_POLEARM, "deadly spear", " ")
					.withShortName("Spear").withLongName("a deadly spear")
					.withVerb("piercing stab")
					.withAttack(10).withValue(400)
					.withDescription("A staff with a sharp blade at the tip designed to pierce through the toughest armor.  This would ignore most armors.  Req. 75+ speed to unleash full attack power."));
		}
		
		override public function get attack():int {
			var base:int = 0;
			base += 7;
			if (game.player.spe >= 75) base += 3;
			return (base);
		}
	}
}