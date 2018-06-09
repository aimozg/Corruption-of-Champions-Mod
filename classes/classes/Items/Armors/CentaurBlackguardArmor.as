package classes.Items.Armors 
{
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Scenes.NPCs.CelessScene;

	/**
	 * ...
	 * @author 
	 */
	public class CentaurBlackguardArmor extends Armor
	{
		
		public function CentaurBlackguardArmor() 
		{
			super("TaurBAr","Taur B. Armor","some taur blackguard armor","a set of taur blackguard armor",23,1698,"A suit of blackguard's armor for centaurs.","Heavy")
		}
		override public function canUse(host:Creature):Boolean{
			if (game.player.isTaur()){return true}
			outputText("The blackguard's armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory");
			return false;
		}
		
		override public function useText(host:Creature):String {
			return CelessScene.instance.Name+" helps you put on the barding and horseshoes. Wow, taking a look at yourself, you think your intimidating appearance alone will scare the hell out of most opponents."
		}
		
		override public function removeText(host:Creature):String {
			return CelessScene.instance.Name+ "help you remove the centaur armor. Whoa you forgot what carrying light weight was."
			+ super.removeText(host);
		}
		
		override public function get defense():int{
			var mod:int = game.player.cor/10;
			return 13 + mod;
		}
	}

}