/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.Items.Armors.*;
	import classes.PerkLib;
	import classes.PerkType;
	import classes.internals.Utils;

import coc.model.ArmorTypeFactory;

public final class ArmorLib
	{
		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes().register() as Armor;
		public static const NOTHING:Armor = new Nothing().register() as Armor;
		private static const factory:ArmorTypeFactory = new ArmorTypeFactory();
//25 za 1 ptk robes, 20 dla light, 40 dla medium i 60 dla heavy, z perkiem/dod. efektem podwaja koszt za każdy
		public const ADVCLTH:Armor = factory.createArmorType(<armor id="AdvClth">
			<short>G. Clothes</short>
			<name>green adventurer's clothes</name>
			<long>a green adventurer's outfit, complete with pointed cap</long>
			<defense>2</defense>
			<value>50</value>
			<description>A set of comfortable green adventurer's clothes.  It even comes complete with a pointy hat!</description>
			<category>Light</category>
		</armor>);
		public const A_ROBE_:Armor = new Armor("A.Robe", "A.Robe", "apprentice's robe", "an apprentice's robe", 1, 25, "This drab robe lacks adornment, yet retains an air of mysticality. The low quality of the fabric coupled with its mystic air suggests that it is a garment meant for mages in training.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 10, 0, 0, 0);
		public const ARCBANG:Armor = new Armor("ArcaBangl", "ArcaneBangles", "arcane bangles", "a set of arcane bangles", 1, 150, "Silver bangles to be worn from the wrists and ankles, inscribed with arcane runes.  For some reason, you feel like wearing these with armor or clothes is somehow wrong.", Armor.LIGHT, true, PerkLib.WizardsEnduranceAndSluttySeduction, 20, 5, 0, 0, "Your arcane bangles allows you access to 'Seduce', an improved form of 'Tease'.");
		public const B_DRESS:Armor = new Armor("B.Dress","Long Dress","long ballroom dress patterned with sequins","a ballroom dress patterned with sequins",0,40,"A long ballroom dress patterned with sequins.  Perfect for important occasions.",Armor.MEDIUM);
		public const BEEARMR:Armor = new BeeArmor();
		public const BIMBOSK:Armor = new Armor("BimboSk", "BimboSk", "bimbo skirt", "a skirt that looks like it belongs on a bimbo", 1, 40, "A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.", Armor.LIGHT, false, PerkLib.SluttySeduction, 10, 0, 0, 0, "Your delightfully slutty yet upbeat garb helps you seduce your foes!");
		public const BKIMONO:Armor = new Armor("B.Kimono", "B.Kimono", "blue kimono", "a blue kimono", 1, 200, "This lovely blue kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 20, 20, 0, 0);
		public const BONSTRP:Armor = new Armor("BonStrp", "BonStrp", "barely-decent bondage straps", "a set of bondage straps", 0, 40, "These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.", Armor.LIGHT, false, PerkLib.SluttySeduction, 10, 0, 0, 0, "Your fetishy bondage outfit allows you access to an improved form of 'Tease'.");
		public const C_CLOTH:Armor = factory.createArmorType(<armor id="C.Cloth">
			<short>C.Cloth</short>
			<name>comfortable clothes</name>
			<long>a set of comfortable clothes</long>
			<defense>0</defense>
			<value>1</value>
			<description>These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.</description>
			<category>Light</category>
		</armor>);
		public const CHBIKNI:Armor = new Armor("ChBikni", "Chn Bikini", "revealing chainmail bikini", "a chainmail bikini", 2, 80, "A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.", Armor.LIGHT, false, PerkLib.SluttySeduction, 5, 0, 0, 0, "Your revealing chain bikini allows you access to 'Seduce', an improved form of 'Tease'.");
		public const CLSSYCL:Armor = new Armor("ClssyCl", "Suitclothes", "classy suitclothes", "a set of classy suit-clothes", 1, 40, "A set of classy suitclothes.", Armor.LIGHT);
		public const CTPALAD:Armor = new CentaurArmor();
		public const CTBGUAR:Armor = new CentaurBlackguardArmor();
		public const DBARMOR:Armor = new MaraeArmor(true);
		public const DSCLARM:Armor = new Armor("DSclArm", "D.Scale Armor", "dragonscale armor", "a suit of dragonscale armor", 20, 800, "This armor is cleverly fashioned from dragon scales. It offers high protection while at the same time, quite flexible.", Armor.MEDIUM);
		public const DSCLROB:Armor = new Armor("DSclRob", "D.Scale Robes", "dragonscale robes", "a dragonscale robes", 10, 500, "This robe is expertly made from dragon scales. It offers high protection while being lightweight and should be comfortable to wear all day.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 20, 0, 0, 0);
		public const EHGARB_:Armor = new Armor("EH.Garb", "E.Heretic‘s Garb", "Ebonweave Heretic‘s Garb", "an Ebonweave Heretic‘s Garb", 20, 1600, "This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of arrowproof clothes, covered by a mesh breastplate and leatherlike duster inscribed with glyphs of magic and warding.  A trilby adorned with a moon pin completes the look.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 20, 20, 0, 0, "");
		public const EWJACK_:Armor = new Armor("EWJack", "E.W. Jacket", "ebonweave jacket", "an ebonweave jacket", 24, 960, "This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of a leatherlike jacket, a mesh breastplate and a set of arrowproof clothing. Between them all, the outfit provide layers of protection rivaling heavier, more traditional armor.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 15, 0, 0, 0);
		public const EWPLTMA:Armor = new Armor("EWPltMa", "E.W. Platemail", "ebonweave platemail", "an ebonweave platemail", 36, 4320, "The armor is ebonweave, created using refined ebonbloom petals. The armor consists of two layers, an outer layer of ebonweave playing, and an inner layer of arrowproof ebonweave cloth.", Armor.HEAVY, true, PerkLib.WizardsEndurance, 15, 0, 0, 0);
		public const EWROBE_:Armor = new Armor("EWRobe", "E.W. Robe", "ebonweave robe", "an ebonweave robe", 12, 600, "This robe is ebonweave, created using refined ebonbloom petals. This robe is as comfortable as cloth yet more protective than chainmail. The cloth has a mystic aura, helpful when working magic.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 30, 0, 0, 0);
		public const FULLCHN:Armor = new Armor("FullChn","Full Chain","full-body chainmail","a full suit of chainmail armor",8,320,"This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.",Armor.MEDIUM);
		public const FULLPLT:Armor = new Armor("FullPlt","Full Plate","full platemail","a suit of full-plate armor",21,1260,"A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.",Armor.HEAVY);
		public const GELARMR:Armor = new Armor("GelArmr","GelArmr","glistening gel-armor plates","a suit of gel armor",10,600,"This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.",Armor.HEAVY);
		public const GOOARMR:Armor = new GooArmor();
		public const H_GARB_:Armor = new Armor("H. Garb", "Heretic‘s Garb", "Heretic‘s Garb", "an Heretic‘s Garb", 6, 480, "Weathered traveling clothes, covered by a duster.  Wards and arcane glyphs inscribed in the duster facilitates magic while providing significant defense.  A feather tipped trilby completes the look.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 10, 10);
		public const I_CORST:Armor = new InquisitorsCorset();
		public const I_ROBES:Armor = new InquisitorsRobes();
		public const INDECST:Armor = new Armor("IndecSt", "Indec StAr", "practically indecent steel armor", "a suit of practically indecent steel armor", 5, 400, "This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.", Armor.MEDIUM, true, PerkLib.SluttySeduction, 6, 0, 0, 0, "Your incredibly revealing steel armor allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDEDSR:Armor = new Armor("IndeDSR", "Indec D.Scale Robe", "indecent dragonscale robe", "an indecent dragonscale robe", 4, 400, "More of a longcoat than a robe, this outfit is crafted from dragon scales. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The dragonscale is treated to be durable yet remain comfortable.", Armor.LIGHT, true, PerkLib.WizardsEnduranceAndSluttySeduction, 15, 5, 0, 0, "Your indecent dragonscale robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDEEWR:Armor = new Armor("IndeEWR", "Indec. E.W. Robe", "indecent ebonweave robe", "an indecent ebonweave robe", 6, 600, "More of a longcoat than a robe, this outfit is crafted from refined ebonbloom petals. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The cloth has a mystic aura, helpful when working magic.", Armor.LIGHT, true, PerkLib.WizardsEnduranceAndSluttySeduction, 20, 5, 0, 0, "Your indecent ebonweave robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const INDESSR:Armor = new Armor("IndeSSR", "Indec S.S. Robe", "indecent spider silk robe", "an indecent spider silk robe", 2, 200, "More of a longcoat than a robe, this outfit is crafted from alchemically treated spider silk. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have.", Armor.LIGHT, true, PerkLib.WizardsEnduranceAndSluttySeduction, 15, 5, 0, 0, "Your indecent spider silk robe allows you access to 'Seduce', an improved form of 'Tease'.");
		public const LEATHRA:Armor = new Armor("LeathrA","LeathrA","leather armor segments","a set of leather armor",5,100,"This is a suit of well-made leather armor.  It looks fairly rugged.",Armor.LIGHT);
		public const URTALTA:Armor = new LeatherArmorSegments();
		public const LMARMOR:Armor = new LustyMaidensArmor();
		public const LTHCARM:Armor = new LethiciteArmor();
		public const LTHRPNT:Armor = new Armor("LthrPnt","T.Lthr Pants","white silk shirt and tight leather pants","a pair of leather pants and a white silk shirt",0,20,"A flowing silk shirt and tight black leather pants.  Suave!",Armor.LIGHT);
		public const LTHRROB:Armor = new Armor("LthrRob","Lthr Robes","black leather armor surrounded by voluminous robes","a suit of black leather armor with voluminous robes",6,150,"This is a suit of flexible leather armor with a voluminous set of concealing black robes.",Armor.LIGHT);
		public const M_ROBES:Armor = new Armor("M.Robes","Robes","modest robes","a set of modest robes",0,25,"A set of modest robes, not dissimilar from what the monks back home would wear.",Armor.LIGHT);
		public const NAGASLK:Armor = new NagaSilkDress();
		public const NURSECL:Armor = new Armor("NurseCl", "NurseCl", "skimpy nurse's outfit", "a nurse's outfit", 0, 100, "This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.  It would grant a small regeneration to your HP.", Armor.LIGHT, true, PerkLib.SluttySeduction, 8, 0, 0, 0, "Your fetishy nurse outfit allows you access to an improved form of 'Tease'.");
		public const OVERALL:Armor = new Armor("Overall", "Overalls", "white shirt and overalls", "a white shirt and overalls", 0, 25, "A simple white shirt and overalls.", Armor.LIGHT);
		public const PKIMONO:Armor = new Armor("P.Kimono", "P.Kimono", "purple kimono", "a purple kimono", 1, 200, "This lovely purple kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 20, 20, 0, 0);
		public const R_BDYST:Armor = new Armor("R.BdySt","R.BdySt","red, high-society bodysuit","a red bodysuit for high society",1,50,"A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.",Armor.LIGHT, false);
		public const RBBRCLT:Armor = new Armor("RbbrClt", "Rbbr Fetish", "rubber fetish clothes", "a set of revealing rubber fetish clothes", 3, 150, "A revealing set of fetish-wear.  Upgrades your tease attack with the \"Slutty Seduction\" perk.", Armor.LIGHT, false, PerkLib.SluttySeduction, 8, 0, 0, 0, "Your fetishy rubberwear allows you access to 'Seduce', an improved form of 'Tease'.");
		public const RKIMONO:Armor = new Armor("R.Kimono", "R.Kimono", "red kimono", "a red kimono", 1, 200, "This lovely red kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 20, 20, 0, 0);
		public const S_SWMWR:Armor = new SluttySwimwear();
		public const SAMUARM:Armor = new Armor("SamuArm","Samu.Armor","samurai armor","a suit of samurai armor",18,300,"This suit of armor is originally worn by the Samurai, the warriors from the far East.",Armor.HEAVY);
		public const SCALEML:Armor = new Armor("ScaleMl","Scale Mail","scale-mail armor","a set of scale-mail armor",12,720,"This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.",Armor.HEAVY);
		public const SEDUCTA:Armor = new SeductiveArmor();
		public const SEDUCTU:Armor = new SeductiveArmorUntrapped();
		public const SS_ROBE:Armor = new Armor("SS.Robe", "SS.Robes", "spider-silk robes", "a spider-silk robes", 6, 300, "This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 30, 0, 0, 0);
		public const SSARMOR:Armor = new Armor("SSArmor","SS.Armor","spider-silk armor","a suit of spider-silk armor",25,1500,"This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.",Armor.HEAVY);
		public const T_BSUIT:Armor = new Armor("T.BSuit", "Bodysuit", "semi-transparent bodysuit", "a semi-transparent, curve-hugging bodysuit", 0, 50, "A semi-transparent bodysuit. It looks like it will cling to all the curves of your body.", Armor.LIGHT, true, PerkLib.SluttySeduction, 7, 0, 0, 0, "Your clingy transparent bodysuit allows you access to 'Seduce', an improved form of 'Tease'.");
		public const TBARMOR:Armor = new MaraeArmor();
		public const TRASARM:Armor = new Armor("TraSArm","TraSArmor","training soul armor","a training soul armor",1,120,"This set of heavy armor is made using soulmetal but it main purpose is to allow user train ki to the uttermost limit for novice soul cultivator.",Armor.HEAVY);
		public const TUBETOP:Armor = new Armor("TubeTop","Tube Top","tube top and short shorts","a snug tube top and VERY short shorts",0,25,"A clingy tube top and VERY short shorts.",Armor.LIGHT);
		public const W_ROBES:Armor = new Armor("W.Robes", "W.Robes", "wizard's robes", "a wizard's robes", 1, 50, "These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.", Armor.LIGHT, true, PerkLib.WizardsEndurance, 25, 0, 0, 0);
		public const WKIMONO:Armor = new Armor("W.Kimono", "W.Kimono", "white kimono", "a white kimono", 1, 200, "This lovely white kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.", Armor.LIGHT, true, PerkLib.WizardsAndDaoistsEndurance, 20, 20, 0, 0);
		public const FRSGOWN:Armor = new Gown();

		public function ArmorLib()
		{
			for each (var e:* in Utils.objectMemberValues(this,"constant")) {
				if (e is ItemType) (e as ItemType).register();
			}
		}
	}
}
