package classes.Items.Shields 
{
	import classes.Items.Shield;

	public class TowerShield extends Shield
	{
		
		public function TowerShield() 
		{
			super("TowerSh", "TowerShld", "tower shield", "a tower shield", 16, 500, "A towering metal shield.  It looks heavy! \nReq 40 strength to fully use it potential.");
		}

		override public function get defense():int {
			return game.player.str >= 40 ? 16 : 4;
		}
	}
}