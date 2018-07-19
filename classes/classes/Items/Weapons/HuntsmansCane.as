package classes.Items.Weapons 
{
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Items.WeaponBuilder;

	public class HuntsmansCane extends Weapon
	{

		public function HuntsmansCane() {
			super(new WeaponBuilder("H. Cane", Weapon.TYPE_BLUNT, "huntsman's cane")
					.withShortName("H. Cane").withLongName("a cane that once belonged to Erlking")
					.withVerb("thwack")
					.withAttack(0).withValue(400)
					.withDescription("This ebony black cane is made of polished wood and topped with a golden cap in the shape of a deer's head. This lightweight staff once belonged to the Erlking, but seems too light and delicate to be an effective weapon."));
		}
		
		override public function useText(host:Creature):String {
			return "You equip the lightweight cane, wondering about the effectiveness of such a small stick. With the cane in your hand, though, you feel intensely focused, and you doubt anything could distract you from your goals. ";
		}
	}
}