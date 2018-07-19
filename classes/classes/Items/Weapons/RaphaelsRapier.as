/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class RaphaelsRapier extends Weapon {
		
		public function RaphaelsRapier() {
			super(new WeaponBuilder("RRapier", Weapon.TYPE_SWORD, "vulpine rapier")
					.withShortName("RRapier").withLongName("Raphael's vulpine rapier")
					.withVerb("slash")
					.withAttack(8).withValue(640)
					.withDescription("He's bound it with his red sash around the length like a ribbon, as though he has now gifted it to you.  Perhaps it is his way of congratulating you."));
		}
		
		override public function get attack():int {
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			return (8 + boost); 
		}
	}
}
