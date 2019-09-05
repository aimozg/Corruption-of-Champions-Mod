/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters {

import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Monster;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.*;

public class DarkElfScout extends Monster {
	public var darkelf:DarkElfScene = new DarkElfScene();

	override public function defeated(hpVictory:Boolean):void {
		darkelf.wonWithDarkElf();
	}

	override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
		darkelf.lostToDarkElf();
	}

	public function DarkElfBowShooting():void {
		var Acc:Number = Math.max(0, this.spe - player.spe);
		outputText("The black skinned elf aims her bow at you, drawing several arrows and starts shooting.\n\n");
		PoisonedBowShoot();
		if (randomChance(70 + Acc)) PoisonedBowShoot();
		else outputText("An arrow missed you.\n\n");
		if (randomChance(30 + Acc)) PoisonedBowShoot();
		else outputText("An arrow missed you.\n\n");
	}

	public function PoisonedBowShoot():void {
		if (player.hasStatusEffect(StatusEffects.WindWall)) {
			outputText("An arrow hits wind wall dealing no damage to you.\n\n");
			player.addStatusValue(StatusEffects.WindWall, 2, -1);
			return;
		}
		var damage:Number = Math.max(10, eBaseSpeedDamage() * 0.1);
		damage *= (1 + (this.weaponRangeAttack * 0.02));
		damage = Math.round(damage);
		outputText("An arrow hits you for ");
		player.takePhysDamage(damage, true);
		outputText(" damage. It was poisoned! You feel your strength failing you!\n\n");
		player.addCombatBuff('spe', -3);
	}

	public function AnkleShot():void {
		outputText("The dark skinned elf shoot you through the ankle and takes some distance. Crippled like you are, it will be annoying to catch her--if not impossible. Better use ranged attacks until you recover mobility.");
		player.createStatusEffect(StatusEffects.Sealed2, 4, 0, 0, 0);
	}

	public function WingClip():void {
		if (player.hasStatusEffect(StatusEffects.WindWall)) {
			outputText("An arrow hits wind wall dealing no damage to you.\n\n");
			player.addStatusValue(StatusEffects.WindWall, 2, -1);
		} else {
			outputText("The dark elf smirks wickedly before shooting an arrow straight into your wing. You fall, unable to fly, and crash into the ground. ");
			player.removeStatusEffect(StatusEffects.Flying);
			var damage:Number = 0;
			damage += this.str * 1.5;
			damage += eBaseSpeedDamage() * 1.5;
			if (damage < 10) damage = 10;
			damage *= Math.min(2, 1 + (this.weaponRangeAttack * 0.03));
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			outputText("\n\n");
		}
	}

	override protected function performCombatAction():void {
		switch (rand(3)) {
			case 0:
				DarkElfBowShooting();
				break;
			case 1:
				if (!player.hasStatusEffect(StatusEffects.Sealed2)) {
					AnkleShot();
				} else {
					DarkElfBowShooting();
				}
				break;
			case 2:
			default:
				if (player.isFlying() && randomChance(25)) {
					WingClip();
				} else {
					DarkElfBowShooting();
				}
				break;
		}
	}

	public function DarkElfScout() {
		this.a         = "the ";
		this.short     = "dark elf scout";
		this.imageName = "dark elf";
		this.long      = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf, though why she’s here on the surface, you have no idea. Regardless, she’s dangerous and seems well equipped for kidnapping.";
		this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
		this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
		createBreastRow(Appearance.breastCupInverse("DD"));
		this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
		this.ass.analWetness   = AssClass.WETNESS_SLIME_DROOLING;
		this.tallness          = 72;
		this.hips.type         = Hips.RATING_CURVY;
		this.butt.type         = Butt.RATING_LARGE + 1;
		this.lowerBody         = LowerBody.ELF;
		this.skinTone          = "dark";
		this.hairColor         = "silver";
		this.hairLength        = 13;
		initStrTouSpeInte(30, 30, 90, 40);
		initWisLibSensCor(40, 50, 60, 80);
		this.weaponName        = "dagger";
		this.weaponVerb        = "stab";
		this.weaponAttack      = 5;
		this.weaponRangeName   = "elven bow";
		this.weaponRangeVerb   = "shoot";
		this.weaponRangeAttack = 18;
		this.armorName         = "elven armor";
		this.armorDef          = 4;
		this.bonusLust         = 20;
		this.lustVuln          = .7;
		this.lust              = 50;
		this.temperment        = TEMPERMENT_RANDOM_GRAPPLES;
		this.level             = 15;
		this.gems              = rand(10) + 10;
		this.drop              = new WeightedDrop().add(weaponsrange.BOWLIGH, 1).add(consumables.ELFEARS, 4);
		checkMonster();
	}
}
}