package classes.Items.Armors 
{
	import classes.BodyParts.LowerBody;
	import classes.CoC;
	import classes.Creature;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armor;

	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class MaraeArmor extends Armor
	{
		private var _pure:Boolean;
		public function MaraeArmor(pure:Boolean = false)
		{
			var params:Object = {
				myid: pure ? "DB.Armr" : "TB.Armr",
				shrt: pure ? "DB.Armr" : "TB.Armr",
				name: pure ? "divine bark armor" : "tentacled bark armor",
				long: pure ? "a suit of divine bark armor" :  "a suit of tentacled bark armor",
				defn: pure ? 60 : 55,
				valu: pure ? 7200 : 6600,
				desc: pure ? "This suit of armor is finely made from the white bark you've received from Marae as a reward." : "This suit of armor is finely made from the white bark from corrupted Marae you've defeated. It comes with tentacles though.",
				perk: "heavy"
			};
			super(
					params.myid,
					params.shrt,
					params.name,
					params.long,
					params.defn,
					params.valu,
					params.desc,
					params.perk
			);
			_pure = pure
		}
		//każde 1 armor point kosztuje 120
		override public function get defense():int { return 5 + int(game.player.cor / 2); }

		override public function useText(host:Creature):String {
			var highCor:Boolean = host.cor >= 66;
			var medCor:Boolean = host.cor >= 33;
			var highOrFetish:Boolean = highCor || game.flags[kFLAGS.PC_FETISH] > 0;

			var text:String = "You " + game.player.clothedOrNaked("strip yourself naked before you ") + "proceed to put on the armor. ";

			if (!_pure) {
				if (highCor) {
					text += "You are eager with the idea of wearing tentacle-infested armor. ";
				} else if (medCor) {
					text += "You are not sure about the idea of armor that is infested with tentacles. ";
				} else {
					text += "You shudder at the idea of wearing armor that is infested with tentacles but you proceed anyway. ";
				}
			}

			text += "\n\nFirst, you clamber into the breastplate. ";

			if (host.isBiped()) {
				if (host.lowerBody == LowerBody.HUMAN) {
					text += "Then you put your feet into your boots. With the boots fully equipped, you move on to the next piece. ";
				} else {
					text += "Then you attempt to put your feet into your boots. You realize that the boots are designed for someone with normal feet. You have to modify the boots to fit and when you do put on your boots, your feet are exposed. ";
				}
			}

			text += "Next, you put on your reinforced bark bracers to protect your arms.\n\n";

			if (host.isTaur()) {
				text += "Last but not least, you take a silken loincloth in your hand but stop short as you examine your tauric body. There is no way you could properly conceal your genitals! ";
				if (highOrFetish) {
					text += "Regardless, you are happy with what you are right now. ";
				} else if (medCor) {
					text += "You blush a bit, not sure how you feel. ";
				} else {
					text += "You let out a sigh. Being a centaur surely is inconvenient! ";
				}
				text += "You leave the silken loincloth in your possessions for the time being.";
			}
			else {
				text += "Last but not least, you put your silken loincloth on to cover your groin. You thank Konstantin for that and you know that you easily have access to your "
						+ "[if(hascock)[cocks]]"
						+ "[if(isherm) and ]"
						+ "[if(hasvagina)[vagina]]"
						+ "[if(isgenderless)groin]"
						+ " should you need to. ";

				if (host.hasCock()) {
					if (host.biggestCockArea() >= 100) {
						text += "Your manhood is too big to be concealed by your silken loincloth. Part of your " + host.cockDescriptShort(host.biggestCockIndex()) + " is visible. ";
						if (highOrFetish) {
							text += "You admire how your manhood is visible. ";
						} else if (medCor) {
							text += "You blush a bit, not sure how you feel. ";
						} else {
							text += "You let out a sigh. ";
						}
					}
					else if (host.biggestCockArea() >= 40) {
						text += "Large bulge forms against your silken loincloth. ";
					}
				}
				if (highOrFetish) {
					text += "You'd love to lift your loincloth and show off whenever you want to. ";
				}
			}
			text += "You are suited up and all good to go. ";
			if (!_pure && host.lust < 20) {
				text += "\n\nYou can feel the tentacles inside your breastplate slither their way and tease your [butt]. You " + (game.player.cor < 60 ? "gasp in surprise" : "moan in pleasure") + ".";
				host.dynStats("lust", 30);
			}
			return text;
		}
	}
}
