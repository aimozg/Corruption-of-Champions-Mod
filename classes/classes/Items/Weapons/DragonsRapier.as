/**
 * ...
 * @author Ormael
 * */
package classes.Items.Weapons
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class DragonsRapier extends Weapon {

		public function DragonsRapier() {
			super(new WeaponBuilder("DRapier", Weapon.TYPE_SWORD, "dragon rapier", " ")
					.withShortName("DRapier").withLongName("Dragon's Rapier")
					.withVerb("slash")
					.withAttack(18).withValue(1440)
					.withDescription("Ancient looking rapier forged in dragon fire. Tales saying that some of the dragon fire could still linger inside of it.  Still blade is piece of an extraordinatry quality and perfect for stabbing."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (18 + boost); 
		}
	}
}