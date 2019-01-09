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
\t\t\t<perk id={$10}>
\t\t\t\t<value1>$11</value1>
\t\t\t\t<value2>$12</value2>
\t\t\t\t<value3>$13</value3>
\t\t\t\t<value4>$14</value4>
\t\t\t</perk>
\t\t</armor>);
  
		 */
		
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
			<subType>Light</subType>
		</armor>);
		public const A_ROBE_:Armor = factory.createArmorType(<armor id="A.Robe">
			<short>A.Robe</short>
			<name>apprentice's robe</name>
			<long>an apprentice's robe</long>
			<defense>1</defense>
			<value>25</value>
			<description>This drab robe lacks adornment, yet retains an air of mysticality. The low quality of the fabric coupled with its mystic air suggests that it is a garment meant for mages in training.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>10</value1>
			</perk>
		</armor>);
		public const ARCBANG:Armor = factory.createArmorType(<armor id="ArcaBangl">
			<short>ArcaneBangles</short>
			<name>arcane bangles</name>
			<long>a set of arcane bangles</long>
			<defense>1</defense>
			<value>150</value>
			<description>Silver bangles to be worn from the wrists and ankles, inscribed with arcane runes.  For some reason, you feel like wearing these with armor or clothes is somehow wrong.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEnduranceAndSluttySeduction.id}>
				<value1>20</value1>
				<value2>5</value2>
			</perk>
		</armor>);
		public const B_DRESS:Armor = factory.createArmorType(<armor id="B.Dress">
			<short>Long Dress</short>
			<name>long ballroom dress patterned with sequins</name>
			<long>a ballroom dress patterned with sequins</long>
			<defense>0</defense>
			<value>40</value>
			<description>A long ballroom dress patterned with sequins.  Perfect for important occasions.</description>
			<subType>${Armor.MEDIUM}</subType>
		</armor>);
		public const BEEARMR:Armor = new BeeArmor();
		public const BIMBOSK:Armor = factory.createArmorType(<armor id="BimboSk">
			<short>BimboSk</short>
			<name>bimbo skirt</name>
			<long>a skirt that looks like it belongs on a bimbo</long>
			<defense>1</defense>
			<value>40</value>
			<description>A tight, cleavage-inducing halter top and an extremely short miniskirt.  The sexual allure of this item is undoubtable.</description>
			<subType>${Armor.LIGHT}</subType>
			<supportsUndergarment>false</supportsUndergarment>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>10</value1>
			</perk>
		</armor>);
		public const BKIMONO:Armor = factory.createArmorType(<armor id="B.Kimono">
			<short>B.Kimono</short>
			<name>blue kimono</name>
			<long>a blue kimono</long>
			<defense>1</defense>
			<value>200</value>
			<description>This lovely blue kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance.id}>
				<value1>20</value1>
				<value2>20</value2>
			</perk>
		</armor>);
		public const BONSTRP:Armor = factory.createArmorType(<armor id="BonStrp">
			<short>BonStrp</short>
			<name>barely-decent bondage straps</name>
			<long>a set of bondage straps</long>
			<defense>0</defense>
			<value>40</value>
			<description>These leather straps and well-placed hooks are actually designed in such a way as to be worn as clothing.  While they technically would cover your naughty bits, virtually every other inch of your body would be exposed.</description>
			<subType>${Armor.LIGHT}</subType>
			<supportsUndergarment>false</supportsUndergarment>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>10</value1>
			</perk>
		</armor>);
		public const C_CLOTH:Armor = factory.createArmorType(<armor id="C.Cloth">
			<short>C.Cloth</short>
			<name>comfortable clothes</name>
			<long>a set of comfortable clothes</long>
			<defense>0</defense>
			<value>1</value>
			<description>These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.</description>
			<subType>Light</subType>
		</armor>);
		public const CHBIKNI:Armor = factory.createArmorType(<armor id="ChBikni">
			<short>Chn Bikini</short>
			<name>revealing chainmail bikini</name>
			<long>a chainmail bikini</long>
			<defense>2</defense>
			<value>80</value>
			<description>A revealing chainmail bikini that barely covers anything.  The bottom half is little more than a triangle of metal and a leather thong.</description>
			<subType>${Armor.LIGHT}</subType>
			<supportsUndergarment>false</supportsUndergarment>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>5</value1>
			</perk>
		</armor>);
		public const CLSSYCL:Armor = factory.createArmorType(<armor id="ClssyCl">
			<short>Suitclothes</short>
			<name>classy suitclothes</name>
			<long>a set of classy suit-clothes</long>
			<defense>1</defense>
			<value>40</value>
			<description>A set of classy suitclothes.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const CTPALAD:Armor = new CentaurArmor();
		public const CTBGUAR:Armor = new CentaurBlackguardArmor();
		public const DBARMOR:Armor = new MaraeArmor(true);
		public const DSCLARM:Armor = factory.createArmorType(<armor id="DSclArm">
			<short>D.Scale Armor</short>
			<name>dragonscale armor</name>
			<long>a suit of dragonscale armor</long>
			<defense>20</defense>
			<value>800</value>
			<description>This armor is cleverly fashioned from dragon scales. It offers high protection while at the same time, quite flexible.</description>
			<subType>${Armor.MEDIUM}</subType>
		</armor>);
		public const DSCLROB:Armor = factory.createArmorType(<armor id="DSclRob">
			<short>D.Scale Robes</short>
			<name>dragonscale robes</name>
			<long>a dragonscale robes</long>
			<defense>10</defense>
			<value>500</value>
			<description>This robe is expertly made from dragon scales. It offers high protection while being lightweight and should be comfortable to wear all day.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>20</value1>
			</perk>
		</armor>);
		public const EHGARB_:Armor = factory.createArmorType(<armor id="EH.Garb">
			<short>E.Heretic‘s Garb</short>
			<name>Ebonweave Heretic‘s Garb</name>
			<long>an Ebonweave Heretic‘s Garb</long>
			<defense>20</defense>
			<value>1600</value>
			<description>This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of arrowproof clothes, covered by a mesh breastplate and leatherlike duster inscribed with glyphs of magic and warding.  A trilby adorned with a moon pin completes the look.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance}>
				<value1>20</value1>
				<value2>20</value2>
			</perk>
		</armor>);
		public const EWJACK_:Armor = factory.createArmorType(<armor id="EWJack">
			<short>E.W. Jacket</short>
			<name>ebonweave jacket</name>
			<long>an ebonweave jacket</long>
			<defense>24</defense>
			<value>960</value>
			<description>This outfit is ebonweave, created using refined ebonbloom petals. The outfit consists of a leatherlike jacket, a mesh breastplate and a set of arrowproof clothing. Between them all, the outfit provide layers of protection rivaling heavier, more traditional armor.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>15</value1>
			</perk>
		</armor>);
		public const EWPLTMA:Armor = factory.createArmorType(<armor id="EWPltMa">
			<short>E.W. Platemail</short>
			<name>ebonweave platemail</name>
			<long>an ebonweave platemail</long>
			<defense>36</defense>
			<value>4320</value>
			<description>The armor is ebonweave, created using refined ebonbloom petals. The armor consists of two layers, an outer layer of ebonweave playing, and an inner layer of arrowproof ebonweave cloth.</description>
			<subType>${Armor.HEAVY}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>15</value1>
			</perk>
		</armor>);
		public const EWROBE_:Armor = factory.createArmorType(<armor id="EWRobe">
			<short>E.W. Robe</short>
			<name>ebonweave robe</name>
			<long>an ebonweave robe</long>
			<defense>12</defense>
			<value>600</value>
			<description>This robe is ebonweave, created using refined ebonbloom petals. This robe is as comfortable as cloth yet more protective than chainmail. The cloth has a mystic aura, helpful when working magic.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>30</value1>
			</perk>
		</armor>);
		public const FULLCHN:Armor = factory.createArmorType(<armor id="FullChn">
			<short>Full Chain</short>
			<name>full-body chainmail</name>
			<long>a full suit of chainmail armor</long>
			<defense>8</defense>
			<value>320</value>
			<description>This full suit of chainmail armor covers its wearer from head to toe in protective steel rings.</description>
			<subType>${Armor.MEDIUM}</subType>
		</armor>);
		public const FULLPLT:Armor = factory.createArmorType(<armor id="FullPlt">
			<short>Full Plate</short>
			<name>full platemail</name>
			<long>a suit of full-plate armor</long>
			<defense>21</defense>
			<value>1260</value>
			<description>A highly protective suit of steel platemail.  It would be hard to find better physical protection than this.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const GELARMR:Armor = factory.createArmorType(<armor id="GelArmr">
			<short>GelArmr</short>
			<name>glistening gel-armor plates</name>
			<long>a suit of gel armor</long>
			<defense>10</defense>
			<value>600</value>
			<description>This suit of interlocking plates is made from a strange green material.  It feels spongy to the touch but is amazingly resiliant.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const GOOARMR:Armor = new GooArmor();
		public const H_GARB_:Armor = factory.createArmorType(<armor id="H. Garb">
			<short>Heretic‘s Garb</short>
			<name>Heretic‘s Garb</name>
			<long>an Heretic‘s Garb</long>
			<defense>6</defense>
			<value>480</value>
			<description>Weathered traveling clothes, covered by a duster.  Wards and arcane glyphs inscribed in the duster facilitates magic while providing significant defense.  A feather tipped trilby completes the look.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance}>
				<value1>10</value1>
				<value2>10</value2>
			</perk>
		</armor>);
		public const I_CORST:Armor = new InquisitorsCorset();
		public const I_ROBES:Armor = new InquisitorsRobes();
		public const INDECST:Armor = factory.createArmorType(<armor id="IndecSt">
			<short>Indec StAr</short>
			<name>practically indecent steel armor</name>
			<long>a suit of practically indecent steel armor</long>
			<defense>5</defense>
			<value>400</value>
			<description>This suit of steel 'armor' has two round disks that barely cover the nipples, a tight chainmail bikini, and circular butt-plates.</description>
			<subType>${Armor.MEDIUM}</subType>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>6</value1>
			</perk>
		</armor>);
		public const INDEDSR:Armor = factory.createArmorType(<armor id="IndeDSR">
			<short>Indec D.Scale Robe</short>
			<name>indecent dragonscale robe</name>
			<long>an indecent dragonscale robe</long>
			<defense>4</defense>
			<value>400</value>
			<description>More of a longcoat than a robe, this outfit is crafted from dragon scales. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The dragonscale is treated to be durable yet remain comfortable.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEnduranceAndSluttySeduction.id}>
				<value1>15</value1>
				<value2>5</value2>
			</perk>
		</armor>);
		public const INDEEWR:Armor = factory.createArmorType(<armor id="IndeEWR">
			<short>Indec. E.W. Robe</short>
			<name>indecent ebonweave robe</name>
			<long>an indecent ebonweave robe</long>
			<defense>6</defense>
			<value>600</value>
			<description>More of a longcoat than a robe, this outfit is crafted from refined ebonbloom petals. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have. The cloth has a mystic aura, helpful when working magic.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEnduranceAndSluttySeduction.id}>
				<value1>20</value1>
				<value2>5</value2>
			</perk>
		</armor>);
		public const INDESSR:Armor = factory.createArmorType(<armor id="IndeSSR">
			<short>Indec S.S. Robe</short>
			<name>indecent spider silk robe</name>
			<long>an indecent spider silk robe</long>
			<defense>2</defense>
			<value>200</value>
			<description>More of a longcoat than a robe, this outfit is crafted from alchemically treated spider silk. Discrete straps centered around the belt keep the front perpetually open, displaying your groin and any cleavage you might have.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEnduranceAndSluttySeduction.id}>
				<value1>15</value1>
				<value2>5</value2>
			</perk>
		</armor>);
		public const LEATHRA:Armor = factory.createArmorType(<armor id="LeathrA">
			<short>LeathrA</short>
			<name>leather armor segments</name>
			<long>a set of leather armor</long>
			<defense>5</defense>
			<value>100</value>
			<description>This is a suit of well-made leather armor.  It looks fairly rugged.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const URTALTA:Armor = new LeatherArmorSegments();
		public const LMARMOR:Armor = new LustyMaidensArmor();
		public const LTHCARM:Armor = new LethiciteArmor();
		public const LTHRPNT:Armor = factory.createArmorType(<armor id="LthrPnt">
			<short>T.Lthr Pants</short>
			<name>white silk shirt and tight leather pants</name>
			<long>a pair of leather pants and a white silk shirt</long>
			<defense>0</defense>
			<value>20</value>
			<description>A flowing silk shirt and tight black leather pants.  Suave!</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const LTHRROB:Armor = factory.createArmorType(<armor id="LthrRob">
			<short>Lthr Robes</short>
			<name>black leather armor surrounded by voluminous robes</name>
			<long>a suit of black leather armor with voluminous robes</long>
			<defense>6</defense>
			<value>150</value>
			<description>This is a suit of flexible leather armor with a voluminous set of concealing black robes.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const M_ROBES:Armor = factory.createArmorType(<armor id="M.Robes">
			<short>Robes</short>
			<name>modest robes</name>
			<long>a set of modest robes</long>
			<defense>0</defense>
			<value>25</value>
			<description>A set of modest robes, not dissimilar from what the monks back home would wear.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const NAGASLK:Armor = new NagaSilkDress();
		public const NURSECL:Armor = factory.createArmorType(<armor id="NurseCl">
			<short>NurseCl</short>
			<name>skimpy nurse's outfit</name>
			<long>a nurse's outfit</long>
			<defense>0</defense>
			<value>100</value>
			<description>This borderline obscene nurse's outfit would barely cover your hips and crotch.  The midriff is totally exposed, and the white top leaves plenty of room for cleavage.  A tiny white hat tops off the whole ensemble.  It would grant a small regeneration to your HP.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>8</value1>
			</perk>
		</armor>);
		public const OVERALL:Armor = factory.createArmorType(<armor id="Overall">
			<short>Overalls</short>
			<name>white shirt and overalls</name>
			<long>a white shirt and overalls</long>
			<defense>0</defense>
			<value>25</value>
			<description>A simple white shirt and overalls.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const PKIMONO:Armor = factory.createArmorType(<armor id="P.Kimono">
			<short>P.Kimono</short>
			<name>purple kimono</name>
			<long>a purple kimono</long>
			<defense>1</defense>
			<value>200</value>
			<description>This lovely purple kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance.id}>
				<value1>20</value1>
				<value2>20</value2>
			</perk>
		</armor>);
		public const R_BDYST:Armor = factory.createArmorType(<armor id="R.BdySt">
			<short>R.BdySt</short>
			<name>red, high-society bodysuit</name>
			<long>a red bodysuit for high society</long>
			<defense>1</defense>
			<value>50</value>
			<description>A high society bodysuit. It is as easy to mistake it for ballroom apparel as it is for boudoir lingerie. The thin transparent fabric is so light and airy that it makes avoiding blows a second nature.</description>
			<subType>${Armor.LIGHT}</subType>
			<supportsUndergarment>false</supportsUndergarment>
		</armor>);
		public const RBBRCLT:Armor = factory.createArmorType(<armor id="RbbrClt">
			<short>Rbbr Fetish</short>
			<name>rubber fetish clothes</name>
			<long>a set of revealing rubber fetish clothes</long>
			<defense>3</defense>
			<value>150</value>
			<description>A revealing set of fetish-wear.  Upgrades your tease attack with the "Slutty Seduction" perk.</description>
			<subType>${Armor.LIGHT}</subType>
			<supportsUndergarment>false</supportsUndergarment>
			<perk id={PerkLib.SluttySeduction}>
				<value1>8</value1>
			</perk>
		</armor>);
		public const RKIMONO:Armor = factory.createArmorType(<armor id="R.Kimono">
			<short>R.Kimono</short>
			<name>red kimono</name>
			<long>a red kimono</long>
			<defense>1</defense>
			<value>200</value>
			<description>This lovely red kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance.id}>
				<value1>20</value1>
				<value2>20</value2>
			</perk>
		</armor>);
		public const S_SWMWR:Armor = new SluttySwimwear();
		public const SAMUARM:Armor = factory.createArmorType(<armor id="SamuArm">
			<short>Samu.Armor</short>
			<name>samurai armor</name>
			<long>a suit of samurai armor</long>
			<defense>18</defense>
			<value>300</value>
			<description>This suit of armor is originally worn by the Samurai, the warriors from the far East.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const SCALEML:Armor = factory.createArmorType(<armor id="ScaleMl">
			<short>Scale Mail</short>
			<name>scale-mail armor</name>
			<long>a set of scale-mail armor</long>
			<defense>12</defense>
			<value>720</value>
			<description>This suit of scale-mail covers the entire body with layered steel scales, providing flexibility and protection.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const SEDUCTA:Armor = new SeductiveArmor();
		public const SEDUCTU:Armor = new SeductiveArmorUntrapped();
		public const SS_ROBE:Armor = factory.createArmorType(<armor id="SS.Robe">
			<short>SS.Robes</short>
			<name>spider-silk robes</name>
			<long>a spider-silk robes</long>
			<defense>6</defense>
			<value>300</value>
			<description>This robe looks incredibly comfortable.  It's made from alchemically enhanced spider-silk, and embroidered with what looks like magical glyphs around the sleeves and hood.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>30</value1>
			</perk>
		</armor>);
		public const SSARMOR:Armor = factory.createArmorType(<armor id="SSArmor">
			<short>SS.Armor</short>
			<name>spider-silk armor</name>
			<long>a suit of spider-silk armor</long>
			<defense>25</defense>
			<value>1500</value>
			<description>This armor is as white as the driven snow.  It's crafted out of thousands of strands of spider-silk into an impenetrable protective suit.  The surface is slightly spongy, but so tough you wager most blows would bounce right off.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const T_BSUIT:Armor = factory.createArmorType(<armor id="T.BSuit">
			<short>Bodysuit</short>
			<name>semi-transparent bodysuit</name>
			<long>a semi-transparent, curve-hugging bodysuit</long>
			<defense>0</defense>
			<value>50</value>
			<description>A semi-transparent bodysuit. It looks like it will cling to all the curves of your body.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.SluttySeduction.id}>
				<value1>7</value1>
			</perk>
		</armor>);
		public const TBARMOR:Armor = new MaraeArmor();
		public const TRASARM:Armor = factory.createArmorType(<armor id="TraSArm">
			<short>TraSArmor</short>
			<name>training soul armor</name>
			<long>a training soul armor</long>
			<defense>1</defense>
			<value>120</value>
			<description>This set of heavy armor is made using soulmetal but it main purpose is to allow user train ki to the uttermost limit for novice soul cultivator.</description>
			<subType>${Armor.HEAVY}</subType>
		</armor>);
		public const TUBETOP:Armor = factory.createArmorType(<armor id="TubeTop">
			<short>Tube Top</short>
			<name>tube top and short shorts</name>
			<long>a snug tube top and VERY short shorts</long>
			<defense>0</defense>
			<value>25</value>
			<description>A clingy tube top and VERY short shorts.</description>
			<subType>${Armor.LIGHT}</subType>
		</armor>);
		public const W_ROBES:Armor = factory.createArmorType(<armor id="W.Robes">
			<short>W.Robes</short>
			<name>wizard's robes</name>
			<long>a wizard's robes</long>
			<defense>1</defense>
			<value>50</value>
			<description>These robes appear to have once belonged to a female wizard.  They're long with a slit up the side and full billowing sleeves.  The top is surprisingly low cut.  Somehow you know wearing it would aid your spellcasting.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsEndurance.id}>
				<value1>25</value1>
			</perk>
		</armor>);
		public const WKIMONO:Armor = factory.createArmorType(<armor id="W.Kimono">
			<short>W.Kimono</short>
			<name>white kimono</name>
			<long>a white kimono</long>
			<defense>1</defense>
			<value>200</value>
			<description>This lovely white kimono is adorned with a floral pattern. It will likely increase your spiritual power as a kitsune.</description>
			<subType>${Armor.LIGHT}</subType>
			<perk id={PerkLib.WizardsAndDaoistsEndurance.id}>
				<value1>20</value1>
				<value2>20</value2>
			</perk>
		</armor>);
		public const FRSGOWN:Armor = new Gown();

		public function ArmorLib()
		{
			for each (var e:* in Utils.objectMemberValues(this,"constant")) {
				if (e is ItemType) (e as ItemType).register();
			}
		}
	}
}
