package classes.Items.Undergarments 
{
	import classes.Creature;
	import classes.Items.Equipable;
	import classes.Items.Undergarment;

	public class Nothing extends Undergarment
	{
		public function Nothing() {
			super("nounder", "nounder", "nothing", "nothing", -1, 0, 0, 0, "nothing", "light");
		}
		
		override public function unequip(host:Creature):Equipable {
			return null; //Player never picks up their underclothes
		}
	}
}