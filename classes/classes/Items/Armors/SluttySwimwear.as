/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors {
	import classes.Creature;
	import classes.Items.Armor;
	import classes.PerkLib;

	public class SluttySwimwear extends Armor {

		public function SluttySwimwear() {
			super("S.Swmwr", "S.Swmwr", "slutty swimwear", "a skimpy black bikini", 0, 40, "An impossibly skimpy black bikini. You feel dirty just looking at it... and a little aroused, actually.", "Light", false, PerkLib.SluttySeduction, 6, 0, 0, 0, "");
		}

		override public function useText(host:Creature):String { //Produces any text seen when equipping the armor normally
			host.dynStats("lus", 5);
			var text:String = "";
			if (host.biggestTitSize() < 1) {
				text += "You feel rather stupid putting the top part on like this, but you're willing to bear with it. It could certainly be good for distracting.  "
			} else {
				text += "The bikini top clings tightly to your bustline, sending a shiver of pleasure through your body. It serves to turn you on quite nicely.  ";
				host.dynStats("lus", 5);
			}
			if (host.cockTotal() == 0) {
				text += "The thong moves over your smooth groin, clinging onto your buttocks nicely.  ";
				if (host.balls > 0) {
					if (host.ballSize > 5) {
						text += "You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + host.ballsDescriptLight() + " hang on the sides, exposed.  Maybe if you shrunk your male parts down a little..."
					} else {
						text += "However, your testicles do serve as an area of discomfort, stretching the material and bulging out the sides slightly.  "
					}
				}
			}
			else {
				if (host.cockTotal() == 1) {
					text += "You grunt in discomfort, your " + host.cockDescript(0) + " flopping free from the thong's confines. The tight material rubbing against your dick does manage to turn you on slightly.  "
				}
				else {
					text += "You grunt in discomfort, your " + host.multiCockDescriptLight() + " flopping free from the thong's confines. The tight material rubbing against your dicks does manage to turn you on slightly.  "
				}
				host.dynStats("lus", 5);
				if (host.biggestCockArea() >= 20) {
					text += "You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + host.cockDescript(host.biggestCockIndex()) + " has popped out of the top, completely exposed.  Maybe if you shrunk your male parts down a little..."
				}//[If dick is 7+ inches OR balls are apple-sized]
				else if (host.ballSize > 5) {
					text += "You do your best to put the thong on, and while the material is very stretchy, it simply can't even begin to cover everything, and your " + host.ballsDescriptLight() + " hang on the sides, exposed.  Maybe if you shrunk your male parts down a little..."
				}
			}
			return text + "\n\n";
		}
	}
}
