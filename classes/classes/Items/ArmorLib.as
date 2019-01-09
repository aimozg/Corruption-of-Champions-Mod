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
		/*

find regex

new *Armor\("([^"]++)", *"([^"]++)", *"([^"]++)", *"([^"]++)", *(\d++), *(\d++), *"([^"]++)", ([\w."]++), *(true|false), *(PerkLib.\w++), *(\d+), *(\d+), *(\d+), *(\d+)(?:, *"[^"]*")?\);
replace with

factory.createArmorType(<armor id="$1">
\t\t\t<short>$2</short>
\t\t\t<name>$3</name>
\t\t\t<long>$4</long>
\t\t\t<defense>$5</defense>
\t\t\t<value>$6</value>
\t\t\t<description>$7</description>
\t\t\t<subType>\${$8}</subType>
\t\t\t<supportsUndergarment>$9</supportsUndergarment>
\t\t\t<perk id={$10.id}>
\t\t\t\t<value1>$11</value1>
\t\t\t\t<value2>$12</value2>
\t\t\t\t<value3>$13</value3>
\t\t\t\t<value4>$14</value4>
\t\t\t</perk>
\t\t</armor>);
  
		 */
		
		public static const COMFORTABLE_UNDERCLOTHES:Armor = new ComfortableUnderclothes().register() as Armor;
		public static const NOTHING:Armor = new Nothing().register() as Armor;
//25 za 1 ptk robes, 20 dla light, 40 dla medium i 60 dla heavy, z perkiem/dod. efektem podwaja koszt za każdy
		public function get ADVCLTH():Armor {
			return ItemType.lookupItem("AdvClth") as Armor;
		}
		public function get A_ROBE_():Armor {
			return ItemType.lookupItem("A.Robe") as Armor;
		}
		public function get ARCBANG():Armor {
			return ItemType.lookupItem("ArcaBangl") as Armor;
		}
		public function get B_DRESS():Armor {
			return ItemType.lookupItem("B.Dress") as Armor;
		}
		public const BEEARMR:Armor = new BeeArmor();
		public function get BIMBOSK():Armor {
			return ItemType.lookupItem("BimboSk") as Armor;
		}
		public function get BKIMONO():Armor {
			return ItemType.lookupItem("B.Kimono") as Armor;
		}
		public function get BONSTRP():Armor {
			return ItemType.lookupItem("BonStrp") as Armor;
		}
		public function get C_CLOTH():Armor {
			return ItemType.lookupItem("C.Cloth") as Armor;
		}
		public function get CHBIKNI():Armor {
			return ItemType.lookupItem("ChBikni") as Armor;
		}
		public function get CLSSYCL():Armor {
			return ItemType.lookupItem("ClssyCl") as Armor;
		}
		public const CTPALAD:Armor = new CentaurArmor();
		public const CTBGUAR:Armor = new CentaurBlackguardArmor();
		public const DBARMOR:Armor = new MaraeArmor(true);
		public function get DSCLARM():Armor {
			return ItemType.lookupItem("DSclArm") as Armor;
		}
		public function get DSCLROB():Armor {
			return ItemType.lookupItem("DSclRob") as Armor;
		}
		public function get EHGARB_():Armor {
			return ItemType.lookupItem("EH.Garb") as Armor;
		}
		public function get EWJACK_():Armor {
			return ItemType.lookupItem("EWJack") as Armor;
		}
		public function get EWPLTMA():Armor {
			return ItemType.lookupItem("EWPltMa") as Armor;
		}
		public function get EWROBE_():Armor {
			return ItemType.lookupItem("EWRobe") as Armor;
		}
		public function get FULLCHN():Armor {
			return ItemType.lookupItem("FullChn") as Armor;
		}
		public function get FULLPLT():Armor {
			return ItemType.lookupItem("FullPlt") as Armor;
		}
		public function get GELARMR():Armor {
			return ItemType.lookupItem("GelArmr") as Armor;
		}
		public const GOOARMR:Armor = new GooArmor();
		public function get H_GARB_():Armor {
			return ItemType.lookupItem("H. Garb") as Armor;
		}
		public const I_CORST:Armor = new InquisitorsCorset();
		public const I_ROBES:Armor = new InquisitorsRobes();
		public function get INDECST():Armor {
			return ItemType.lookupItem("IndecSt") as Armor;
		}
		public function get INDEDSR():Armor {
			return ItemType.lookupItem("IndeDSR") as Armor;
		}
		public function get INDEEWR():Armor {
			return ItemType.lookupItem("IndeEWR") as Armor;
		}
		public function get INDESSR():Armor {
			return ItemType.lookupItem("IndeSSR") as Armor;
		}
		public function get LEATHRA():Armor {
			return ItemType.lookupItem("LeathrA") as Armor;
		}
		public const URTALTA:Armor = new LeatherArmorSegments();
		public const LMARMOR:Armor = new LustyMaidensArmor();
		public const LTHCARM:Armor = new LethiciteArmor();
		public function get LTHRPNT():Armor {
			return ItemType.lookupItem("LthrPnt") as Armor;
		}
		public function get LTHRROB():Armor {
			return ItemType.lookupItem("LthrRob") as Armor;
		}
		public function get M_ROBES():Armor {
			return ItemType.lookupItem("M.Robes") as Armor;
		}
		public const NAGASLK:Armor = new NagaSilkDress();
		public function get NURSECL():Armor {
			return ItemType.lookupItem("NurseCl") as Armor;
		}
		public function get OVERALL():Armor {
			return ItemType.lookupItem("Overall") as Armor;
		}
		public function get PKIMONO():Armor {
			return ItemType.lookupItem("P.Kimono") as Armor;
		}
		public function get R_BDYST():Armor {
			return ItemType.lookupItem("R.BdySt") as Armor;
		}
		public function get RBBRCLT():Armor {
			return ItemType.lookupItem("RbbrClt") as Armor;
		}
		public function get RKIMONO():Armor {
			return ItemType.lookupItem("R.Kimono") as Armor;
		}
		public const S_SWMWR:Armor = new SluttySwimwear();
		public function get SAMUARM():Armor {
			return ItemType.lookupItem("SamuArm") as Armor;
		}
		public function get SCALEML():Armor {
			return ItemType.lookupItem("ScaleMl") as Armor;
		}
		public const SEDUCTA:Armor = new SeductiveArmor();
		public const SEDUCTU:Armor = new SeductiveArmorUntrapped();
		public function get SS_ROBE():Armor {
			return ItemType.lookupItem("SS.Robe") as Armor;
		}
		public function get SSARMOR():Armor {
			return ItemType.lookupItem("SSArmor") as Armor;
		}
		public function get T_BSUIT():Armor {
			return ItemType.lookupItem("T.BSuit") as Armor;
		}
		public const TBARMOR:Armor = new MaraeArmor();
		public function get TRASARM():Armor {
			return ItemType.lookupItem("TraSArm") as Armor;
		}
		public function get TUBETOP():Armor {
			return ItemType.lookupItem("TubeTop") as Armor;
		}
		public function get W_ROBES():Armor {
			return ItemType.lookupItem("W.Robes") as Armor;
		}
		public function get WKIMONO():Armor {
			return ItemType.lookupItem("W.Kimono") as Armor;
		}
		public const FRSGOWN:Armor = new Gown();

		public function ArmorLib()
		{
			for each (var e:* in Utils.objectMemberValues(this,"constant")) {
				if (e is ItemType) (e as ItemType).register();
			}
		}
	}
}
