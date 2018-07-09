package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class DemonSnakespear extends Weapon
	{

		public function DemonSnakespear() {
			super(new WeaponBuilder("DSSpear", Weapon.TYPE_POLEARM, "demon snake spear")
					.withShortName("Demon Sn Spear").withLongName("a demon snake spear")
					.withVerb("piercing stab")
					.withAttack(20).withValue(1600)
					.withDescription("A dark steel spear imbued with corruption. Along the handle is a snake-like decoration with ruby eyes, from the mouth of which the spear tip emerges. The spear head is poisoned with an unknown venom."));
		}
		override public function get attack():int {
			var base:int = 0;
			if (game.player.spe >= 75) base += 3;
			base += game.player.cor / 10;
			return (7 + base);
		}
	}

}