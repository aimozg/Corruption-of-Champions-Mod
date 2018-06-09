package classes.Items.Armors 
{
	import classes.CoC;
	import classes.Creature;
	import classes.Items.Armor;
	import classes.Items.UndergarmentLib;

	public class LethiciteArmor extends Armor
	{	
		public function LethiciteArmor() 
		{
			super("LthcArm","Lthc. Armor","lethicite armor","a suit of glowing purple lethicite armor",28,3000,"This is a suit of lethicite armor. It's all purple and it seems to glow. The pauldrons are spiky to give this armor an imposing appearance. It doesn't seem to cover your crotch and nipples though. It appears to be enchanted to never break and you highly doubt the demons might be able to eat it!","Heavy");
		}
		
		override public function get defense():int { return 20 + int(game.player.cor / 10); }
		
		override public function useText(host:Creature):String
		{
			var strings:Object = {
				high:{
					init:"You are eager to show off once you get yourself suited up. ",
					undergarment:"You ponder over taking off your undergarments.",
					none:"You delight in having your nether regions open to the world."
				},
				med:{
					init:"You are not sure about the crotch-exposing armor. ",
					undergarment:"You are unsure about whether you should keep your [lowergarment] on or not.",
					none:"You are unsure how you feel about your crotch being exposed to the world."
				},
				low:{
					init:"You hesitate at how the armor will expose your groin but you proceed to put it on anyway. ",
					undergarment:"Good thing you have your [lowergarment] on!",
					none:"You blush with embarrassment. "
				}
			};
			var corLevel:Object;
			switch(true){
				case host.cor >= 66: corLevel = strings.high; break;
				case host.cor >= 33: corLevel = strings.med; break;
				default: corLevel = strings.low; break;
			}
			var text:String = "You " + game.player.clothedOrNaked("strip yourself naked before you ") + "proceed to put on the strange, purple crystalline armor. ";
			text += corLevel.init;
			//Put on breastplate
			text += "\n\nFirst, you clamber into the breastplate. It has imposing, spiked pauldrons to protect your shoulders. The breastplate shifts to accommodate your [chest] and when you look down, your [nipples] are exposed. ";
			if (host.biggestLactation() >= 4) text += "A bit of milk gradually flows over your breastplate. ";
			//Put on leggings
			if (!host.isBiped()) {
				text += "\n\nThe leggings are designed for someone with two legs so you leave them into your pack.";
			}
			else {
				text += "\n\nNext, you slip into the leggings. By the time you get the leggings fully adjusted, you realize that the intricately-designed opening gives access to your groin! ";
				if(host.lowerGarmentName == UndergarmentLib.NOTHING.name){
					text += "[if(hascock)[multicock] hang" + (host.cocks.length == 1? "s":"") + " freely. ]";
					text += corLevel.none;
				} else {
					text += corLevel.undergarment;
				}
				text += " Then, you slip your feet into the 'boots'; they aren't even covering your feet. You presume they were originally designed for demons, considering how the demons either have high-heels or clawed feet.";
			}
			//Finishing touches
			text += "\n\nFinally, you put the bracers on to protect your arms. Your fingers are still exposed so you can still get a good grip.";
			text += "\n\nYou are ready to set off on your adventures!\n\n";
			return text;
		}
	}

}