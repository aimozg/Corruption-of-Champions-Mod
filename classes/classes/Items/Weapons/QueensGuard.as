package classes.Items.Weapons 
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class QueensGuard extends Weapon
	{

		public function QueensGuard() {
			super(new WeaponBuilder("Q.Guard", Weapon.TYPE_SWORD, "queen's guard rapier")
					.withShortName("Q. Guard").withLongName("a queen's guard rapier")
					.withVerb("slash")
					.withAttack(20).withValue(2400)
					.withDescription(" An elegant rapier made in brass and gold, with the seal of Mareth’s former nobility. The ruby gemstones running among the blade and the intricate engravings in gold identify it as belonging to the old kingdom knighthoods orders."));
		}
		override public function get attack():int{
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			boost += ((100 - game.player.femininity) / 20) + ((100 - game.player.cor) / 20) / 2;
			return (20 + boost); 
		}
		
	}

}