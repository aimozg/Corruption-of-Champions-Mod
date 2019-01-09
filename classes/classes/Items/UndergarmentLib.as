package classes.Items 
{
	/**
	 * ...
	 * @author Kitteh6660
	 */

import classes.ItemType;
import classes.Items.Undergarments.*;
	import classes.PerkLib;
import classes.internals.Utils;

public final class UndergarmentLib
	{
		public static const NOTHING:Undergarment = new Nothing().register() as Undergarment;
		
		//Upper
		public const C_BRA  :Undergarment = new Undergarment("C. Bra ", "C. Bra", "comfortable bra", "a pair of comfortable bra", Undergarment.TYPE_UPPERWEAR, 6, 0, 0, "A generic pair of bra.");
		public const C_SHIRT:Undergarment = new Undergarment("C.Shirt", "C. Shirt", "comfortable shirt", "a comfortable shirt", Undergarment.TYPE_UPPERWEAR, 6, 0, 0, "A generic pair of shirt.");
		public const DS_BRA :Undergarment = new Undergarment("DS. Bra", "D.Scale Bra", "dragonscale bra", "a pair of dragonscale bra", Undergarment.TYPE_UPPERWEAR, 600, 2, 1, "This bra appears to be made of dragon scale. It's held together with leather straps for flexibility. Great for those on the primal side!");
		public const DS_VEST:Undergarment = new Undergarment("DS.Vest", "D.Scale Vest", "dragonscale vest", "a dragonscale vest", Undergarment.TYPE_UPPERWEAR, 600, 2, 1, "This sleeveless vest is made of dragonscale, treated until it is as light and comfortable as cloth.  However, these treatments have reduced the defensive properties of the dragonscale.");
		public const EW_CORS:Undergarment = new Undergarment("EW.Cors", "E.W. Corset", "ebonweave corset", "an ebonweave corset", Undergarment.TYPE_UPPERWEAR, 900, 3, 2, "This corset is ebonweave, created using refined ebonbloom petals. The ebonweave is elastic, making the corset surprisingly comfortable to wear, while displaying your bust down to the most subtle curves.");
		public const EW_VEST:Undergarment = new Undergarment("EW.Vest", "E.W. Vest", "ebonweave vest", "an ebonweave vest", Undergarment.TYPE_UPPERWEAR, 900, 3, 2, "This vest is ebonweave, created using refined ebonbloom petals. Elastic, form-fitting and somewhat transparent, this comfortable vest will display your curves, masculine or feminine.");
		public const LTX_BRA:Undergarment = new Undergarment("Ltx.Bra", "Latex Bra", "latex bra", "a pair of latex bra", Undergarment.TYPE_UPPERWEAR, 250, 0, 2, "This bra is black and shiny, obviously made of latex. It's designed to fit snugly against your breasts.");
		public const SS_BRA :Undergarment = new Undergarment("SS. Bra", "S.Silk Bra", "spider-silk bra", "a pair of spider-silk bra", Undergarment.TYPE_UPPERWEAR, 1000, 1, 1, "This bra looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.");
		public const SSSHIRT:Undergarment = new Undergarment("SSShirt", "S.Silk Shirt", "spider-silk shirt", "a spider-silk shirt", Undergarment.TYPE_UPPERWEAR, 1000, 1, 1, "A comfortable undershirt.  It's as white as snow and woven with hundreds of strands of fine spider silk.");
		
		//Lower
		public const C_LOIN :Undergarment = new Undergarment("C. Loin", "C. Loin", "comfortable loincloth", "a pair of comfortable loincloth", Undergarment.TYPE_LOWERWEAR, 6, 0, 0, "A generic pair of loincloth.", "NagaWearable");
		public const C_PANTY:Undergarment = new Undergarment("C.Panty", "C. Panties", "comfortable panties", "a pair of comfortable panties", Undergarment.TYPE_LOWERWEAR, 6, 0, 0, "A generic pair of panties.");
		public const DS_LOIN:Undergarment = new Undergarment("DS.Loin", "D.Scale Loin", "dragonscale loincloth", "a pair of dragonscale loincloth", Undergarment.TYPE_LOWERWEAR, 600, 2, 1, "This loincloth appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side!", "NagaWearable");
		public const DSTHONG:Undergarment = new Undergarment("DSPanty", "D.Scale Thong", "dragonscale thong", "a pair of dragonscale thong", Undergarment.TYPE_LOWERWEAR, 600, 2, 1, "This thong appears to be made of dragonscale and held together with a leather strap that goes around your waist. Great for those on the wild side!");
		public const EW_JOCK:Undergarment = new Undergarment("EW.Jock", "E.W. Jock", "ebonweave jockstrap", "an ebonweave jockstrap", Undergarment.TYPE_LOWERWEAR, 900, 3, 2, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size.");
		public const EWTHONG:Undergarment = new Undergarment("EWPanty", "E.W. Thong", "ebonweave thong", "a pair of ebonweave thong", Undergarment.TYPE_LOWERWEAR, 900, 3, 2, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size.");
		public const FURLOIN:Undergarment = new Undergarment("FurLoin", "FurLoin", "fur loincloth", "a front and back set of loincloths", Undergarment.TYPE_LOWERWEAR, 6, 0, 1, "A pair of loincloths to cover your crotch and butt.  Typically worn by people named 'Conan'. ", "NagaWearable");
		public const GARTERS:Undergarment = new Undergarment("Garters", "Garters", "stockings and garters", "a pair of stockings and garters", Undergarment.TYPE_LOWERWEAR, 6, 0, 2, "These pairs of stockings, garters and lingerie are perfect for seducing your partner!");
		public const LTXSHRT:Undergarment = new Undergarment("LtxShrt", "LatexShorts", "latex shorts", "a pair of latex shorts", Undergarment.TYPE_LOWERWEAR, 300, 0, 2, "These shorts are black and shiny, obviously made of latex. It's designed to fit snugly against your form.");
		public const LTXTHNG:Undergarment = new Undergarment("LtxThng", "LatexThong", "latex thong", "a pair of latex thong", Undergarment.TYPE_LOWERWEAR, 300, 0, 2, "This thong is black and shiny, obviously made of latex. It's designed to fit snugly against your form.");
		public const R_JOCK :Undergarment = new Undergarment("R. Jock", "Rune Jock", "rune jock", "runed ebonweave jock", Undergarment.TYPE_LOWERWEAR, 1200, 3, 3, "This jock is ebonweave, made from refined ebonbloom petals. This jock is comfortable and elastic, providing support while comfortably containing assets of any size. Adorning the front is a rune of lust, glowing with dark magic.", "", PerkLib.WellspringOfLust);
		public const R_THONG:Undergarment = new Undergarment("R.Thong", "RuneThong", "rune thong", "runed ebonweave thong", Undergarment.TYPE_LOWERWEAR, 1200, 3, 3, "This thong is ebonweave, designed to fit snugly around your form. Thanks to the alchemical treatments, this thong is elastic enough to comfortably hold assets of any size. Adorning the front is a rune of lust, glowing with dark magic.", "", PerkLib.WellspringOfLust);
		public const SS_LOIN:Undergarment = new Undergarment("SS.Loin", "S.Silk Loin", "spider-silk loincloth", "a spider-silk loincloth", Undergarment.TYPE_LOWERWEAR, 1000, 1, 1, "This loincloth looks incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk. ", "NagaWearable");
		public const SSPANTY:Undergarment = new Undergarment("SSPanty", "S.Silk Panty", "spider-silk panties", "a pair of spider-silk panties", Undergarment.TYPE_LOWERWEAR, 1000, 1, 1, "These panties look incredibly comfortable. It's as white as snow and finely woven with hundreds of strands of spider silk.");
		
		public function UndergarmentLib() 
		{
			for each (var e:* in Utils.objectMemberValues(this,"constant")) {
				if (e is ItemType) (e as ItemType).register();
			}
		}
		
	}

}