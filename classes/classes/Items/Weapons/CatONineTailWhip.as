/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.PerkLib;

	public class CatONineTailWhip extends Weapon
	{

		public function CatONineTailWhip() {
			super(new WeaponBuilder("CNTWhip", Weapon.TYPE_WHIP, "Bastet Whip", "Large")
					.withShortName("CatONineTailWhip").withLongName("a Bastet Whip")
					.withVerb("whipping")
					.withAttack(27).withValue(1080)
					.withDescription("A rope made from unknown magic beast fur that unravelled into three small ropes, each of which is unravelled again designed to whip and cut your foes into submission."));
		}

		override public function get attack():int {
			var boost:int = 0;
			if ((game.player.str + game.player.spe) >= 270) {
				boost += 18;
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 27;
			}
			if ((game.player.str + game.player.spe) >= 180) {
				boost += 12;
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 21;
			}
			if ((game.player.str + game.player.spe) >= 90) {
				boost += 6;
				if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 15;
			}
            if (((game.player.str + game.player.spe) < 90) && game.player.hasPerk(PerkLib.ArcaneLash)) boost += 9;
			return (9 + boost);
        }

		override public function canUse(host:Creature):String {
			if (!host.hasPerk(PerkLib.TitanGrip)) {
				return "You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ";
			}
			return super.canUse(host);
		}
	}
}