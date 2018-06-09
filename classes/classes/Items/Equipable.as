package classes.Items {
	import classes.Creature;

	public interface Equipable extends Useable {

		/**
		 * The Equipment slot that this item fills
		 */
		function get slot():String;

		/**
		 * Handles the mechanics of equiping an item to a creature
		 * @param host
		 * @return
		 */
		function equip(host:Creature):Equipable;

		/**
		 * Handles the mechanics of removing an item from a creature
		 * @param host Creature the item is being removed from
		 * @return
		 */
		function unequip(host:Creature):Equipable;

		/**
		 * Produces any text that should be displayed when unequiping the item normally
		 * @param host Creature the item is being removed from
		 * @return
		 */
		function removeText(host:Creature):String;
	}
}
