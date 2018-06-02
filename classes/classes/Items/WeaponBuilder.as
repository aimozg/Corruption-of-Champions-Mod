package classes.Items {
	import classes.PerkClass;
	import classes.PerkType;
	import classes.Scenes.Combat.CombatDamage;
import classes.internals.Utils;
import classes.lists.DamageType;

	public class WeaponBuilder {
		//itemType
		internal var id:String;
		internal var shortName:String = null;
		internal var longName:String = null;
		internal var value:int = 0;
		internal var description:String = null;

		//WeaponType
		internal var verb:String;
		internal var attack:int = 0;
		internal var perk:String;
		internal var name:String;

		//Updated WeaponType
		internal var procs:Array = [];
		internal var modifiers:Array = [];
		internal var weaponPerks:Vector.<PerkClass> = new Vector.<PerkClass>();
		internal var weaponType:String;
		internal var damage:Array = [];
		internal var buffs:Object = {};

		public function WeaponBuilder(id:String, type:String, name:String = null, perk:String = null) {
			this.id = id;
			this.name = name ? name : id;
			this.weaponType = type;
			this.perk = perk;
		}

		public function build():Weapon {
			return Weapon.fromBuilder(this);
		}

		public function withName(value:String):WeaponBuilder {
			this.name = value;
			return this;
		}

		public function withShort(value:String):WeaponBuilder {
			this.shortName = value;
			return this;
		}

		public function withLongName(value:String):WeaponBuilder {
			this.longName = value;
			return this;
		}

		public function withValue(value:int):WeaponBuilder {
			this.value = value;
			return this;
		}

		public function withDescription(value:String):WeaponBuilder {
			this.description = value;
			return this;
		}

		public function withModifiers(...values):WeaponBuilder {
			modifiers.concat(values);
			return this;
		}

		public function withPerk(ptype:PerkType, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0):WeaponBuilder {
			weaponPerks.push(new PerkClass(ptype, v1, v2, v3, v4));
			return this;
		}

		public function withVerb(value:String):WeaponBuilder {
			this.verb = value;
			return this;
		}
		
		/**
		 * @param buffs object{ [statname:string] => number or eval string }
		 */
		public function withBuffs(buffs:Object):WeaponBuilder {
			this.buffs = Utils.extend(this.buffs,buffs);
			return this;
		}
		
		/**
		 * @param amount number or eval string
		 */
		public function withBuff(statname:String, amount:*):WeaponBuilder {
			this.buffs[statname] = amount;
			return this;
		}

		/**
		 * Adds a flat attack value as physical damage
		 * @param value
		 * @return
		 */
		public function withAttack(value:int, dtype:DamageType = null):WeaponBuilder {
			if(!dtype){dtype = DamageType.PHYSICAL;}
			this.damage.push(new CombatDamage(String(value), dtype));
			return this;
		}

		/**
		 * Adds attack value in the form of a dice roll
		 * @param value dice role in the form of 1d4+10
		 */
		public function withAttackRoll(value:String, dtype:DamageType = null):WeaponBuilder {
			if(!dtype){dtype = DamageType.PHYSICAL;}
			this.damage.push(new CombatDamage(value, dtype));
			return this;
		}
	}
}
