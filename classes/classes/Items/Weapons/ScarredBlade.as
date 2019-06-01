package classes.Items.Weapons 
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;
	import classes.Scenes.SceneLib;

	public class ScarredBlade extends Weapon
	{

		public function ScarredBlade() {
			super(new WeaponBuilder("ScarBld", Weapon.TYPE_SWORD, "scarred blade", " ")
					.withShortName("ScarBlade").withLongName("a scarred blade")
					.withVerb("slash")
					.withAttack(10).withValue(800)
					.withDescription("This saber, made from lethicite-imbued metal, eagerly seeks flesh; it resonates with disdain and delivers deep, jagged wounds as it tries to bury itself in the bodies of others. It only cooperates with the corrupt."));
		}
		
		override public function get attack():int {
			var temp:int = 10 + int((game.player.cor - 70) / 3);
			if (temp < 10) temp = 10;
			return temp; 
		}
		
		override public function canUse(host:Creature):String {
			if (game.player.cor < (66 - game.player.corruptionTolerance())) {
				SceneLib.sheilaScene.rebellingScarredBlade(true);
				return "<Remind Ox to fix this if you see it>";
			}
			return super.canUse(host);
		}
	}
}