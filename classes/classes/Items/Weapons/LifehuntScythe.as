package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;

	public class LifehuntScythe extends Weapon
	{
		
		public function LifehuntScythe() 
		{
			super("LifScyt", "L.Scythe", "lifehunt scythe", "a lifehunt scythe", "slash", 25, 2000,
					"This enchanted scythe is made of a white metal, and its surface is decorated with ruby gemstones and silver engravings depicting dragons. It seems to drink in the opponents blood use it to heal its user’s wounds.",
					"Large", PerkLib.Sanctuary, 1, 0, 0, 0
			);
		}
		override public function get attack():int{
			return 20 + ((100 - game.player.cor) / 20);
		}
		
	}

}