/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class JeweledRapier extends Weapon {

		public function JeweledRapier() {
			super(new WeaponBuilder("JRapier", Weapon.TYPE_SWORD, "jeweled rapier", " ")
					.withShortName("JRapier").withLongName("a jeweled rapier")
					.withVerb("slash")
					.withAttack(13).withValue(1040)
					.withDescription("This jeweled rapier is ancient but untarnished.  The hilt is wonderfully made, and fits your hand like a tailored glove.  The blade is shiny and perfectly designed for stabbing."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (13 + boost); 
		}
	}
}
