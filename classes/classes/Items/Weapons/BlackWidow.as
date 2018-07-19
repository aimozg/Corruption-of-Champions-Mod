package classes.Items.Weapons {
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class BlackWidow extends Weapon {

		public function BlackWidow() {
			super(new WeaponBuilder("BWidow", Weapon.TYPE_SWORD, "black widow rapier")
					.withShortName("B. Widow").withLongName("a black widow rapier")
					.withVerb("slash")
					.withAttack(20).withValue(2400)
					.withDescription("A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) {
				boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			} else {
				boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			}
			boost += ((game.player.femininity) / 20) + ((game.player.cor) / 20) / 2;
			return (20 + boost);
		}

	}

}