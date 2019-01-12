/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
import classes.CoC;
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
		public const ADVCLTH_ID:String = "AdvClth";
		public function get ADVCLTH():Armor {
			return CoC.instance.gameLibrary.findItemType(ADVCLTH_ID) as Armor;
		}
		public const A_ROBE__ID:String = "A.Robe";
		public function get A_ROBE_():Armor {
			return CoC.instance.gameLibrary.findItemType(A_ROBE__ID) as Armor;
		}
		public const ARCBANG_ID:String = "ArcaBangl";
		public function get ARCBANG():Armor {
			return CoC.instance.gameLibrary.findItemType(ARCBANG_ID) as Armor;
		}
		public const B_DRESS_ID:String = "B.Dress";
		public function get B_DRESS():Armor {
			return CoC.instance.gameLibrary.findItemType(B_DRESS_ID) as Armor;
		}
		public const BEEARMR_ID:String = "BeeArmr";
		public function get BEEARMR():Armor {
			return CoC.instance.gameLibrary.findItemType(BEEARMR_ID) as Armor;
		}
		public const BIMBOSK_ID:String = "BimboSk";
		public function get BIMBOSK():Armor {
			return CoC.instance.gameLibrary.findItemType(BIMBOSK_ID) as Armor;
		}
		public const BKIMONO_ID:String = "B.Kimono";
		public function get BKIMONO():Armor {
			return CoC.instance.gameLibrary.findItemType(BKIMONO_ID) as Armor;
		}
		public const BONSTRP_ID:String = "BonStrp";
		public function get BONSTRP():Armor {
			return CoC.instance.gameLibrary.findItemType(BONSTRP_ID) as Armor;
		}
		public const C_CLOTH_ID:String = "C.Cloth";
		public function get C_CLOTH():Armor {
			return CoC.instance.gameLibrary.findItemType(C_CLOTH_ID) as Armor;
		}
		public const CHBIKNI_ID:String = "ChBikni";
		public function get CHBIKNI():Armor {
			return CoC.instance.gameLibrary.findItemType(CHBIKNI_ID) as Armor;
		}
		public const CLSSYCL_ID:String = "ClssyCl";
		public function get CLSSYCL():Armor {
			return CoC.instance.gameLibrary.findItemType(CLSSYCL_ID) as Armor;
		}
		public const CTPALAD_ID:String = "TaurPAr";
		public function get CTPALAD():Armor {
			return CoC.instance.gameLibrary.findItemType(CTPALAD_ID) as Armor;
		}
		public const CTBGUAR_ID:String = "TaurBAr";
		public function get CTBGUAR():Armor {
			return CoC.instance.gameLibrary.findItemType(CTBGUAR_ID) as Armor;
		}
		public const DBARMOR_ID:String = "DB.Armr";
		public function get DBARMOR():Armor {
			return CoC.instance.gameLibrary.findItemType(DBARMOR_ID) as Armor;
		}
		public const DSCLARM_ID:String = "DSclArm";
		public function get DSCLARM():Armor {
			return CoC.instance.gameLibrary.findItemType(DSCLARM_ID) as Armor;
		}
		public const DSCLROB_ID:String = "DSclRob";
		public function get DSCLROB():Armor {
			return CoC.instance.gameLibrary.findItemType(DSCLROB_ID) as Armor;
		}
		public const EHGARB__ID:String = "EH.Garb";
		public function get EHGARB_():Armor {
			return CoC.instance.gameLibrary.findItemType(EHGARB__ID) as Armor;
		}
		public const EWJACK__ID:String = "EWJack";
		public function get EWJACK_():Armor {
			return CoC.instance.gameLibrary.findItemType(EWJACK__ID) as Armor;
		}
		public const EWPLTMA_ID:String = "EWPltMa";
		public function get EWPLTMA():Armor {
			return CoC.instance.gameLibrary.findItemType(EWPLTMA_ID) as Armor;
		}
		public const EWROBE__ID:String = "EWRobe";
		public function get EWROBE_():Armor {
			return CoC.instance.gameLibrary.findItemType(EWROBE__ID) as Armor;
		}
		public const FULLCHN_ID:String = "FullChn";
		public function get FULLCHN():Armor {
			return CoC.instance.gameLibrary.findItemType(FULLCHN_ID) as Armor;
		}
		public const FULLPLT_ID:String = "FullPlt";
		public function get FULLPLT():Armor {
			return CoC.instance.gameLibrary.findItemType(FULLPLT_ID) as Armor;
		}
		public const GELARMR_ID:String = "GelArmr";
		public function get GELARMR():Armor {
			return CoC.instance.gameLibrary.findItemType(GELARMR_ID) as Armor;
		}
		public const GOOARMR:Armor = new GooArmor();
		public const H_GARB__ID:String = "H. Garb";
		public function get H_GARB_():Armor {
			return CoC.instance.gameLibrary.findItemType(H_GARB__ID) as Armor;
		}
		public const I_CORST:Armor = new InquisitorsCorset();
		public const I_ROBES:Armor = new InquisitorsRobes();
		public const INDECST_ID:String = "IndecSt";
		public function get INDECST():Armor {
			return CoC.instance.gameLibrary.findItemType(INDECST_ID) as Armor;
		}
		public const INDEDSR_ID:String = "IndeDSR";
		public function get INDEDSR():Armor {
			return CoC.instance.gameLibrary.findItemType(INDEDSR_ID) as Armor;
		}
		public const INDEEWR_ID:String = "IndeEWR";
		public function get INDEEWR():Armor {
			return CoC.instance.gameLibrary.findItemType(INDEEWR_ID) as Armor;
		}
		public const INDESSR_ID:String = "IndeSSR";
		public function get INDESSR():Armor {
			return CoC.instance.gameLibrary.findItemType(INDESSR_ID) as Armor;
		}
		public const LEATHRA_ID:String = "LeathrA";
		public function get LEATHRA():Armor {
			return CoC.instance.gameLibrary.findItemType(LEATHRA_ID) as Armor;
		}
		public const URTALTA:Armor = new LeatherArmorSegments();
		public const LMARMOR:Armor = new LustyMaidensArmor();
		public const LTHCARM:Armor = new LethiciteArmor();
		public const LTHRPNT_ID:String = "LthrPnt";
		public function get LTHRPNT():Armor {
			return CoC.instance.gameLibrary.findItemType(LTHRPNT_ID) as Armor;
		}
		public const LTHRROB_ID:String = "LthrRob";
		public function get LTHRROB():Armor {
			return CoC.instance.gameLibrary.findItemType(LTHRROB_ID) as Armor;
		}
		public const M_ROBES_ID:String = "M.Robes";
		public function get M_ROBES():Armor {
			return CoC.instance.gameLibrary.findItemType(M_ROBES_ID) as Armor;
		}
		public const NAGASLK:Armor = new NagaSilkDress();
		public const NURSECL_ID:String = "NurseCl";
		public function get NURSECL():Armor {
			return CoC.instance.gameLibrary.findItemType(NURSECL_ID) as Armor;
		}
		public const OVERALL_ID:String = "Overall";
		public function get OVERALL():Armor {
			return CoC.instance.gameLibrary.findItemType(OVERALL_ID) as Armor;
		}
		public const PKIMONO_ID:String = "P.Kimono";
		public function get PKIMONO():Armor {
			return CoC.instance.gameLibrary.findItemType(PKIMONO_ID) as Armor;
		}
		public const R_BDYST_ID:String = "R.BdySt";
		public function get R_BDYST():Armor {
			return CoC.instance.gameLibrary.findItemType(R_BDYST_ID) as Armor;
		}
		public const RBBRCLT_ID:String = "RbbrClt";
		public function get RBBRCLT():Armor {
			return CoC.instance.gameLibrary.findItemType(RBBRCLT_ID) as Armor;
		}
		public const RKIMONO_ID:String = "R.Kimono";
		public function get RKIMONO():Armor {
			return CoC.instance.gameLibrary.findItemType(RKIMONO_ID) as Armor;
		}
		public const S_SWMWR:Armor = new SluttySwimwear();
		public const SAMUARM_ID:String = "SamuArm";
		public function get SAMUARM():Armor {
			return CoC.instance.gameLibrary.findItemType(SAMUARM_ID) as Armor;
		}
		public const SCALEML_ID:String = "ScaleMl";
		public function get SCALEML():Armor {
			return CoC.instance.gameLibrary.findItemType(SCALEML_ID) as Armor;
		}
		public const SEDUCTA:Armor = new SeductiveArmor();
		public const SEDUCTU:Armor = new SeductiveArmorUntrapped();
		public const SS_ROBE_ID:String = "SS.Robe";
		public function get SS_ROBE():Armor {
			return CoC.instance.gameLibrary.findItemType(SS_ROBE_ID) as Armor;
		}
		public const SSARMOR_ID:String = "SSArmor";
		public function get SSARMOR():Armor {
			return CoC.instance.gameLibrary.findItemType(SSARMOR_ID) as Armor;
		}
		public const T_BSUIT_ID:String = "T.BSuit";
		public function get T_BSUIT():Armor {
			return CoC.instance.gameLibrary.findItemType(T_BSUIT_ID) as Armor;
		}
		public const TBARMOR_ID:String = "TB.Armr";
		public function get TBARMOR():Armor {
			return CoC.instance.gameLibrary.findItemType(TBARMOR_ID) as Armor;
		}
		public const TRASARM_ID:String = "TraSArm";
		public function get TRASARM():Armor {
			return CoC.instance.gameLibrary.findItemType(TRASARM_ID) as Armor;
		}
		public const TUBETOP_ID:String = "TubeTop";
		public function get TUBETOP():Armor {
			return CoC.instance.gameLibrary.findItemType(TUBETOP_ID) as Armor;
		}
		public const W_ROBES_ID:String = "W.Robes";
		public function get W_ROBES():Armor {
			return CoC.instance.gameLibrary.findItemType(W_ROBES_ID) as Armor;
		}
		public const WKIMONO_ID:String = "W.Kimono";
		public function get WKIMONO():Armor {
			return CoC.instance.gameLibrary.findItemType(WKIMONO_ID) as Armor;
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
