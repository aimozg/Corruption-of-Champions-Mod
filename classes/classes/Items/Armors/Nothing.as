package classes.Items.Armors 
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Items.Equipable;

	public final class Nothing extends Armor {
		
		public function Nothing() {
			super("nothing", "nothing", "nothing", "nothing", 0, 0, "nothing", "Light");
		}
		
		override public function unequip(host:Creature):Equipable {
			return null; //Player never picks up their underclothes
		}
	}

}