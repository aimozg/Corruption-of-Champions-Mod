package classes.Items.Consumables 
{
	import classes.Creature;
	import classes.EngineCore;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	import classes.PerkLib;
	import classes.internals.Utils;

	/**
	 * Body lotions, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
	public class BodyLotion extends Consumable 
	{
		private var _adj:String;
		private var _strings:Object;
		private static const STRINGS:Object = {
			"smooth": {
				descs : ["smooth liquid", "thick cream"],
				plain : "Soon your skin is smoother but in a natural healthy way.",
				fur   : "Soon you part your fur to reveal smooth skin that still appears natural.",
				scales: "Soon your scales on your underbody are smoother but in a natural healthy way."
			},
			"rough" : {
				descs : ["abrasive goop", "rough textured goop"],
				plain : "Soon your skin is rougher as if you’ve just finished a long day’s work.",
				fur   : "Soon you part your fur to reveal rough skin that still appears natural.",
				scales: "Soon your scales on your underbody are rougher as if you’ve just finished a long day’s work."
			},
			"sexy"  : {
				descs : ["smooth liquid", "attractive cream", "beautiful cream"],
				plain : "Soon your skin is so sexy you find it hard to keep your hands off yourself.",
				fur   : "Soon you part your fur to reveal sexy skin that makes you want to kiss yourself.",
				scales: "Soon your scales on your underbody are so sexy you find it hard to keep your hands off yourself."
			},
			"clear" : {
				descs : ["smooth liquid", "thick cream"],
				plain : "Soon the natural beauty of your [skinfurscales] is revealed without anything extra or unnecessary.",
				fur   : "Soon you part your fur to reveal the natural beauty of your [skinfurscales] skin.",
				scales: "Soon the natural beauty of your [skinFurScales] is revealed without anything extra or unnecessary."
			}
		};
		
		public function BodyLotion(id:String, adj:String, longAdj:String) 
		{
			this._adj = adj.toLowerCase();
			var shortName:String = adj + " Ltn";
			var longName:String = "a flask of " + this._adj + " lotion";
			var value:int = ConsumableLib.DEFAULT_VALUE;
			var description:String = "A small wooden flask filled with a " + longAdj + " . A label across the front says, \"" + adj + " Lotion.\"";
			super(id, shortName, longName, value, description);
			if(!_adj in STRINGS){
				throw new Error("Body Lotion strings not found for type: " + _adj);
			}
			this._strings = STRINGS[_adj];
		}
		
		private function liquidDesc():String {
			return Utils.randomChoice(_strings.descs);
		}
		
		override public function useItem(host:Creature):Boolean {
			if (host.skinAdj == _adj || host.hasPerk(PerkLib.TransformationImmunity)) {
				outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. Once you’ve finished you feel reinvigorated. ");
				EngineCore.HPChange(10, true);
				return false;
			}

			if (host.hasGooSkin()) { //If skin is goo, don't change.
				outputText("You take the lotion and pour the " + liquidDesc() + " into yourself. The concoction dissolves, leaving your gooey epidermis unchanged. As a matter of fact nothing happens at all.");
				return false;
			}

			if (_adj == "clear") {
				host.skinAdj = "";
			} else {
				host.skinAdj = _adj;
			}

			switch (true) {
				case host.hasPlainSkinOnly():
					outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly. ");
					outputText(_strings.plain);
					break;
				case host.hasFur():
					outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the lotion and", "You take the lotion and") + " begin massaging it into your skin despite yourself being covered with fur. It takes little effort but once you’ve finished... nothing happens. A few moments pass and then your skin begins to tingle. ");
					outputText(_strings.fur);
					break;
				case host.hasScales():
					outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly.");
					outputText(_strings.scales);
					break;
				default:
					outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _adj + " skin.");
			}
			return false;
		}
	}

}