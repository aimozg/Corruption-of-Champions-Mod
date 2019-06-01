package classes.Items {
	import classes.Creature;

	public interface Useable {
		function canUse(host:Creature):String;
		function useItem(host:Creature):Boolean;
		function useText(host:Creature):String;
	}
}
