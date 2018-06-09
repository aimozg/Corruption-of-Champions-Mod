/**
 * Created by aimozg on 15.01.14.
 */
package classes.Items.Armors
{
	import classes.Creature;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armor;
	import classes.Items.ArmorLib;
	import classes.Items.Equipable;
	import classes.Scenes.SceneLib;

	public final class SeductiveArmor extends Armor {
		
		public function SeductiveArmor()
		{
			super("SeductA", "SeductA", "scandalously seductive armor", "a set of scandalously seductive armor", 0, 1, "A complete suit of scalemail shaped to hug tightly against every curve, it has a solid steel chest-plate with obscenely large nipples molded into it.  The armor does nothing to cover the backside, exposing the wearer's cheeks to the world.","Heavy");
		}
		
		override public function useText(host:Creature):String {
			if (!SceneLib.ceraphFollowerScene.ceraphIsFollower()) {
				game.player.nipplesPierced = 1;
				game.player.nipplesPShort = "seamless black nipple-studs";
				game.player.nipplesPLong = "Seamless black nipple-studs";
				game.flags[kFLAGS.PC_FETISH] = 2;
				return "After struggling to get it on, you feel a sudden shift in your scandalous new armor.  To your horror, it begins folding into itself, revealing more and more of your [skin.type] and the comfortable underclothes you had on underneath it.  The transforming armor gradually covers less and less of you until it's little more than a pair of huge nipple-coverings and a silver chain.  A loud KA-CHUNK startles you, and then you're screaming as you feel something stabbing through your nipples.  Goosebumps cover your flesh as you twist in unexpected agony.\n\n"
				+ "After you've had a chance to recover, you inspect your abused nipples and discover that your armor has totally disappeared.  The only thing left behind is a pair of seamless black nipple-studs, embedded into your vulnerable flesh.  There doesn't appear to be any way to remove them either.  Thankfully, your comfortable underclothes have been unaffected by the sudden disappearance of your armor.  The thought of having to run around naked stays stubbornly locked in your mind, and you mentally curse the demon for what she's done to you.\n\n"
				+ "As if summoned by your thoughts, you can hear her voice on the wind, taunting you again, [say: Enjoy your new bondage fetish, pet!  One more piercing and you'll be ready.  Don't have too much fun being tied down and fucked, ok?]\n\n"
				+ (game.player.nipplesPierced > 0) ? "You're left to wonder - where did the old piercings go?\n\n":"";
			}
			else {
				return "As you're trying to put on the armor, Ceraph appears from nowhere, apologizing profusely and stopping you before you can slide the last strap into place.  [say: Please don't put that on, " + game.player.mf("Master","Mistress") + ".  I trapped that armor to pierce new fetishes the unwary so that I could add them to my harem.  I'd hate to garner your anger.]  She wrings her hands nervously.  [say: If you'll hand it here, I'll get rid of it for you. Noone would buy it anyway.]"
				+ "\n\nYou shrug and toss her the armor, disappointed that you're down a potentially sexy outfit."
				+ "\n\nCeraph bows gratefully and swiftly backpedals, offering, [say: And if you ever want me to stuff you full of magic fetishes, just ask, okay?]"
				+ "\n\nShe's gone before you can reply.  Sometimes she's more trouble than she's worth.";
			}
		}
		
		override public function equip(host:Creature):Equipable {
			super.equip(host);
			return ArmorLib.COMFORTABLE_UNDERCLOTHES; //After seductive armor magic the player is left in their underclothes
		}
	}
}
