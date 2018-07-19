package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class SeraphicSpear extends Weapon
	{

		public function SeraphicSpear() {
			super(new WeaponBuilder("SeSpear", Weapon.TYPE_SWORD, "seraph spear")
					.withShortName("Seraph Spear").withLongName("a seraph spear")
					.withVerb("piercing stab")
					.withAttack(20).withValue(1600)
					.withDescription("A silvery spear imbued with holy power and decorated with blue sapphire gemstones. Engraved in the handle is an ancient runic spell made to ward evil. This blessed equipment seems to slowly heal its wielder’s wounds."));
		}
		override public function get attack():int {
			var base:int = 0;
			if (game.player.spe >= 75) base += 3;
			base += (100 - game.player.cor) / 10;
			return (7 + base);
		}
		
	}

}