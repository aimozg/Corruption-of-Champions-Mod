package classes.StatusEffects.Combat {
import classes.StatusEffectType;

public class AnemoneVenomDebuff extends CombatBuff {
	public static const TYPE:StatusEffectType = register("Anemone Venom",AnemoneVenomDebuff);
	public function AnemoneVenomDebuff() {
		super(TYPE,'str','spe');
	}

	public function applyEffect(amt:Number):void {
		var lustdmg:Number = 2*amt;
		buffHost('str', -amt);
		buffHost('spe',-amt);
		//Str bottommed out, convert to lust
		//Spe bottommed out, convert to lust
		if (host.str <= host.strMin) lustdmg += amt;
		if (host.spe <= host.speMin) lustdmg += amt;
		host.takeLustDamage(lustdmg, true);
	}
}

}
