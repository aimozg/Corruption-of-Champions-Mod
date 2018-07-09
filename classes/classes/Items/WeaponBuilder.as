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
		internal var defense:int = 0;
		internal var sexiness:int = 0;
		internal var perk:String;
		internal var name:String;

		//Updated WeaponType
		internal var modifiers:Array = [];
		internal var weaponPerks:Vector.<PerkClass> = new Vector.<PerkClass>();
		internal var weaponType:String;
		internal var buffs:Object = {};

		//Ranged Weapon
		internal var ammo:int = 0;
		internal var ammoWord:String;

		public function WeaponBuilder(id:String, type:String, name:String = null, perk:String = null) {
			this.id = id;
			this.name = name ? name : id;
			this.weaponType = type;
			this.perk = perk;
		}

		public function withShortName(value:String):WeaponBuilder {
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

		public function withAttack(value:int):WeaponBuilder {
			attack = value;
			return this;
		}

		/**
		 * Used for ranged weapons
		 * @param count how many times the weapon may be fired before needing to reload
		 * @param word (arrow, bullet, bolt, etc)
		 */
		public function withAmmo(count:int, word:String = "bullet"):WeaponBuilder {
			ammo = count;
			ammoWord = word;
			return this;
		}
	}
}
