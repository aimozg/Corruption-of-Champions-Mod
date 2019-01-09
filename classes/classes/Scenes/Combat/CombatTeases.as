package classes.Scenes.Combat {
	import classes.*;
	import classes.BodyParts.Skin;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.*;
	import classes.Items.*;
	import classes.Scenes.Dungeons.D3.*;
	import classes.Scenes.Places.TelAdre.UmasShop;
	import classes.Scenes.SceneLib;
	import classes.lists.Gender;

	public class CombatTeases extends BaseCombatContent {
	public function CombatTeases() {}

	public function teaseAttack():void {
		clearOutput();
		if (monster.lustVuln == 0) {
			outputText("You try to tease [monster a][monster name] with your body, but it doesn't have any effect on [monster him].\n\n");
		}
		//Worms are immune!
		else if (monster.short == "worms") {
			outputText("Thinking to take advantage of its humanoid form, you wave your cock and slap your ass in a rather lewd manner. However, the creature fails to react to your suggestive actions.\n\n");
		}
		else {
			tease();
		}
		afterPlayerAction();
	}

	// Just text should force the function to purely emit the test text to the output display, and not have any other side effects
	public function tease(justText:Boolean = false):void {
		var choices:Array   = [];
		function addChoice(choice:int, weight:int):void {
			for(var i:int = weight; i > 0; i--){
				choices.push(choice);
			}
		}
		function statWeight(stat:Number, ...rest):int{
			return rest.filter(function(element:*, index:int, arr:Array):Boolean {
				return element >= stat;
			}).length;
		}
		if (!justText) clearOutput();
		//You cant tease a blind guy!
		if (monster.hasStatusEffect(StatusEffects.Blind) || monster.hasStatusEffect(StatusEffects.InkBlind)) {
			outputText("You do your best to tease [monster a][monster name] with your body.  It doesn't work - you blinded [monster him], remember?\n\n");
			return;
		}
		if (player.hasStatusEffect(StatusEffects.Sealed) && player.statusEffectv2(StatusEffects.Sealed) == 1) {
			outputText("You do your best to tease [monster a][monster name] with your body.  Your artless twirls have no effect, as <b>your ability to tease is sealed.</b>\n\n");
			return;
		}
		if (monster.short == "Sirius, a naga hypnotist") {
			outputText("He is too focused on your eyes to pay any attention to your teasing moves, <b>looks like you'll have to beat him up.</b>\n\n");
			return;
		}
		combat.fatigueRecovery();
		if (monster.lustVuln == 0) {
			outputText("You do your best to tease [monster a][monster name] with your body but it has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			afterPlayerAction();
			return;
		}
		var damage:Number;
		var chance:Number;
		var bimbo:Boolean   = player.hasPerk(PerkLib.BimboBody);
		var bro:Boolean     = player.hasPerk(PerkLib.BroBody);
		var futa:Boolean    = player.hasPerk(PerkLib.FutaForm);
		var select:Number;
		//Tags used for bonus damage and chance later on
		var breasts:Boolean = false;
		var penis:Boolean   = false;
		var balls:Boolean   = false;
		var vagina:Boolean  = false;
		var anus:Boolean    = false;
		var ass:Boolean     = false;
		//If auto = true, set up bonuses using above flags
		var auto:Boolean    = true;
		//==============================
		//Determine basic success chance.
		//==============================
		chance = 60;
		//1% chance for each tease level.
		chance += player.teaseLevel;
		//Extra chance for sexy undergarments.
		chance += player.upperGarment.sexiness;
		chance += player.lowerGarment.sexiness;
		//10% for seduction perk
		if (player.hasPerk(PerkLib.Seduction)) chance += 10;
		//10% for sexy armor types
		if (player.hasPerk(PerkLib.SluttySeduction)) {
			chance += 10;
		}
		//10% for bimbo shits
		if (bimbo)  {chance += 10;}
		if (bro)    {chance += 10;}
		if (futa)   {chance += 10;}
		//2 & 2 for seductive valentines!
		if (player.hasPerk(PerkLib.SensualLover)) {
			chance += 2;
		}
		if (player.hasPerk(PerkLib.ChiReflowLust)) chance += UmasShop.NEEDLEWORK_LUST_TEASE_MULTI;
		//==============================
		//Determine basic damage.
		//==============================
		damage = 6 + rand(3);
		if (player.hasPerk(PerkLib.SensualLover)) {
			damage += 2;
		}
		if (player.hasPerk(PerkLib.Seduction)) damage += 5;
		//+ slutty armor bonus
		damage += player.perkv1(PerkLib.SluttySeduction);
		//10% for bimbo shits
		if (bimbo || bro || futa) {
			damage += 5;
			bimbo = true;
		}
		damage += scalingBonusLibido() * 0.1;
		if (player.hasPerk(PerkLib.JobSeducer)) {
			damage += player.teaseLevel * 3;
		} else {
			damage += player.teaseLevel * 2;
		}
		if (player.hasPerk(PerkLib.JobCourtesan) && monster.hasPerk(PerkLib.EnemyBossType)) {
			damage *= 1.2;
		}
		//partial skins bonuses
		switch (player.coatType()) {
			case Skin.FUR:
				damage += 1;
				break;
			case Skin.SCALES:
				damage += 2;
				break;
			case Skin.CHITIN:
				damage += 3;
				break;
			case Skin.BARK:
				damage += 4;
				break;
		}
		//slutty simplicity bonus
		if (player.hasPerk(PerkLib.SluttySimplicity) && player.armorName == "nothing") {
			damage *= (1 + ((10 + rand(11)) / 100));
		}
		damage = Math.round(damage);
		//==============================
		//TEASE SELECT CHOICES
		//==BASICS========
		//0 butt shake
		//1 breast jiggle
		//2 pussy flash
		//3 cock flash
		//==BIMBO STUFF===
		//4 butt shake
		//5 breast jiggle
		//6 pussy flash
		//7 special Adjatha-crafted bend over bimbo times
		//==BRO STUFF=====
		//8 Pec Dance
		//9 Heroic Pose
		//10 Bulgy groin thrust
		//11 Show off dick
		//==EXTRAS========
		//12 Cat flexibility.
		//13 Pregnant
		//14 Brood Mother
		//15 Nipplecunts
		//16 Anal gape
		//17 Bee abdomen tease
		//18 DOG TEASE
		//19 Maximum Femininity:
		//20 Maximum MAN:
		//21 Perfect Androgyny:
		//22 SPOIDAH SILK
		//23 RUT
		//24 Poledance - req's staff! - Req's gender!  Req's TITS!
		//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
		//26 SMART PEEPS! 70+ int, arouse spell!
		//27 - FEEDER
		//28 FEMALE TEACHER COSTUME TEASE
		//29 Male Teacher Outfit Tease
		//30 Naga Fetish Clothes
		//31 Centaur harness clothes
		//32 Genderless servant clothes
		//33 Crotch Revealing Clothes (herm only?)
		//34 Maid Costume (female only):
		//35 Servant Boy Clothes (male only)
		//36 Bondage Patient Clothes
		//37 Kitsune Tease
		//38 Kitsune Tease
		//39 Kitsune Tease
		//40 Kitsune Tease
		//41 Kitsune Gendered Tease
		//42 Urta teases
		//43 Cowgirl teases
		//44 Bikini Mail Tease
		//45 Lethicite Armor Tease
		//46 Alraune Tease
		//47 Manticore Tailpussy Tease
		//==============================
		//BUILD UP LIST OF TEASE CHOICES!
		//==============================
		//Futas!
		if ((futa || bimbo) && player.gender == Gender.GENDER_HERM) {
			//Once chance of butt.
			//Big butts get more butt
			addChoice(4, 1 + statWeight(player.butt.type, 7, 10, 14, 20, 25));
			//Breast jiggle!
			addChoice(5, statWeight(player.biggestTitSize(), 2, 4, 8, 15, 30, 50, 75, 100));
			//Pussy Flash!
			if (player.hasVagina()) {
				addChoice(6, 1 + statWeight(player.wetness(), 3, 5) + statWeight(player.vaginalCapacity(), 30, 60, 75));
			}
			//Adj special!
			if (player.hasVagina() && player.butt.type >= 8 && player.hips.type >= 6 && player.biggestTitSize() >= 4) {
				addChoice(7, 4);
			}
			//Cock flash!
			if (futa && player.hasCock()) {
				addChoice(10, 1 + statWeight(player.biggestCockArea(), 10, 75, 300) + statWeight(player.cockTotal(), 2));
				addChoice(11, 1 + statWeight(player.biggestCockArea(), 25, 50, 100) + statWeight(player.cockTotal(), 2));
			}
		}
		else if (bro) {
			//8 Pec Dance
			if (player.biggestTitSize() < 1 && player.tone >= 60) {
				addChoice(8, 1 + statWeight(player.tone, 70, 80, 90, 100));
			}
			//9 Heroic Pose
			if (player.tone >= 60 && player.str >= 50) {
				addChoice(9, 1 + statWeight(player.tone, 80, 90) + statWeight(player.str, 70, 80));
			}
			//Cock flash!
			if (player.hasCock()) {
				addChoice(10, 1 + statWeight(player.biggestCockArea(), 10, 75, 300) + statWeight(player.cockTotal(), 2));
				addChoice(11, 1 + statWeight(player.biggestCockArea(), 25, 50, 100) + statWeight(player.cockTotal(), 2));
			}
		}
		//VANILLA FOLKS
		else {
			//Once chance of butt.
			//Big butts get more butt
			addChoice(0, 1 + statWeight(player.butt.type, 7, 10, 14, 20, 25));
			//Breast jiggle!
			addChoice(1, statWeight(player.biggestTitSize(), 2, 4, 8, 15, 30, 50, 75, 100));
			//Pussy Flash!
			if (player.hasVagina()) {
				addChoice(2, 1 + statWeight(player.wetness(), 3, 5) + statWeight(player.vaginalCapacity(), 30, 60, 75));
			}
			//Cock flash!
			if (player.hasCock()) {
				addChoice(3, 1 + statWeight(player.cockTotal(), 1, 2) + statWeight(player.biggestCockArea(), 10, 25, 50, 75, 100, 300));
			}
		}
		//==EXTRAS========
		//12 Cat flexibility.
		if (player.hasPerk(PerkLib.Flexibility) && player.isBiped() && player.hasVagina()) {
			addChoice(12, 2 + statWeight(player.wetness(), 3, 5) + statWeight(player.vaginalCapacity(), 30));
		}
		//13 Pregnant
		if (player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 0) {
			var weight:int  = 1;
			if (player.biggestLactation() >= 1) weight++;
			for each (var size:int in [180, 120, 100, 50]){
				if(player.pregnancyIncubation <= size){weight++;}
			}
			if (player.pregnancyIncubation <= 24) weight += 4;
			addChoice(13, weight);
		}
		//14 Brood Mother
		if (monster.hasCock() && player.hasVagina() && player.hasPerk(PerkLib.BroodMother) && (player.pregnancyIncubation <= 0 || player.pregnancyIncubation > 216)) {
			addChoice(14, player.inHeat ? 10 : 3);
		}
		//15 Nipplecunts
		if (player.hasFuckableNipples()) {
			weight = 2;
			weight += statWeight(player.wetness(), 3, 5);
			if (player.hasVagina()) weight += 3;
			if (player.biggestTitSize() >= 3) weight++;
			if (player.nippleLength >= 3) weight++;
			addChoice(15, weight);
		}
		//16 Anal gape
		if (player.ass.analLooseness >= 4) {
			choices[choices.length] = 16;
			if (player.ass.analLooseness >= 5) choices[choices.length] = 16;
		}
		//17 Bee abdomen tease
		if (player.tailType == Tail.BEE_ABDOMEN) {
			addChoice(17, 2);
		}
		//18 DOG TEASE
		if (player.dogScore() >= 4 && player.hasVagina() && player.isBiped()) {
			addChoice(18, 2);
		}
		//19 Maximum Femininity:
		if (player.femininity >= 100) {
			addChoice(19, 3);
		}
		//20 Maximum MAN:
		if (player.femininity <= 0) {
			addChoice(20, 3);
		}
		//21 Perfect Androgyny:
		if (player.femininity == 50) {
			addChoice(21, 3);
		}
		//22 SPOIDAH SILK
		if (player.tailType == Tail.SPIDER_ADBOMEN) {
			addChoice(22, player.spiderScore() >= 4 ? 6 : 3);
		}
		//23 RUT
		if (player.inRut && monster.hasVagina() && player.hasCock()) {
			addChoice(23, 5);
		}
		//24 Poledance - req's staff! - Req's gender!  Req's TITS!
		if (player.weapon == weapons.W_STAFF && player.biggestTitSize() >= 1 && player.gender > 0) {
			addChoice(24, 5);
		}
		//25 Tall Tease! - Reqs 2+ feet & PC Cunt!
		if (player.tallness - monster.tallness >= 24 && player.biggestTitSize() >= 4) {
			addChoice(25, 5);
		}
		//26 SMART PEEPS! 70+ int, arouse spell!
		if (player.inte >= 70 && player.hasStatusEffect(StatusEffects.KnowsArouse)) {
			addChoice(26, 3);
		}
		//27 FEEDER
		if (player.hasPerk(PerkLib.Feeder) && player.biggestTitSize() >= 4) {
			addChoice(27, 3 + statWeight(player.biggestTitSize(), 10, 15, 25, 40, 60, 80));
		}
		//28 FEMALE TEACHER COSTUME TEASE
		if (player.armorName == "backless female teacher's clothes" && player.gender == Gender.GENDER_FEMALE) {
			addChoice(28, 4);
		}
		//29 Male Teacher Outfit Tease
		if (player.armorName == "formal vest, tie, and crotchless pants" && player.gender == Gender.GENDER_MALE) {
			addChoice(29, 4);
		}
		//30 Naga Fetish Clothes
		if (player.armorName == "headdress, necklaces, and many body-chains") {
			addChoice(30, 4);
		}
		//31 Centaur harness clothes
		if (player.armorName == "bridle bit and saddle set") {
			addChoice(31, 4);
		}
		//32 Genderless servant clothes
		if (player.armorName == "servant's clothes" && player.gender == Gender.GENDER_NONE) {
			addChoice(32, 4);
		}
		//33 Crotch Revealing Clothes (herm only?)
		if (player.armorName == "crotch-revealing clothes" && player.gender == Gender.GENDER_HERM) {
			addChoice(33, 4);
		}
		//34 Maid Costume (female only):
		if (player.armorName == "maid's clothes" && player.hasVagina()) {
			addChoice(34, 4);
		}
		//35 Servant Boy Clothes (male only)
		if (player.armorName == "cute servant's clothes" && player.hasCock()) {
			addChoice(35, 4);
		}
		//36 Bondage Patient Clothes
		if (player.armorName == "bondage patient clothes") {
			addChoice(36, 4);
		}
		//37 Kitsune Tease
		//38 Kitsune Tease
		//39 Kitsune Tease
		//40 Kitsune Tease
		//41 Kitsune Gendered Tease
		if (player.kitsuneScore() >= 2 && player.tailType == Tail.FOX) {
			addChoice(37, 4);
			addChoice(38, 4);
			addChoice(39, 4);
			addChoice(40, 4);
			addChoice(41, 4);
		}
		//42 Urta teases!
		if (SceneLib.urtaQuest.isUrta()) {
			addChoice(42, 9);
		}
		//43 - special mino + cowgirls
		if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == Tail.COW) {
			addChoice(43, 9);
		}
		//44 - Bikini Mail Teases!
		if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") {
			addChoice(44, 15);
		}
		//45 - Lethicite armor
		if (player.armor == armors.LTHCARM && player.upperGarment == UndergarmentLib.NOTHING && player.lowerGarment == UndergarmentLib.NOTHING) {
			addChoice(45, 6);
		}
		//46 - Alraune Tease
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			addChoice(46, 4);
		}
		//47 - Manticore Tailpussy Tease
		if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
			addChoice(47, 4);
		}
		//=======================================================
		//    CHOOSE YOUR TEASE AND DISPLAY IT!
		//=======================================================
		select = choices[rand(choices.length)];
		if (monster.short.indexOf("minotaur") != -1) {
			if (player.hasVagina() && player.lactationQ() >= 500 && player.biggestTitSize() >= 6 && player.cowScore() >= 3 && player.tailType == Tail.COW)
				select = 43;
		}
		if (player.hasStatusEffect(StatusEffects.AlrauneEntangle)) {
			select = 46;
		}
		//Lets do zis!
		switch (select) {
				//0 butt shake
			case 0:
				//Display
				outputText("You slap your [butt]");
				if (player.butt.type >= 10 && player.tone < 60) outputText(", making it jiggle delightfully.");
				else outputText(".");
				//Mod success
				ass = true;
				break;
				//1 BREAST JIGGLIN'
			case 1:
				//Single breast row
				if (player.breastRows.length == 1) {
					//50+ breastsize% success rate
					outputText("Your lift your top, exposing your [breasts] to [monster a][monster name].  You shake them from side to side enticingly.");
					if (player.lust >= (player.maxLust() * 0.5)) outputText("  Your [nipples] seem to demand [monster his] attention.");
				}
				//Multirow
				if (player.breastRows.length > 1) {
					//50 + 10% per breastRow + breastSize%
					outputText("You lift your top, freeing your rows of [breasts] to jiggle freely.  You shake them from side to side enticingly");
					if (player.lust >= (player.maxLust() * 0.5)) outputText(", your [nipples] painfully visible.");
					else outputText(".");
					chance++;
				}
				breasts = true;
				break;
				//2 PUSSAH FLASHIN'
			case 2:
				if (player.isTaur()) {
					outputText("You gallop toward your unsuspecting enemy, dodging their defenses and knocking them to the ground.  Before they can recover, you slam your massive centaur ass down upon them, stopping just short of using crushing force to pin them underneath you.  In this position, your opponent's face is buried right in your girthy horsecunt.  You grind your cunt into [monster his] face for a moment before standing.  When you do, you're gratified to see your enemy covered in your lubricant and smelling powerfully of horsecunt.");
					chance += 2;
					damage += 4;
				}
				else {
					outputText("You open your [armor], revealing your [if(hasCock)[cocks] and ][vagina].");
					if (player.hasCock()) {
						chance++;
						damage++;
						if (player.hasPerk(PerkLib.BulgeArmor)) {
							damage += 5;
						}
						penis = true;
					}
				}
				vagina = true;
				break;
				//3 cock flash
			case 3:
				if (player.isTaur() && player.horseCocks() > 0) {
					outputText("You let out a bestial whinny and stomp your hooves at your enemy.  They prepare for an attack, but instead you kick your front hooves off the ground, revealing the hefty horsecock hanging beneath your belly.  You let it flop around, quickly getting rigid and to its full erect length.  You buck your hips as if you were fucking a mare in heat, letting your opponent know just what's in store for them if they surrender to pleasure...");
					if (player.hasPerk(PerkLib.BulgeArmor)) damage += 5;
				}
				else {
					outputText("You open your [armor], revealing your [cocks][if(hasVagina) and [vagina]].");
					vagina = player.hasVagina();
					//Bulgy bonus!
					if (player.hasPerk(PerkLib.BulgeArmor)) {
						damage += 5;
						chance++;
					}
				}
				penis = true;
				break;
				//BIMBO
				//4 butt shake
			case 4:
				outputText("You turn away and bounce your [butt] up and down hypnotically");
				//Big butts = extra text + higher success
				if (player.butt.type >= 10) {
					outputText(", making it jiggle delightfully. [monster A][monster name] even gets a few glimpses of the [asshole] between your cheeks.");
					chance += 3;
				}
				//Small butts = less damage, still high success
				else {
					outputText(", letting [monster a][monster name] get a good look at your [asshole] and [vagina].");
					chance += 1;
					vagina = true;
				}
				ass  = true;
				anus = true;
				break;
				//5 breast jiggle
			case 5:
				outputText("You lean forward, letting the well-rounded curves of your [allbreasts] show to [monster a][monster name].");
				outputText("  You cup them in your palms and lewdly bounce them, putting on a show and giggling the entire time.  An inch at a time, your [armor] starts to come down, dropping tantalizingly slowly until your [nipples] pop free.");
				if (player.lust >= (player.maxLust() * 0.5)) {
					if (player.hasFuckableNipples()) {
						chance++;
						outputText("  Clear slime leaks from them, making it quite clear that they're more than just nipples.");
					}
					else outputText("  Your hard nipples seem to demand [monster his] attention.");
					chance += 1;
					damage += 2;
				}
				//Damage boosts!
				breasts = true;
				break;
				//6 pussy flash
			case 6:
				if (player.hasPerk(PerkLib.BimboBrains) || player.hasPerk(PerkLib.FutaFaculties)) {
					outputText("You coyly open your [armor] and giggle, [say: Is this, like, what you wanted to see?]  ");
				}
				else {
					outputText("You coyly open your [armor] and purr, \"<i>Does the thought of a hot, ");
					if (futa) outputText("futanari ");
					else if (player.hasPerk(PerkLib.BimboBody)) outputText("bimbo ");
					else outputText("sexy ");
					outputText("body turn you on?</i>\"  ");
				}
				if (monster.plural) outputText("[monster A][monster name]' gazes are riveted on your groin as you run your fingers up and down your folds seductively.");
				else outputText("[monster A][monster name]'s gaze is riveted on your groin as you run your fingers up and down your folds seductively.");
				if (player.clitLength > 3) outputText("  You smile as your [clit] swells out from the folds and stands proudly, begging to be touched.");
				else outputText("  You smile and pull apart your lower-lips to expose your [clit], giving the perfect view.");
				if (player.cockTotal() > 0) outputText("  Meanwhile, [eachcock] bobs back and forth with your gyrating hips, adding to the display.");
				//BONUSES!
				if (player.hasCock()) {
					if (player.hasPerk(PerkLib.BulgeArmor)) damage += 5;
					penis = true;
				}
				vagina = true;
				break;
				//7 special Adjatha-crafted bend over bimbo times
			case 7:
				outputText("The glinting of light catches your eye and you whip around to inspect the glittering object, turning your back on [monster a][monster name].  Locking your knees, you bend waaaaay over, [chest] swinging in the open air while your [butt] juts out at the [monster a][monster name].  Your plump cheeks and [hips] form a jiggling heart-shape as you eagerly rub your thighs together.\n\n");
				outputText("The clear, warm fluid of your happy excitement trickles down from your loins, polishing your [skin] to a glossy, inviting shine.  Retrieving the useless, though shiny, bauble, you hold your pose for just a moment longer, a sly little smile playing across your lips as you wiggle your cheeks one more time before straightening up and turning back around.");
				vagina = true;
				chance++;
				damage += 2;
				break;
				//==BRO STUFF=====
				//8 Pec Dance
			case 8:
				outputText("You place your hands on your hips and flex repeatedly, skillfully making your pecs alternatively bounce in a muscular dance.  ");
				if (player.hasPerk(PerkLib.BroBrains)) outputText("Damn, [monster a][monster name] has got to love this!");
				else outputText("[monster A][monster name] will probably enjoy the show, but you feel a bit silly doing this.");
				chance += (player.tone - 75) / 5;
				damage += (player.tone - 70) / 5;
				auto = false;
				break;
				//9 Heroic Pose
			case 9:
				outputText("You lift your arms and flex your incredibly muscular arms while flashing your most disarming smile.  ");
				if (player.hasPerk(PerkLib.BroBrains)) outputText("[monster A][monster name] can't resist such a heroic pose!");
				else outputText("At least the physical changes to your body are proving useful!");
				chance += (player.tone - 75) / 5;
				damage += (player.tone - 70) / 5;
				auto = false;
				break;
				//10 Bulgy groin thrust
			case 10:
				outputText("You lean back and pump your hips at [monster a][monster name] in an incredibly vulgar display.  The bulging, barely-contained outline of your [cock] presses hard into your gear.  ");
				if (player.hasPerk(PerkLib.BroBrains)) outputText("No way could [monster he] resist your huge cock!");
				else outputText("This is so crude, but at the same time, you know it'll likely be effective.");
				outputText("  You go on like that, humping the air for your foe's benefit, trying to entice them with your man-meat.");
				if (player.hasPerk(PerkLib.BulgeArmor)) damage += 5;
				penis = true;
				break;
				//11 Show off dick
			case 11:
				if (silly() && rand(2) == 0) outputText("You strike a herculean pose and flex, whispering, [say: Do you even lift?] to [monster a][monster name].");
				else {
					outputText("You open your [armor] just enough to let your [cock] and [balls] dangle free.  A shiny rope of pre-cum dangles from your cock, showing that your reproductive system is every bit as fit as the rest of you.  ");
					if (player.hasPerk(PerkLib.BroBrains)) outputText("Bitches love a cum-leaking cock.");
					else outputText("You've got to admit, you look pretty good down there.");
				}
				if (player.hasPerk(PerkLib.BulgeArmor)) damage += 5;
				penis = true;
				break;
				//==EXTRAS========
				//12 Cat flexibility.
			case 12:
				//CAT TEASE MOTHERFUCK (requires flexibility and legs [maybe can't do it with armor?])
				outputText("Reaching down, you grab an ankle and pull it backwards, looping it up and over to touch the foot to your [hair].  You bring the leg out to the side, showing off your [vagina] through your [armor].  The combination of the lack of discomfort on your face and the ease of which you're able to pose shows [monster a][monster name] how good of a time they're in for with you.");
				vagina = true;
				if (player.thickness < 33) chance++;
				else if (player.thickness >= 66) chance--;
				damage += (player.thickness - 50) / 10;
				break;
				//13 Pregnant
			case 13:
				//PREG
				outputText("You lean back, feigning a swoon while pressing a hand on the small of your back.  The pose juts your huge, pregnant belly forward and makes the shiny spherical stomach look even bigger.  With a teasing groan, you rub the protruding tummy gently, biting your lip gently as you stare at [monster a][monster name] through heavily lidded eyes.  [say: All of this estrogen is making me frisky,] you moan, stroking hand gradually shifting to the southern hemisphere of your big baby-bump.");
				//if lactating]
				if (player.biggestLactation() >= 1) {
					outputText("  Your other hand moves to expose your [chest], cupping and squeezing a stream of milk to leak down the front of your [armor].  [say: Help a mommy out.]\n\n");
					chance += 2;
					damage += 4;
				}
				if (player.pregnancyIncubation < 100) {
					chance++;
					damage += 2;
				}
				if (player.pregnancyIncubation < 50) {
					chance++;
					damage += 2;
				}
				break;
				//14 Brood Mother
			case 14:
				if (rand(2) == 0) outputText("You tear open your [armor] and slip a few fingers into your well-used birth canal, giving your opponent a good look at what they're missing.  [say: C'mon stud,</i>\" you say, voice dripping with lust and desire, \"<i>Come to mama [name] and fuck my pussy 'til your baby batter just POURS out.  I want your children inside of me, I want your spawn crawling out of this cunt and begging for my milk.  Come on, FUCK ME PREGNANT!]");
				else outputText("You wiggle your [hips] at your enemy, giving them a long, tantalizing look at the hips that have passed so very many offspring.  [say: Oh, like what you see, bad boy?  Well why don't you just come on over and stuff that cock inside me?  Give me your seed, and I'll give you suuuuch beautiful offspring.  Oh?  Does that turn you on?  It does!  Come on, just let loose and fuck me full of your babies!]");
				chance += player.inHeat ? 4 : 2;
				damage += player.inHeat ? 8 : 4;
				vagina = true;
				break;
				//15 Nipplecunts
			case 15:
				//Req's tits & Pussy
				if (player.biggestTitSize() > 1 && player.hasVagina() && rand(2) == 0) {
					outputText("Closing your eyes, you lean forward and slip a hand under your [armor].  You let out the slightest of gasps as your fingers find your drooling honeypot, warm tips poking, one after another between your engorged lips.  When you withdraw your hand, your fingers have been soaked in the dripping passion of your cunny, translucent beads rolling down to wet your palm.  With your other hand, you pull down the top of your [armor] and bare your [chest] to [monster a][monster name].\n\n");
					outputText("Drawing your lust-slick hand to your [nipples], the yielding flesh of your cunt-like nipples parts before the teasing digits.  Using your own girl cum as added lubrication, you pump your fingers in and out of your nipples, moaning as you add progressively more digits until only your thumb remains to stroke the inflamed flesh of your over-stimulated chest.  Your throat releases the faintest squeak of your near-orgasmic delight and you pant, withdrawing your hands and readjusting your armor.\n\n");
					outputText("Despite how quiet you were, it's clear that every lewd, desperate noise you made was heard by [monster a][monster name].");
					chance += 2;
					damage += 4;
				}
				else if (player.biggestTitSize() > 1 && rand(2) == 0) {
					outputText("You yank off the top of your [armor], revealing your [chest] and the gaping nipplecunts on each.  With a lusty smirk, you slip a pair of fingers into the nipples of your [chest], pulling the nipplecunt lips wide, revealing the lengthy, tight passage within.  You fingerfuck your nipplecunts, giving your enemy a good show before pulling your armor back on, leaving the tantalizing image of your gaping titpussies to linger in your foe's mind.");
					chance += 1;
					damage += 2;
				}
				else outputText("You remove the front of your [armor] exposing your [chest].  Using both of your hands, you thrust two fingers into your nipple cunts, milky girl cum soaking your hands and fingers.  [say: Wouldn't you like to try out these holes too?]");
				breasts = true;
				break;
				//16 Anal gape
			case 16:
				outputText("You quickly strip out of your [armor] and turn around, giving your [butt] a hard slap and showing your enemy the real prize: your [asshole].  With a smirk, you easily plunge your hand inside, burying yourself up to the wrist inside your anus.  You give yourself a quick fisting, watching the enemy over your shoulder while you moan lustily, sure to give them a good show.  You withdraw your hand and give your ass another sexy spank before readying for combat again.");
				anus = true;
				ass  = true;
				break;
				//17 Bee abdomen tease
			case 17:
				outputText("You swing around, shedding the [armor] around your waist to expose your [butt] to [monster a][monster name].  Taking up your oversized bee abdomen in both hands, you heft the thing and wave it about teasingly.  Drops of venom drip to and fro, a few coming dangerously close to [monster him].  [say: Maybe if you behave well enough, I'll even drop a few eggs into your belly,] you say softly, dropping the abdomen back to dangle above your butt and redressing.");
				ass = true;
				chance += .5;
				damage += .5;
				break;
				//18 DOG TEASE
			case 18:
				outputText("You sit down like a dog, your [legs] are spread apart, showing your [if(hasVagina)parted cunt-lips|puckered asshole, hanging, erect maleness,] and your hands on the ground in front of you.  You pant heavily with your tongue out and promise, [say: I'll be a good little bitch for you.]");
				vagina = true;
				chance += 1;
				damage += 2;
				break;
				//19 MAX FEM TEASE - SYMPHONIE
			case 19:
				outputText("You make sure to capture your foe's attention, then slowly and methodically allow your tongue to slide along your lush, full lips.  The glistening moisture that remains on their plump beauty speaks of deep lust and deeper throats.  Batting your long lashes a few times, you pucker them into a playful blown kiss, punctuating the act with a small moan. Your gorgeous feminine features hint at exciting, passionate moments together, able to excite others with just your face alone.");
				chance += 2;
				damage += 4;
				break;
				//20 MAX MASC TEASE
			case 20:
				outputText("As your foe regards you, you recognize their attention is fixated on your upper body.  Thrusting your strong jaw forward you show off your chiseled chin, handsome features marking you as a flawless specimen.  Rolling your broad shoulders, you nod your head at your enemy.  The strong, commanding presence you give off could melt the heart of an icy nun.  Your perfect masculinity speaks to your confidence, allowing you to excite others with just your face alone.");
				chance += 2;
				damage += 4;
				break;
				//21 MAX ADROGYN
			case 21:
				outputText("You reach up and run your hands down your delicate, androgynous features.  With the power of a man but the delicacy of a woman, looking into your eyes invites an air of enticing mystery.  You blow a brief kiss to your enemy while at the same time radiating a sexually exciting confidence.  No one could identify your gender by looking at your features, and the burning curiosity they encourage could excite others with just your face alone.");
				damage -= 3;
				break;
				//22 SPOIDAH SILK
			case 22:
				outputText("Reaching back, you milk some wet silk from your spider-y abdomen and present it to [monster a][monster name], molding the sticky substance as [monster he] looks on curiously.  Within moments, you hold up a silken heart scuplture, and with a wink, you toss it at [monster him]. It sticks to [monster his] body, the sensation causing [monster him] to hastily slap the heart off.  [monster He] returns [monster his] gaze to you to find you turned around, [butt] bared and abdomen bouncing lazily.  [say: I wonder what would happen if I webbed up your hole after I dropped some eggs inside?] you hiss mischievously.  [monster He] gulps.");
				ass = true;
				break;
				//23 RUT TEASE
			case 23:
				if (player.horseCocks() > 0 && player.longestHorseCockLength() >= 12) {
					outputText("You whip out your massive horsecock, and are immediately surrounded by a massive, heady musk.  Your enemy swoons, nearly falling to her knees under your oderous assault.  Grinning, you grab her shoulders and force her to her knees.  Before she can defend herself, you slam your horsecock onto her head, running it up and down on her face, her nose acting like a sexy bump in an onahole.  You fuck her face -- literally -- for a moment before throwing her back and sheathing your cock.");
				}
				else {
					outputText("Panting with your unstoppable lust for the delicious, impregnable cunt before you, you yank off your [armor] with strength born of your inhuman rut, and quickly wave your fully erect cock at your enemy.  She flashes with lust, quickly feeling the heady effect of your man-musk.  You rush up, taking advantage of her aroused state and grab her shoulders.  ");
					outputText("Before she can react, you push her down until she's level with your cock, and start to spin it in a circle, slapping her right in the face with your musky man-meat.  Her eyes swim, trying to follow your meatspin as you swat her in the face with your cock!  Satisfied, you release her and prepare to fight!");
				}
				penis = true;
				break;
				//24 STAFF POLEDANCE
			case 24:
				outputText("You run your tongue across your lips as you plant your staff into the ground.  Before your enemy can react, you spin onto the long, wooden shaft, using it like an impromptu pole.  You lean back against the planted staff, giving your enemy a good look at your body.  You stretch backwards like a cat, nearly touching your fingertips to the ground beneath you, now holding onto the staff with only one leg.  You pull yourself upright and give your [butt] a little slap and your [chest] a wiggle before pulling open your [armor] and sliding the pole between your tits.  You drop down to a low crouch, only just covering your genitals with your hand as you shake your [butt] playfully.  You give the enemy a little smirk as you slip your [armor] back on and pick up your staff.");
				ass     = true;
				breasts = true;
				break;
				//TALL WOMAN TEASE
			case 25:
				outputText("You move close to your enemy, handily stepping over [monster his] defensive strike before leaning right down in [monster his] face, giving [monster him] a good long view at your cleavage.  [say: Hey, there, little [monster guy],] you smile.  Before [monster he] can react, you grab [monster him] and smoosh [monster his] face into your [fullchest], nearly choking [monster him] in the canyon of your cleavage.  [monster He] struggles for a moment.  You give [monster him] a little kiss on the head and step back, ready for combat.");
				breasts = true;
				chance += 2;
				damage += 4;
				break;
				//Magic Tease
			case 26:
				outputText("Seeing a lull in the battle, you plant your [weapon] on the ground and let your magic flow through you.  You summon a trickle of magic into a thick, slowly growing black ball of lust.  You wave the ball in front of you, making a little dance and striptease out of the affair as you slowly saturate the area with latent sexual magics.");
				chance++;
				damage += 2;
				break;
				//Feeder
			case 27:
				outputText("You present your swollen breasts full of milk to [monster a][monster name] and say [say: Wouldn't you just love to lie back in my arms and enjoy what I have to offer you?]");
				breasts = true;
				chance++;
				damage++;
				break;
				//28 FEMALE TEACHER COSTUME TEASE
			case 28:
				outputText("You turn to the side and give [monster a][monster name] a full view of your body.  You ask them if they're in need of a private lesson in lovemaking after class.");
				ass = true;
				break;
				//29 Male Teacher Outfit Tease
			case 29:
				outputText("You play with the strings on your outfit a bit and ask [monster a][monster name] just how much do they want to see their teacher pull them off?");
				chance++;
				damage += 3;
				break;
				//30 Naga Fetish Clothes
			case 30:
				outputText("You sway your body back and forth, and do an erotic dance for [monster a][monster name].");
				chance += 2;
				damage += 4;
				break;
				//31 Centaur harness clothes
			case 31:
				outputText("You rear back, and declare that, [say: This horse is ready to ride, all night long!]");
				chance += 2;
				damage += 4;
				break;
				//32 Genderless servant clothes
			case 32:
				outputText("You turn your back to your foe, and flip up your butt flap for a moment.   Your [butt] really is all you have to offer downstairs.");
				ass = true;
				chance++;
				damage += 2;
				break;
				//33 Crotch Revealing Clothes (herm only?)
			case 33:
				outputText("You do a series of poses to accentuate what you've got on display with your crotch revealing clothes, while asking if your [master] is looking to sample what is on display.");
				chance += 2;
				damage += 4;
				break;
				//34 Maid Costume (female only)
			case 34:
				outputText("You give a rather explicit curtsey towards [monster a][monster name] and ask them if your [master] is interested in other services today.");
				chance++;
				damage += 2;
				breasts = true;
				break;
				//35 Servant Boy Clothes (male only)
			case 35:
				outputText("You brush aside your crotch flap for a moment, then ask [monster a][monster name] if, [master] would like you to use your [cocks] on them?");
				penis = true;
				chance++;
				damage += 2;
				break;
				//36 Bondage Patient Clothes (done):
			case 36:
				outputText("You pull back one of the straps on your bondage cloths and let it snap back.  [say: I need some medical care, feeling up for it?] you tease.");
				damage += 2;
				chance++;
				break;
			default:
				outputText("You shimmy and shake sensually. (An error occurred.)");
				break;
			case 37:
				outputText("You purse your lips coyly, narrowing your eyes mischievously and beckoning to [monster a][monster name] with a burning come-hither glare.  Sauntering forward, you pop your hip to the side and strike a coquettish pose, running " + ((player.tailCount > 1) ? "one of your tails" : "your tail") + " up and down [monster his] body sensually.");
				chance += 6;
				damage += 3;
				break;
			case 38:
				outputText("You wet your lips, narrowing your eyes into a smoldering, hungry gaze.  Licking the tip of your index finger, you trail it slowly and sensually down the front of your [armor], following the line of your [chest] teasingly.  You hook your thumbs into your top and shimmy it downward at an agonizingly slow pace.  The very instant that your [nipples] pop free, your tail crosses in front, obscuring [monster a][monster name]'s view.");
				breasts = true;
				chance++;
				damage++;
				break;
			case 39:
				outputText("Leaning forward, you bow down low, raising a hand up to your lips and blowing [monster a][monster name] a kiss.  You stand straight, wiggling your [hips] back and forth seductively while trailing your fingers down your front slowly, pouting demurely.  The tip of ");
				if (player.tailCount == 1) outputText("your");
				else outputText("a");
				outputText(" bushy tail curls up around your [leg], uncoiling with a whipping motion that makes an audible crack in the air.");
				ass = true;
				chance++;
				damage += 1;
				break;
			case 40:
				outputText("Turning around, you stare demurely over your shoulder at [monster a][monster name], batting your eyelashes amorously.");
				if (player.tailCount == 1) outputText("  Your tail twists and whips about, sliding around your [hips] in a slow arc and framing your rear nicely as you slowly lift your [armor].");
				else outputText("  Your tails fan out, twisting and whipping sensually, sliding up and down your [legs] and framing your rear nicely as you slowly lift your [armor].");
				outputText("  As your [butt] comes into view, you brush your tail" + ((player.tailCount > 1) ? "s" : "" ) + " across it, partially obscuring the view in a tantalizingly teasing display.");
				ass  = true;
				anus = true;
				chance++;
				damage += 2;
				break;
			case 41:
				outputText("Smirking coyly, you sway from side to side, running your tongue along your upper teeth seductively.  You hook your thumbs into your [armor] and pull them away to partially reveal ");
				if (player.cockTotal() > 0) outputText(player.sMultiCockDesc());
				if (player.gender == Gender.GENDER_HERM) outputText(" and ");
				if (player.gender >= 2) outputText("your " + vaginaDescript(0));
				outputText(".  Your bushy tail" + ((player.tailCount > 1) ? "s" : "" ) + " cross" + ((player.tailCount > 1) ? "" : "es") + " in front, wrapping around your genitals and obscuring the view teasingly.");
				vagina = true;
				penis  = true;
				damage += 2;
				chance++;
				break;
			case 42:
				//Tease #1:
				if (rand(2) == 0) {
					outputText("You lift your skirt and flash your king-sized stallionhood, already unsheathing itself and drooling pre, at your opponent.  [say: Come on, then; I got plenty of girlcock for you if that's what you want!] you cry.");
					penis = true;
					damage += 3;
					chance--;
				}
				//Tease #2:
				else {
					outputText("You turn partially around and then bend over, swaying your tail from side to side in your most flirtatious manner and wiggling your hips seductively, your skirt fluttering with the motions.  [say: Come on then, what are you waiting for?  This is a fine piece of ass here,] you grin, spanking yourself with an audible slap.");
					ass = true;
					chance += 2;
					damage += 3;
				}
				break;
			case 43:
				var cows:int = rand(7);
				if (cows == 0) {
					outputText("You tuck your hands under your chin and use your arms to squeeze your massive, heavy breasts together.  Milk squirts from your erect nipples, filling the air with a rich, sweet scent.");
					breasts = true;
					chance += 2;
					damage++;
				}
				else if (cows == 1) {
					outputText("Moaning, you bend forward, your full breasts nearly touching the ground as you sway your [hips] from side to side.  Looking up from under heavily-lidded eyes, you part your lips and lick them, letting out a low, lustful [say: Mooooo...]");
					breasts = true;
					chance += 2;
					damage += 2;
				}
				else if (cows == 2) {
					outputText("You tuck a finger to your lips, blinking innocently, then flick your tail, wafting the scent of your ");
					if (player.wetness() >= 3) outputText("dripping ");
					outputText("sex through the air.");
					vagina = true;
					chance++;
					damage++;
				}
				else if (cows == 3) {
					outputText("You heft your breasts, fingers splayed across your [nipples] as you SQUEEZE.  Milk runs in rivulets over your hands and down the massive curves of your breasts, soaking your front with sweet, sticky milk.");
					breasts = true;
					chance += 3;
					damage++;
				}
				else if (cows == 4) {
					outputText("You lift a massive breast to your mouth, suckling loudly at yourself, finally letting go of your nipple with a POP and a loud, satisfied gasp, milk running down your chin.");
					breasts = true;
					chance++;
					damage += 3;
				}
				else if (cows == 5) {
					outputText("You crouch low, letting your breasts dangle in front of you.  Each hand caresses one in turn as you slowly milk yourself onto your thighs, splashing white, creamy milk over your hips and sex.");
					vagina  = true;
					breasts = true;
					chance++;
				}
				else {
					outputText("You lift a breast to your mouth, taking a deep draught of your own milk, then tilt your head back.  With a low moan, you let it run down your front, winding a path between your breasts until it drips sweetly from your crotch.");
					vagina  = true;
					breasts = true;
					damage += 2;
				}
				if (monster.short.indexOf("minotaur") != -1) {
					damage += 6;
					chance += 3;
				}
				break;
				//lusty maiden's armor teases
			case 44:
				damage += 5;
				chance += 3;
				switch (rand(5)) {
					case 0:
						outputText("Confidently sauntering forward, you thrust your chest out with your back arched in order to enhance your [chest].  You slowly begin to shake your torso back and forth, slapping your chain-clad breasts against each other again and again.  One of your hands finds its way to one of the pillowy expanses and grabs hold, fingers sinking into the soft tit through the fine, mail covering.  You stop your shaking to trace a finger down through the exposed center of your cleavage, asking, [say: Don't you just want to snuggle inside?]");
						breasts = true;
						break;
					case 1:
						outputText("You skip up to [monster a][monster name] and spin around to rub your barely-covered butt up against [monster him].  Before [monster he] can react, you're slowly bouncing your [butt] up and down against [monster his] groin.  When [monster he] reaches down, you grab [monster his] hand and press it up, under your skirt, right against the steamy seal on your sex.  The simmering heat of your overwhelming lust burns hot enough for [monster him] to feel even through the contoured leather, and you let [monster him] trace the inside of your [leg] for a moment before moving away, laughing playfully.");
						ass = true;
						vagina = true;
						break;
					case 2:
						outputText("You flip up the barely-modest chain you call a skirt and expose your g-string to [monster a][monster name].  Slowly swaying your [hips], you press a finger down on the creased crotch plate and exaggerate a lascivious moan into a throaty purr of enticing, sexual bliss.  Your eyes meet [monster his], and you throatily whisper, ");
						if (player.hasVirginVagina()) {
							outputText("[say: Think you can handle a virgin's infinite lust?]");
						} else {
							outputText("[say: Think you have what it takes to satisfy this perfect pussy?]");
						}
						vagina = true;
						damage += 3;
						break;
					case 3:
						outputText("You seductively wiggle your way up to [monster a][monster name], and before [monster he] can react to your salacious advance, you snap a [leg] up in what would be a vicious kick, if you weren't simply raising it to rest your [foot] on [monster his] shoulder.  With your thighs so perfectly spready, your skirt is lifted, and [monster a][monster name] is given a perfect view of your thong-enhanced cameltoe and the moisture that beads at the edges of your not-so-modest covering.");
						vagina = true;
						break;
					default:
						outputText("Bending over, you lift your [butt] high in the air.  Most of your barely-covered tush is exposed, but the hem of your chainmail skirt still protects some of your anal modesty.  That doesn't last long.  You start shaking your [butt] up, down, back, and forth to an unheard rhythm, flipping the pointless covering out of the way so that [monster a][monster name] can gaze upon your curvy behind in it all its splendid detail.  A part of you hopes that [monster he] takes in the intricate filigree on the back of your thong, though to [monster him] it looks like a bunch of glittering arrows on an alabaster background, all pointing squarely at your [asshole].");
						ass = true;
						chance += 2;
						break;
				}
				break;
				//lethicite armor teases
			case 45:
				var partChooser:Array = []; //Array for choosing.
				//Choose part. Must not be a centaur for cock and vagina teases!
				partChooser[partChooser.length] = 0;
				if (!player.isTaur()) {
					switch(player.gender){
						case Gender.GENDER_MALE:    partChooser.push(1); break;
						case Gender.GENDER_FEMALE:  partChooser.push(2); break;
						case Gender.GENDER_HERM:    partChooser.push(3); break;
					}
				}
				//Let's do this!
				switch (partChooser[rand(partChooser.length)]) {
					case 0:
						outputText("You place your hand on your lethicite-covered belly, move your hand up across your belly and towards your [chest]. Taking advantage of the small openings in your breastplate, you pinch and tweak your exposed [nipples].");
						breasts = true;
						chance += 3;
						damage += 1;
						break;
					case 1:
						outputText("You move your hand towards your [cocks], unobstructed by the lethicite. You give your [cock] a good stroke and sway your hips back and forth, emphasizing your manhood.");
						penis = true;
						chance += 1;
						damage += 2;
						break;
					case 2:
						outputText("You move your hand towards your [pussy], unobstructed by the lethicite. You give your [clit] a good tease, finger your [pussy], and sway your hips back and forth, emphasizing your womanhood.");
						vagina = true;
						chance += 1;
						damage += 2;
						break;
					case 3:
						outputText("You move your hand towards your [cocks] and [pussy], unobstructed by the lethicite. You give your [cock] a good stroke, tease your [clit], and sway your hips back and forth, emphasizing your hermaphroditic gender.");
						penis  = true;
						vagina = true;
						chance += 1;
						damage += 3;
						break;
					default:
						outputText("Whoops, something derped! Please let Ormael/Aimozg/Oxdeception know! Anyways, you put on a tease show.");
				}
				break;
				//alraune teases
			case 46:
				outputText("You let your vines crawl around your opponent, teasing all of [monster a][monster name] erogenous zones.  [monster A][monster name] gasps in involuntary arousal at your ministrations, relishing the way your vines seek out all [monster a][monster name] pleasurable spots and relentlessly assaults them.");
				damage += scalingBonusToughness() * 0.1;
				break;
				//manticore tailpussy teases
			case 47:
				outputText("You suddenly open your tail pussy presenting your drooling hole to [monster a][monster name] and smirking.\n\n");
				outputText("[say: Bet you want a shot at this, look how much this bad girl is ready for you.]");
				chance += 3;
				damage += 3;
				break;
		}
		//===========================
		//BUILD BONUSES IF APPLICABLE
		//===========================
		var bonusChance:Number = 0;
		var bonusDamage:Number = 0;
		if (auto) {
			var bonuses:Object = autoBonus(breasts, vagina, penis, balls, ass, anus);
			bonusChance = bonuses.bonusChance;
			bonusDamage = bonuses.bonusDamage;
		}
		//Land the hit!
		if (rand(100) <= chance + rand(bonusChance)) {
			//NERF TEASE DAMAGE
			damage *= .7;
			bonusDamage *= .7;
			if (player.hasPerk(PerkLib.ElectrifiedDesire)) {
				damage *= (1 + (player.lust100 * 0.01));
				bonusDamage *= (1 + (player.lust100 * 0.01));
			}
			if (player.hasPerk(PerkLib.HistoryWhore)) {
				damage *= 1.15;
				bonusDamage *= 1.15;
			}
			//Determine if critical tease!
			var crit:Boolean = false;
			var critChance:int = 5;
			if (player.hasPerk(PerkLib.CriticalPerformance)) {
				if (player.lib <= 100) critChance += player.lib / 5;
				if (player.lib > 100) critChance += 20;
			}
			if (monster.isImmuneToCrits()) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damage *= 1.75;
			}
			if (player.hasPerk(PerkLib.ChiReflowLust)) damage *= UmasShop.NEEDLEWORK_LUST_TEASE_DAMAGE_MULTI;
			if (player.hasPerk(PerkLib.ArouseTheAudience) && player.hasPerk(PerkLib.EnemyGroupType)) damage *= 1.5;
			damage = (damage + rand(bonusDamage)) * monster.lustVuln;
			if (player.hasPerk(PerkLib.DazzlingDisplay) && rand(100) < 15) {
				outputText("\n[monster a][monster name] is so mesmerised by your show that it stands there gawking.");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			if (monster is JeanClaude) (monster as JeanClaude).handleTease(damage, true);
			else if (monster is Doppleganger && !monster.hasStatusEffect(StatusEffects.Stunned)) (monster as Doppleganger).mirrorTease(damage, true);
			else if (!justText) {
				monster.teased(damage);
				if (crit == true) outputText(" <b>Critical!</b>");
			}
			if (flags[kFLAGS.PC_FETISH] >= 1 && !SceneLib.urtaQuest.isUrta()) {
				if (player.lust < (player.maxLust() * 0.75)) outputText("\nFlaunting your body in such a way gets you a little hot and bothered.");
				else outputText("\nIf you keep exposing yourself you're going to get too horny to fight back.  This exhibitionism fetish makes it hard to resist just stripping naked and giving up.");
				if (!justText) dynStats("lus", 2 + rand(3));
			}
			// Similar to fetish check, only add XP if the player IS the player...
			if (!justText && !SceneLib.urtaQuest.isUrta()) teaseXP(1);
		}
		//Nuttin honey
		else {
			if (!justText && !SceneLib.urtaQuest.isUrta()) teaseXP(5);

			if (monster is JeanClaude) (monster as JeanClaude).handleTease(0, false);
			else if (monster is Doppleganger) (monster as Doppleganger).mirrorTease(0, false);
			else if (!justText) outputText("\n[monster A][monster name] seems unimpressed.");
		}
		outputText("\n\n");
	}

	private function autoBonus(breasts:Boolean, vagina:Boolean, penis:Boolean, balls:Boolean, ass:Boolean, anus:Boolean):Object {
		var modStores:Array = [{
			calculate: breasts,
			mods: [
				{stat: player.bRows(), values: [2, 3, 5]},
				{stat: player.biggestLactation(), double: true, values: [2, 3]},
				{stat: player.biggestTitSize(), values: [4, 7, 12, 25, 50]},
				{stat: player.hasFuckableNipples(), double: true, values: [true]},
				{stat: player.averageNipplesPerBreast(), double: true, values: [1.1]}
			]
		}, {
			calculate: vagina,
			mods: [
				{stat: player.wetness(), values: [2, 3, 4, 5]},
				{stat: player.clitLength, values: [1.5, 3.5, 7.0, 12.0]},
				{stat: player.vaginalCapacity(), values: [30, 70, 120, 200]}
			]
		}, {
			calculate: penis,
			mods: [
				{stat: player.cockTotal(), double: true, values: [1]},
				{stat: player.biggestCockArea(), values: [15, 30, 60, 120]},
				{stat: player.cumQ(), values: [50, 150, 300, 1000]}
			]
		}, {
			calculate: balls,
			mods: [
				{stat: player.balls, double: true, values: [2.1]},
				{stat: player.ballSize, values: [3, 4, 8, 13]}
			]
		}, {
			calculate: ass,
			mods: [
				{stat: player.butt.type, values: [6, 10, 13, 16, 20]},
				{stat: player.hips.type, values: [6, 10, 13, 16, 20]}
			]
		}, {
			calculate: anus,
			mods: [
				{stat: player.analCapacity(), values: [30, 70, 120, 200]},
				{stat: player.ass.analLooseness, values: [0, 4, 5]},
				{stat: player.ass.analWetness, double: true, values: [1]}
			]
		}].filter(function (element:*, index:int, arr:Array):Boolean {
			return element.calculate;
		});

		var toReturn:Object = {
			bonusChance: 0.0, bonusDamage: 0.0
		};

		for each (var modStore:Object in modStores){
			for each (var mod:Object in modStore.mods){
				var chanceMod:Number = mod.double? 1.0 : 0.5;
				var damageMod:Number = mod.double? 2.0 : 1.0;
				for each (var val:Number in mod.values){
					if(mod.stat >= val){
						toReturn.bonusChance += chanceMod;
						toReturn.bonusDamage += damageMod;
					}
				}
			}
		}
		toReturn.bonusChance = Math.min( 5, toReturn.bonusChance);
		toReturn.bonusDamage = Math.min(10, toReturn.bonusDamage);
		return toReturn;
	}

	public function teaseXP(XP:Number = 0):void {
		while (XP > 0) {
			XP--;
			player.teaseXP++;
			//Level dat shit up!
			if (player.teaseLevel < maxTeaseLevel() && player.teaseXP >= 10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1)) {
				outputText("\n<b>Tease skill leveled up to " + (player.teaseLevel + 1) + "!</b>");
				player.teaseLevel++;
				player.teaseXP = 0;
			}
		}
	}
	
	public function maxTeaseLevel():Number {
		var maxLevel:Number = 1;
		if (player.level < 24) maxLevel += player.level;
		else maxLevel += 24;
		return maxLevel;
	}


}

}
