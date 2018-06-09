/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Shields
{
	import classes.Creature;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Shield;
	import classes.Scenes.SceneLib;

	public class DragonShellShield extends Shield {

		public function DragonShellShield() {
			super("DrgnShl", "DrgnShl", "dragon-shell shield", "a dragon-shell shield", 14, 1500, "A durable shield that has been forged from the remains of the dragon egg you found in the swamp.  Absorbs any fluid attacks you can catch, rendering them useless.");
		}

		override public function get description():String {
			var desc:String = game.flags[kFLAGS.EMBER_HATCHED] > 0 ? "A durable shield that has been forged from the dragon eggshell Ember gave you for maxing out " + SceneLib.emberScene.emberMF("his", "her") + " affection." : "A durable shield that has been forged from the remains of the dragon egg you found in the swamp.";
			//Type
			desc += "\n\nType: Shield";
			//Block Rating
			desc += "\nBlock: " + String(defense);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		override public function useText(host:Creature):String { //Produces any text seen when equipping the armor normally
			game.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD]++;
			if (game.flags[kFLAGS.TIMES_EQUIPPED_EMBER_SHIELD] == 1) {
				return "Turning the sturdy shield over in inspection, you satisfy yourself as to its craftsmanship and adjust the straps to fit your arm snugly.  You try a few practice swings, but find yourself overbalancing at each one due to the deceptive lightness of the material.  Eventually, though, you pick up the knack of putting enough weight behind it to speed it through the air while thrusting a leg forward to stabilize yourself, and try bashing a nearby rock with it.  You smile with glee as "
				+ "[if(strength < 80) bits and pieces from the surface of the|"
				+ "huge shards of the shattered]"
				+ " rock are sent flying in all directions."
				+ "\n\nAfter a few more practice bashes and shifts to acquaint yourself with its weight, you think you're ready to try facing an enemy with your new protection.  One last thing... taking off the shield and turning it straps-down, you spit onto the surface.  Satisfyingly, the liquid disappears into the shell as soon as it touches.";
			}
			else {
				return super.useText(host);
			}
		}

	}
}
