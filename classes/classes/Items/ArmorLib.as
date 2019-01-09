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
		public const ADVCLTH_ID:String = "AdvClth";
		public function get ADVCLTH():Armor {
			return ItemType.lookupItem(ADVCLTH_ID) as Armor;
		}
		public const A_ROBE__ID:String = "A.Robe";
		public function get A_ROBE_():Armor {
			return ItemType.lookupItem(A_ROBE__ID) as Armor;
		}
		public const ARCBANG_ID:String = "ArcaBangl";
		public function get ARCBANG():Armor {
			return ItemType.lookupItem(ARCBANG_ID) as Armor;
		}
		public const B_DRESS_ID:String = "B.Dress";
		public function get B_DRESS():Armor {
			return ItemType.lookupItem(B_DRESS_ID) as Armor;
		}
		public const BEEARMR:Armor = new BeeArmor();
		public const BIMBOSK_ID:String = "BimboSk";
		public function get BIMBOSK():Armor {
			return ItemType.lookupItem(BIMBOSK_ID) as Armor;
		}
		public const BKIMONO_ID:String = "B.Kimono";
		public function get BKIMONO():Armor {
			return ItemType.lookupItem(BKIMONO_ID) as Armor;
		}
		public const BONSTRP_ID:String = "BonStrp";
		public function get BONSTRP():Armor {
			return ItemType.lookupItem(BONSTRP_ID) as Armor;
		}
		public const C_CLOTH_ID:String = "C.Cloth";
		public function get C_CLOTH():Armor {
			return ItemType.lookupItem(C_CLOTH_ID) as Armor;
		}
		public const CHBIKNI_ID:String = "ChBikni";
		public function get CHBIKNI():Armor {
			return ItemType.lookupItem(CHBIKNI_ID) as Armor;
		}
		public const CLSSYCL_ID:String = "ClssyCl";
		public function get CLSSYCL():Armor {
			return ItemType.lookupItem(CLSSYCL_ID) as Armor;
		}
		public const CTPALAD:Armor = new CentaurArmor();
		public const CTBGUAR:Armor = new CentaurBlackguardArmor();
		public const DBARMOR:Armor = new MaraeArmor(true);
		public const DSCLARM_ID:String = "DSclArm";
		public function get DSCLARM():Armor {
			return ItemType.lookupItem(DSCLARM_ID) as Armor;
		}
		public const DSCLROB_ID:String = "DSclRob";
		public function get DSCLROB():Armor {
			return ItemType.lookupItem(DSCLROB_ID) as Armor;
		}
		public const EHGARB__ID:String = "EH.Garb";
		public function get EHGARB_():Armor {
			return ItemType.lookupItem(EHGARB__ID) as Armor;
		}
		public const EWJACK__ID:String = "EWJack";
		public function get EWJACK_():Armor {
			return ItemType.lookupItem(EWJACK__ID) as Armor;
		}
		public const EWPLTMA_ID:String = "EWPltMa";
		public function get EWPLTMA():Armor {
			return ItemType.lookupItem(EWPLTMA_ID) as Armor;
		}
		public const EWROBE__ID:String = "EWRobe";
		public function get EWROBE_():Armor {
			return ItemType.lookupItem(EWROBE__ID) as Armor;
		}
		public const FULLCHN_ID:String = "FullChn";
		public function get FULLCHN():Armor {
			return ItemType.lookupItem(FULLCHN_ID) as Armor;
		}
		public const FULLPLT_ID:String = "FullPlt";
		public function get FULLPLT():Armor {
			return ItemType.lookupItem(FULLPLT_ID) as Armor;
		}
		public const GELARMR_ID:String = "GelArmr";
		public function get GELARMR():Armor {
			return ItemType.lookupItem(GELARMR_ID) as Armor;
		}
		public const GOOARMR:Armor = new GooArmor();
		public const H_GARB__ID:String = "H. Garb";
		public function get H_GARB_():Armor {
			return ItemType.lookupItem(H_GARB__ID) as Armor;
		}
		public const I_CORST:Armor = new InquisitorsCorset();
		public const I_ROBES:Armor = new InquisitorsRobes();
		public const INDECST_ID:String = "IndecSt";
		public function get INDECST():Armor {
			return ItemType.lookupItem(INDECST_ID) as Armor;
		}
		public const INDEDSR_ID:String = "IndeDSR";
		public function get INDEDSR():Armor {
			return ItemType.lookupItem(INDEDSR_ID) as Armor;
		}
		public const INDEEWR_ID:String = "IndeEWR";
		public function get INDEEWR():Armor {
			return ItemType.lookupItem(INDEEWR_ID) as Armor;
		}
		public const INDESSR_ID:String = "IndeSSR";
		public function get INDESSR():Armor {
			return ItemType.lookupItem(INDESSR_ID) as Armor;
		}
		public const LEATHRA_ID:String = "LeathrA";
		public function get LEATHRA():Armor {
			return ItemType.lookupItem(LEATHRA_ID) as Armor;
		}
		public const URTALTA:Armor = new LeatherArmorSegments();
		public const LMARMOR:Armor = new LustyMaidensArmor();
		public const LTHCARM:Armor = new LethiciteArmor();
		public const LTHRPNT_ID:String = "LthrPnt";
		public function get LTHRPNT():Armor {
			return ItemType.lookupItem(LTHRPNT_ID) as Armor;
		}
		public const LTHRROB_ID:String = "LthrRob";
		public function get LTHRROB():Armor {
			return ItemType.lookupItem(LTHRROB_ID) as Armor;
		}
		public const M_ROBES_ID:String = "M.Robes";
		public function get M_ROBES():Armor {
			return ItemType.lookupItem(M_ROBES_ID) as Armor;
		}
		public const NAGASLK:Armor = new NagaSilkDress();
		public const NURSECL_ID:String = "NurseCl";
		public function get NURSECL():Armor {
			return ItemType.lookupItem(NURSECL_ID) as Armor;
		}
		public const OVERALL_ID:String = "Overall";
		public function get OVERALL():Armor {
			return ItemType.lookupItem(OVERALL_ID) as Armor;
		}
		public const PKIMONO_ID:String = "P.Kimono";
		public function get PKIMONO():Armor {
			return ItemType.lookupItem(PKIMONO_ID) as Armor;
		}
		public const R_BDYST_ID:String = "R.BdySt";
		public function get R_BDYST():Armor {
			return ItemType.lookupItem(R_BDYST_ID) as Armor;
		}
		public const RBBRCLT_ID:String = "RbbrClt";
		public function get RBBRCLT():Armor {
			return ItemType.lookupItem(RBBRCLT_ID) as Armor;
		}
		public const RKIMONO_ID:String = "R.Kimono";
		public function get RKIMONO():Armor {
			return ItemType.lookupItem(RKIMONO_ID) as Armor;
		}
		public const S_SWMWR:Armor = new SluttySwimwear();
		public const SAMUARM_ID:String = "SamuArm";
		public function get SAMUARM():Armor {
			return ItemType.lookupItem(SAMUARM_ID) as Armor;
		}
		public const SCALEML_ID:String = "ScaleMl";
		public function get SCALEML():Armor {
			return ItemType.lookupItem(SCALEML_ID) as Armor;
		}
		public const SEDUCTA:Armor = new SeductiveArmor();
		public const SEDUCTU:Armor = new SeductiveArmorUntrapped();
		public const SS_ROBE_ID:String = "SS.Robe";
		public function get SS_ROBE():Armor {
			return ItemType.lookupItem(SS_ROBE_ID) as Armor;
		}
		public const SSARMOR_ID:String = "SSArmor";
		public function get SSARMOR():Armor {
			return ItemType.lookupItem(SSARMOR_ID) as Armor;
		}
		public const T_BSUIT_ID:String = "T.BSuit";
		public function get T_BSUIT():Armor {
			return ItemType.lookupItem(T_BSUIT_ID) as Armor;
		}
		public const TBARMOR:Armor = new MaraeArmor();
		public const TRASARM_ID:String = "TraSArm";
		public function get TRASARM():Armor {
			return ItemType.lookupItem(TRASARM_ID) as Armor;
		}
		public const TUBETOP_ID:String = "TubeTop";
		public function get TUBETOP():Armor {
			return ItemType.lookupItem(TUBETOP_ID) as Armor;
		}
		public const W_ROBES_ID:String = "W.Robes";
		public function get W_ROBES():Armor {
			return ItemType.lookupItem(W_ROBES_ID) as Armor;
		}
		public const WKIMONO_ID:String = "W.Kimono";
		public function get WKIMONO():Armor {
			return ItemType.lookupItem(WKIMONO_ID) as Armor;
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
