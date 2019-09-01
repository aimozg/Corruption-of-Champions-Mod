package classes {

import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Beard;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.JojoScene;

import coc.xxc.BoundNode;
import coc.xxc.Story;

public class PlayerAppearance extends BaseContent {


	public function PlayerAppearance() {
	}
	private var story:BoundNode;
	protected override function init():void {
        story = new Story("story", CoC.instance.rootStory, "appearance").bind(CoC.instance.context);
    }

	public function appearance():void {
		//Temp vars
		var temp:Number  = 0;
		var rando:Number = 0;
		//Determine race type:

		clearOutput();
		outputText("<font size=\"36\" face=\"Georgia\"><u>Appearance</u></font>\n");
		if (CoC.instance.gameSettings.charviewEnabled) {
			mainViewManager.showPlayerDoll(debug);
		}
		describeRace();
		describeGear();
		describeFaceShape();
		outputText(" It has " + player.faceDesc() + "."); //M/F stuff!
		describeEyes();
		describeHairAndEars();
		describeBeard();
		describeTongue();
		describeHorns();
		outputText("[pg]");
		describeBodyShape();
		describeWings();
		describeRearBody();
		describeArms();
		describeLowerBody();

		outputText("\n");
		if (player.hasStatusEffect(StatusEffects.GooStuffed)) {
			outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
		}
		//Pregnancy Shiiiiiitz
		if (player.isPregnant() || (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR)) {
			const pregnancyType:int       = player.pregnancyType;
			const pregnancyIncubation:int = player.pregnancyIncubation;
			if (pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				outputText("<b>");
				//Compute size
				temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
				if (pregnancyIncubation <= 50 && pregnancyIncubation > 20) {
					outputText("Your swollen pregnant belly is as large as a ");
					if (temp >= 20) outputText("beach ball.");
					else if (temp >= 10) outputText("watermelon.");
					else outputText("basketball.");
				}
				if (pregnancyIncubation <= 20) {
					outputText("Your swollen pregnant belly is as large as a ");
					if (temp >= 20) outputText("large medicine ball.");
					else if (temp >= 10) outputText("beach ball.");
					else outputText("watermelon.");
				}
				outputText("</b>");
				temp = 0;
			} else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > pregnancyIncubation) {
				//Satyr preggos - only shows if bigger than regular pregnancy or not pregnancy
				if (player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) {
					outputText("<b>You've got the beginnings of a small pot-belly.</b>");
				} else if (player.buttPregnancyIncubation >= 50) {
					outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>");
				} else if (player.buttPregnancyIncubation >= 30) {
					outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
				} else { //Surely Benoit and Cotton deserve their place in this list
					if (pregnancyType == PregnancyStore.PREGNANCY_IZMA || pregnancyType == PregnancyStore.PREGNANCY_MOUSE || pregnancyType == PregnancyStore.PREGNANCY_AMILY || (pregnancyType == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3)) || pregnancyType == PregnancyStore.PREGNANCY_EMBER || pregnancyType == PregnancyStore.PREGNANCY_BENOIT || pregnancyType == PregnancyStore.PREGNANCY_COTTON || pregnancyType == PregnancyStore.PREGNANCY_URTA || pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH)
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
					else if (pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
					else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
				}
			} else if (pregnancyType == PregnancyStore.PREGNANCY_URTA) {
				if (pregnancyIncubation <= 48) outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
				else if (pregnancyIncubation <= 72) outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
				else if (pregnancyIncubation <= 144) outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way. It's large and round, frequently moving.</b>");
				else if (pregnancyIncubation <= 216) outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you. It's gotten heavy enough to be a pain to carry around all the time.</b>");
				else if (pregnancyIncubation <= 288) outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>");
				else if (pregnancyIncubation <= 360) outputText("<b>Your belly is more noticeably distended. You're pretty sure it's Urta's.</b>");
				else if (pregnancyIncubation <= 432) outputText("<b>Your belly is larger than it used to be.</b>\n");
			} else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
				if (player.buttPregnancyIncubation >= 8) outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
				else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
			} else if (pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
				outputText("<b>Your belly remains swollen like a watermelon. ");
				if (pregnancyIncubation <= 100) outputText("It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>");
				else if (pregnancyIncubation <= 140) outputText("It feels like it’s full of thick syrup or jelly.</b>");
				else outputText("It still feels like there’s a solid ball inside your womb.</b>");
			} else {
				if (pregnancyIncubation <= 48) { //Surely Benoit and Cotton deserve their place in this list
					if (pregnancyType == PregnancyStore.PREGNANCY_IZMA
						|| pregnancyType == PregnancyStore.PREGNANCY_MOUSE
						|| pregnancyType == PregnancyStore.PREGNANCY_AMILY
						|| (pregnancyType == PregnancyStore.PREGNANCY_JOJO && JojoScene.monk <= 0)
						|| pregnancyType == PregnancyStore.PREGNANCY_EMBER
						|| pregnancyType == PregnancyStore.PREGNANCY_BENOIT
						|| pregnancyType == PregnancyStore.PREGNANCY_COTTON
						|| pregnancyType == PregnancyStore.PREGNANCY_URTA
						|| pregnancyType == PregnancyStore.PREGNANCY_MINERVA
						|| pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) {
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
					} else if (pregnancyType == PregnancyStore.PREGNANCY_MARBLE) {
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>"); }
					else {
						outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
					}
				}
				else if (pregnancyIncubation <= 72) outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
				else if (pregnancyIncubation <= 120) outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>");
				else if (pregnancyIncubation <= 180) outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>");
				else if (pregnancyIncubation <= 216) outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>");
				else if (pregnancyIncubation <= 280) outputText("<b>Your belly is more noticeably distended. You are probably pregnant.</b>");
				else if (pregnancyIncubation <= 336) outputText("<b>Your belly is larger than it used to be.</b>");
			}
			outputText("\n");
		}
		outputText("\n");
		if (player.gills.type == Gills.ANEMONE)
			outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest. They allow you to stay in the water for quite a long time. ");

		//Chesticles..I mean bewbz.
		if (player.breastRows.length == 1) {
			outputText("You have " + num2Text(player.breastRows[0].breasts) + " " + breastDescript(0) + ", each supporting ");
			outputText(num2Text(player.breastRows[0].nipplesPerBreast) + " "); //Number of nipples.
			outputText(Measurements.shortSuffix(int(player.nippleLength * 10) / 10) + " ");
			outputText(nippleDescript(0) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s.")); //Nipple description and plural
			if (player.breastRows[0].milkFullness > 75) outputText(" Your " + breastDescript(0) + " are painful and sensitive from being so stuffed with milk. You should release the pressure soon.");
			if (player.breastRows[0].breastRating >= 1) outputText(" You could easily fill a " + player.breastCup(temp) + " bra.");
			//Done with tits.  Move on.
			outputText("\n");
		} else {
			//many rows
			outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n");
			for (var i:int = 0; i < player.breastRows.length; i++){
				switch (i) {
					case 0: outputText("--Your uppermost rack houses "); break;
					case 1: outputText("--The second row holds "); break;
					case 2: outputText("--Your third row of breasts contains ");break;
					case 3: outputText("--Your fourth set of tits cradles ");break;
					case 4: outputText("--Your fifth and final mammary grouping swells with ");break;
				}
				outputText(num2Text(player.breastRows[i].breasts) + " " + breastDescript(i) + " with ");
				outputText(num2Text(player.breastRows[i].nipplesPerBreast) + " "); //Number of nipples per breast
				outputText(Measurements.shortSuffix(int(player.nippleLength * 10) / 10));
				outputText(nippleDescript(i) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each.")); //Description and Plural
				if (player.breastRows[i].milkFullness > 75) outputText(" Your " + breastDescript(i) + " are painful and sensitive from being so stuffed with milk. You should release the pressure soon.");
				if (player.breastRows[i].breastRating >= 1) outputText(" They could easily fill a " + player.breastCup(i) + " bra.");
				outputText("\n");
			}
		}

		//Crotchial stuff - mention snake
		if (player.lowerBody == LowerBody.NAGA && player.gender > 0) {
			outputText("\nYour sex");
			if (player.gender == 3 || player.cockTotal() > 1)
				outputText("es are ");
			else outputText(" is ");
			outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n");
		}
		//Crotchial stuff - mention scylla
		if (player.lowerBody == LowerBody.SCYLLA) {
			switch (player.gender) {
				case 1: outputText("\nYour sex is concealed between your front octopus tentacle legs dangling freely when not in use.\n"); break;
				case 2: outputText("\nYour sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.\n"); break;
				case 3:
					outputText("\nYour sex");
					if (player.cockTotal() > 1) outputText("es are ");
					else outputText(" is ");
					outputText("concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.\n");
					break;
			}
		}
		//Cock stuff!
		temp       = 0;
		var cock:* = player.cocks[temp];
		if (player.cocks.length == 1) {
			if (player.isTaur()) {
				outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.");
			}
			if (player.isScylla()) {
				outputText("\nYour equipment has shifted to lie between your front tentacles.");
			}
			if (player.isAlraune()) {
				outputText("\nYour equipment has shifted to lie below your pitcher now in the form of a mass of tentacle vine.");
			}

			outputText("\nYour " + cockDescript(temp) + " is " + Measurements.inchesOrCentimetres(int(10 * cock.cockLength) / 10) + " long and ");

			outputText(Measurements.inchesOrCentimetres(Math.round(10 * cock.cockThickness) / 10));
			outputText((Math.round(10 * cock.cockThickness) / 10) < 10 ? " thick." : " wide.");

			switch (cock.cockType) {
				case CockTypesEnum.HORSE: outputText(" It's mottled black and brown in a very animalistic pattern. The 'head' of your shaft flares proudly, just like a horse's."); break;
				case CockTypesEnum.DEMON: outputText(" The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused. The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins."); break;
				case CockTypesEnum.TENTACLE: outputText(" The entirety of its green surface is covered in perspiring beads of slick moisture. It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused."); break;
				case CockTypesEnum.STAMEN: outputText(" It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused."); break;
				case CockTypesEnum.CAT: outputText(" It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip. Each of the spines is soft and flexible, and shouldn't be painful for any of your partners."); break;
				case CockTypesEnum.LIZARD: outputText(" It's a deep, iridescent purple in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps."); break;
				case CockTypesEnum.ANEMONE: outputText(" The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload. At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners."); break;
				case CockTypesEnum.KANGAROO: outputText(" It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot."); break;
				case CockTypesEnum.DRAGON: outputText(" With its tapered tip, there are few holes you wouldn't be able to get into. It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would."); break;
				case CockTypesEnum.BEE: outputText(" It's a long, smooth black shaft that's rigid to the touch. Its base is ringed with a layer of four inch long soft bee hair. The tip has a much finer layer of short yellow hairs. The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it."); break;
				case CockTypesEnum.PIG: outputText(" It's bright pinkish red, ending in a prominent corkscrew shape at the tip."); break;
				case CockTypesEnum.AVIAN: outputText(" It's a red, tapered cock that ends in a tip. It rests nicely in a sheath."); break;
				case CockTypesEnum.RHINO: outputText(" It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center."); break;
				case CockTypesEnum.ECHIDNA: outputText(" It is quite a sight to behold, coming well-equiped with four heads."); break;
				case CockTypesEnum.RED_PANDA: outputText(" It lies protected in a soft, fuzzy sheath."); break;
				case CockTypesEnum.DOG:
				case CockTypesEnum.FOX:
				case CockTypesEnum.WOLF: {
					if      (cock.knotMultiplier >= 1.8) outputText(" The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost too big for your cock.");
					else if (cock.knotMultiplier >= 1.4) outputText(" A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.");
					else if (cock.knotMultiplier >  1.0) outputText(" A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge it inside a female.");
					outputText(" The knot is " + Measurements.numInchesOrCentimetres(Math.round(cock.cockThickness * cock.knotMultiplier * 10) / 10) + " wide when at full size.");
				}
			}


			if (player.hasStatusEffect(StatusEffects.Infested)) {
				outputText(" Every now and again a slimy worm coated in spunk slips partway out of your [cock], tasting the air like a snake's tongue.");
			}
			if (cock.sock) {
				sockDescript(temp);
			}
			//DONE WITH COCKS, moving on!
			outputText("\n");
		}
		if (player.cocks.length > 1) {
			if (player.isTaur()) {
				outputText("\nBetween hind legs of your bestial body you have grown " + player.multiCockDescript() + "!\n");
			} else if (player.isScylla()){
				outputText("\nBetween front tentacles of your bestial body you have grown " + player.multiCockDescript() + "!\n");
			} else {
				outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n");
			}

			temp  = 0;
			rando = rand(4);
			var prefix:String   = ["--Your first ", "--One of your ", "--One of your ", "--Your first "][rando];
			var prefixes:Array  = ["--Your next ", "--One of your ", "--Another of your ", "--Your next "];
			var postfixes:Array = [" wide.", " thick.", " thick.", " in diameter."];

			while (temp < player.cocks.length) {
				var len:String = Measurements.numInchesOrCentimetres(Math.floor(cock.cockLength));
				var wid:String = Measurements.numInchesOrCentimetres(Math.floor(cock.cockThickness));
				var postfix:String = postfixes[rando];

				outputText(prefix + player.cockDescript(temp) + " is " + len + " long and " + wid + postfix);

				switch (cock.cockType) {
					case CockTypesEnum.HORSE: outputText(" It's mottled black and brown in a very animalistic pattern. The 'head' of your " + player.cockDescript(temp) + " flares proudly, just like a horse's."); break;
					case CockTypesEnum.DOG: outputText(" It is shiny, pointed, and covered in veins, just like a large dog's cock."); break;
					case CockTypesEnum.FOX: outputText(" It is shiny, pointed, and covered in veins, just like a large fox's cock."); break;
					case CockTypesEnum.WOLF: outputText(" It is shiny, pointed, and covered in veins, just like a large wolf's cock."); break;
					case CockTypesEnum.DEMON: outputText(" The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused. The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins."); break;
					case CockTypesEnum.TENTACLE: outputText(" The entirety of its green surface is covered in perspiring beads of slick moisture. It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused."); break;
					case CockTypesEnum.STAMEN: outputText(" It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused."); break;
					case CockTypesEnum.CAT: outputText(" It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip. Each of the spines is soft and flexible, and shouldn't be painful for any of your partners."); break;
					case CockTypesEnum.LIZARD: outputText(" It's a deep, iridescent purple in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps."); break;
					case CockTypesEnum.ANEMONE: outputText(" The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload. At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners."); break;
					case CockTypesEnum.KANGAROO: outputText(" It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot."); break;
					case CockTypesEnum.DRAGON: outputText(" With its tapered tip, there are few holes you wouldn't be able to get into. It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would."); break;
					case CockTypesEnum.BEE: outputText(" It's a long, smooth black shaft that's rigid to the touch. Its base is ringed with a layer of four inch long soft bee hair. The tip has a much finer layer of short yellow hairs. The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it."); break;
					case CockTypesEnum.PIG: outputText(" It's bright pinkish red, ending in a prominent corkscrew shape at the tip."); break;
					case CockTypesEnum.AVIAN: outputText(" It's a red, tapered cock that ends in a tip. It rests nicely in a sheath."); break;
				}
				

				if (cock.knotMultiplier > 1) {
					if (cock.knotMultiplier >= 1.8) outputText(" The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost comically mismatched for your " + player.cockDescript(temp) + ".");
					else if (cock.knotMultiplier >= 1.4) outputText(" A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.");
					else outputText(" A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge your " + player.cockDescript(temp) + " inside a female.");
					//List knot thickness
					outputText(" The knot is " + Measurements.numInchesOrCentimetres(Math.floor(cock.cockThickness * cock.knotMultiplier * 10) / 10) + " thick when at full size.");
				}

				if (cock.sock != "" && cock.sock != null) {
					trace("Found a sock description (WTF even is a sock?)", cock.sock);
					sockDescript(temp);
				}

				temp++;
				rando = (rando + 1) % 4;
				prefix = prefixes[rando];
				outputText("\n");
				cock = player.cocks[temp];
			}
			//Worm flavor
			if (player.hasStatusEffect(StatusEffects.Infested))
				outputText("Every now and again slimy worms coated in spunk slip partway out of your [cocks], tasting the air like tongues of snakes.\n");
			//DONE WITH COCKS, moving on!
		}
		//Of Balls and Sacks!
		if (player.balls > 0) {
			if (player.hasStatusEffect(StatusEffects.Uniball)) {
				if (player.skinType != Skin.GOO)
					outputText("Your [sack] clings tightly to your groin, holding [balls] snugly against you.");
				else if (player.skinType == Skin.GOO)
					outputText("Your [sack] clings tightly to your groin, dripping and holding [balls] snugly against you.");
			} else {
				var sdesc:String;
				if (player.skin.hasMagicalTattoo()) {
					sdesc = " covered by magical tattoo";
				} else if (player.skin.hasBattleTattoo()) {
					sdesc = " covered by battle tattoo";
				} else if (player.skin.hasLightningShapedTattoo()) {
					sdesc = " covered with a few glowing lightning tattoos";
				} else {
					sdesc = "";
				}
				var swingsWhere:String;
				if (player.cockTotal() == 0) {
					swingsWhere = " where a penis would normally grow.";
				} else {
					swingsWhere = " under your [cocks].";
				}

				if (player.hasPlainSkinOnly()) outputText("A [sack]" + sdesc + " with [balls] swings heavily" + swingsWhere);
				else if (player.hasFur()) outputText("A fuzzy [sack] filled with [balls] swings low" + swingsWhere);
				else if (player.hasCoatOfType(Skin.CHITIN)) outputText("A chitin [sack] hugs your [balls] tightly against your body.");
				else if (player.hasScales()) outputText("A scaley [sack] hugs your [balls] tightly against your body.");
				else if (player.skinType == Skin.STONE) outputText("A stone-solid sack with [balls] swings heavily" + swingsWhere);
				else if (player.skinType == Skin.GOO) outputText("An oozing, semi-solid sack with [balls] swings heavily" + swingsWhere);
			}
			outputText(" You estimate each of them to be about " + Measurements.numInchesOrCentimetres(Math.round(player.ballSize)) + " across.\n");
		}
		//VAGOOZ


		const vaginaLength:uint = player.vaginas.length;
		if (vaginaLength > 0) {
			const vagina:VaginaClass = player.vaginas[0];
			if (player.gender == 2) {
				if (player.isScylla()) outputText("\nYour womanly parts have shifted to lie underneath your tentacle legs.");
				else if (player.isTaur()) outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.");
			}
			outputText("\n");
			if (vaginaLength == 1) {
				outputText("You have a [vagina], with a " + Measurements.shortSuffix(int(player.clitLength * 10) / 10) + " clit");
			}
			if (vagina.virgin) outputText(" and an intact hymen");
			outputText(". ");
			if (vaginaLength > 1) {
				outputText("You have " + vaginaLength + " [vagina]s, with " + Measurements.shortSuffix(int(player.clitLength * 10) / 10) + " clits each. ");
			}
			if (player.lib < 50 && player.lust < 50) {
				//not particularly horny
				//Wetness
				if (vagina.vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("Occasional beads of lubricant drip from ");
				else if (vagina.vaginalWetness >= VaginaClass.WETNESS_WET) outputText("Moisture gleams in ");
				//Different description based on vag looseness
				if (vagina.vaginalWetness >= VaginaClass.WETNESS_WET) {
					if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) outputText("your [vagina]. ");
					else if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE) outputText("your [vagina], its lips slightly parted. ");
					else outputText("the massive hole that is your [vagina]. ");
				}
			}
			if ((player.lib >= 50 || player.lust >= 50) && (player.lib < 80 && player.lust < 80)) //kinda horny
			{
				//Wetness
				if (vagina.vaginalWetness < VaginaClass.WETNESS_WET) outputText("Moisture gleams in ");
				if (vagina.vaginalWetness < VaginaClass.WETNESS_DROOLING) outputText("Occasional beads of lubricant drip from ");
				else outputText("Thin streams of lubricant occasionally dribble from ");
				//Different description based on vag looseness
				if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) outputText("your [vagina]. ");
				else if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE) outputText("your [vagina], its lips slightly parted. ");
				else outputText("the massive hole that is your [vagina]. ");
			}
			if ((player.lib > 80 || player.lust > 80)) {
				//Wetness
				if (vagina.vaginalWetness >= VaginaClass.WETNESS_DROOLING) outputText("Thick streams of lubricant drool constantly from ");
				else if (vagina.vaginalWetness >= VaginaClass.WETNESS_WET) outputText("Thin streams of lubricant occasionally dribble from ");
				else outputText("Occasional beads of lubricant drip from ");

				//Different description based on vag looseness
				if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) outputText("your [vagina]. ");
				else if (vagina.vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE) outputText("your [vagina], its lips slightly parted. ");
				else outputText("the massive hole that is your cunt. ");
			}
			//Line Drop for next descript!
			outputText("\n");
		}
		//Genderless lovun'
		if (player.cockTotal() == 0 && vaginaLength == 0) outputText("\nYou have a curious lack of any sexual endowments.\n");


		//BUNGHOLIO
		if (player.ass) outputText("\nYou have one [asshole], placed between your butt-cheeks where it belongs.\n");
		//Piercings!
		if (player.eyebrowPierced > 0) outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.");
		if (player.earsPierced > 0) outputText("\nYour ears are pierced with " + player.earsPShort + ".");
		if (player.nosePierced > 0) outputText("\nA " + player.nosePShort + " dangles from your nose.");
		if (player.lipPierced > 0) outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.");
		if (player.tonguePierced > 0) outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.");

		if (player.nipplesPierced == 3) outputText("\nYour " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.");
		else if (player.nipplesPierced > 0) outputText("\nYour " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".");

		if (player.cockTotal() > 0 && player.cocks[0].pierced > 0) {
			outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your [cock].");
		}
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00286] == 1) outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.");
		if (player.hasVagina()) {
			if (vagina.labiaPierced > 0) outputText("\nYour [vagina] glitters with the " + vagina.labiaPShort + " hanging from your lips.");
			if (vagina.clitPierced > 0)  outputText("\nImpossible to ignore, your [clit] glitters with its " + vagina.clitPShort + ".");
		}
		//MONEY!
		switch (player.gems) {
			case 0: outputText("\n\n<b>Your money-purse is devoid of any currency.</b>"); break;
			case 1: outputText("\n\n<b>You have 1 shining gem, collected in your travels.</b>"); break;
			default: outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.</b>"); break;
		}
		menu();
		addButton(0, "Next", playerMenu);
		addButton(11, "Gender Set.", GenderForcedSetting);
		addButton(10, "RacialScores", RacialScores);
		flushOutputTextToGUI();
	}

	public function describeBodyShape():void {
		outputText("You have a humanoid shape with the usual body");
		if (player.skin.coverage == Skin.COVERAGE_LOW) {
			outputText(" partialy covered with [skin coat]");
		} else if (player.skin.coverage >= Skin.COVERAGE_MEDIUM) {
			outputText(" covered with [skin coat]");
		}
		outputText(", arms, hands and fingers.");
		if (player.skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY) outputText(" However your skin is [skin color] with a [skin color2] underbelly that runs on the underside of your limbs and has a glossy shine, similar to that of an orca.");
		if (player.skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY) outputText(" Your body is covered from head to toe in [skin color] with a [skin color2] underbelly, giving to your nimble frame a red-panda appearance.");
	}

	public function describeGear():void {
		// story.display("gear");
		outputText(" <b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + "" + " and using your [weapon] as a melee weapon");

		if (player.weaponRangeName != "nothing") outputText(", [weaponrangename] as range weapon");
		if (player.shieldName != "nothing") outputText(" and [shield] as your shield");

		outputText(".");

		if (player.jewelryName != "nothing" && player.jewelryName != "fox hairpin" && player.jewelryName != "seer’s hairpin") outputText(" Girding one of your fingers is " + player.jewelryName + ".");
		if (player.jewelryName == "fox hairpin" || player.jewelryName == "seer’s hairpin") outputText(" In your hair is " + player.jewelryName + ".");
		if (player.hasKeyItem("Fenrir Collar") >= 0) outputText(" On your neck is Fenrir spiked Collar its chain still hanging down from it and clinking with an ominous metallic sound as you walk around.");
		outputText("</b>");
	}
	public function describeRace():void {
		// story.display("race");
//Discuss race
		if (player.race() != player.startingRace) outputText("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm. ");
		//Height and race.
		outputText("You are a ");
		outputText(Measurements.footInchOrMetres(player.tallness));
		outputText(" tall [malefemaleherm] [race], with [bodytype].");
	}
	public function describeLowerBody():void {
		var player:Player = this.player;
		var legCountLower:String = num2Text(player.legCount);
		var lowerBody:int  = player.lowerBody;
		if (player.isTaur() || lowerBody == LowerBody.DRIDER || lowerBody == LowerBody.SCYLLA || lowerBody == LowerBody.PLANT_FLOWER) {
			switch (lowerBody) {
				case LowerBody.HOOFED: outputText(" From the waist down you have the body of a horse, with all " + legCountLower + " legs capped by hooves."); break;
				case LowerBody.PONY: outputText(" From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all " + legCountLower + " legs ending in flat, rounded feet."); break;
				case LowerBody.DRIDER: outputText(" Where your legs would normally start you have grown the body of a spider, with " + legCountLower + " spindly legs that sprout from its sides."); break;
				case LowerBody.SCYLLA: outputText(" Where your legs would normally start you have grown the body of an octopus, with " + legCountLower + " tentacle legs that sprout from your [hips]."); break;
				case LowerBody.PLANT_FLOWER: outputText(" Around your waist, the petals of a large pink orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud. While you don't technically have legs anymore, you can still move around on your " + legCountLower + " vine-like stamens."); break;
				default: outputText(" Where your legs would normally start you have grown the body of a feral animal, with all " + legCountLower + " legs.");
			}
			
		}
		//Hip info only displays if you aren't a centaur.
		if (player.isBiped() || lowerBody == LowerBody.NAGA) {
			outputText(" You have [hips]");
			if (player.thickness > 70) {
				if (player.hips.type >= Hips.RATING_INHUMANLY_WIDE) outputText(" that sway hypnotically on your extra-curvy frame, and");
				else if (player.hips.type >= Hips.RATING_FERTILE) outputText(" that sway and emphasize your thick, curvy shape, and");
				else if (player.hips.type >= Hips.RATING_CURVY) outputText(" that would be much more noticeable if you weren't so wide-bodied, and");
				else if (player.hips.type >= Hips.RATING_AMPLE) outputText(" that blend into the rest of your thick form, and");
				else {
					if (player.tone >= 65) {
						outputText(" that blend into your pillar-like waist, and");
					} else {
						outputText(" buried under a noticeable muffin-top, and");
					}
				}
			} else if (player.thickness >= 30) {
				if (player.femininity > 50) {
					if (player.hips.type >= Hips.RATING_INHUMANLY_WIDE) outputText(" that make you look more like an animal waiting to be bred than any kind of human, and");
					else if (player.hips.type >= Hips.RATING_FERTILE) outputText(" that make it look like you've birthed many children, and");
					else if (player.hips.type >= Hips.RATING_CURVY) outputText(" that make you walk with a sexy, swinging gait, and");
					else if (player.hips.type >= Hips.RATING_AMPLE) outputText(" that draw the attention of those around you, and");
				} else {
					if (player.hips.type >= Hips.RATING_INHUMANLY_WIDE) {
						outputText(" that give your ");
						if (player.balls > 0) outputText("balls plenty of room to breathe");
						else if (player.hasCock()) outputText(player.multiCockDescript() + " plenty of room to swing");
						else if (player.hasVagina()) outputText(vaginaDescript() + " a nice, wide berth");
						else outputText("vacant groin plenty of room");
					}
					else if (player.hips.type >= Hips.RATING_FERTILE) outputText(" that force you to sway and wiggle as you move, and");
					else if (player.hips.type >= Hips.RATING_CURVY) outputText(" that add a little feminine swing to your gait, and");
					else if (player.hips.type >= Hips.RATING_AMPLE) outputText(" that give you a graceful stride, and");
				}
			} else {
				if (player.hips.type >= Hips.RATING_INHUMANLY_WIDE) outputText(" that swell disproportionately wide on your lithe frame");
				else if (player.hips.type >= Hips.RATING_FERTILE) outputText(", emphasized by your narrow waist");
				else if (player.hips.type >= Hips.RATING_CURVY) outputText(" that swell out under your trim waistline");
				else if (player.hips.type >= Hips.RATING_AMPLE) outputText(" that sway to and fro, emphasized by your trim body");
				else outputText(" that match your trim, lithe body");
			}
			outputText(", and");
		}
		//ASS
		//Horse version
		if (player.isTaur()) {
			outputText(" your [butt]");
			//FATBUTT
			if (player.tone < 65) {
				if (player.butt.type >= Butt.RATING_INCONCEIVABLY_BIG) outputText(" is obscenely large, bordering freakish, even for a horse.");
				else if (player.butt.type >= Butt.RATING_HUGE) outputText(" jiggles and wobbles as you trot about.");
				else if (player.butt.type >= Butt.RATING_JIGGLY) outputText(" jiggles a bit as you trot around.");
				else if (player.butt.type >= Butt.RATING_NOTICEABLE) outputText(" is fairly plump and healthy.");
				else if (player.butt.type >= Butt.RATING_AVERAGE) outputText(" looks fairly average.");
				else outputText(" is lean, from what you can see of it.");
			} else {
				//GIRL LOOK AT DAT BOOTY
				if (player.butt.type >= Butt.RATING_INCONCEIVABLY_BIG) outputText(" is stacked with layers of muscle, huge even for a horse.");
				else if (player.butt.type >= Butt.RATING_HUGE) outputText(" flexes its considerable mass as you move.");
				else if (player.butt.type >= Butt.RATING_JIGGLY) outputText(" surges with muscle whenever you trot about.");
				else if (player.butt.type >= Butt.RATING_NOTICEABLE) outputText(" gives hints of just how much muscle you could put into a kick.");
				else if (player.butt.type >= Butt.RATING_AVERAGE) outputText(" matches your toned equine frame quite well.");
				else outputText(" is barely noticeably, showing off the muscles of your haunches.");
			}
		} else if (player.isBiped() || lowerBody == LowerBody.NAGA) {
			//Non-horse PCs
			outputText(" your [butt]");
			//TUBBY ASS
			if (player.tone < 60) {
				if (player.butt.type >= Butt.RATING_INCONCEIVABLY_BIG) outputText(" is obscenely large, bordering freakish, and makes it difficult to run.");
				else if (player.butt.type >= Butt.RATING_HUGE) outputText(" wobbles like a bowl full of jello as you walk.");
				else if (player.butt.type >= Butt.RATING_JIGGLY) outputText(" wobbles enticingly with every step.");
				else if (player.butt.type >= Butt.RATING_NOTICEABLE) outputText(" fills out your clothing nicely.");
				else if (player.butt.type >= Butt.RATING_AVERAGE) outputText(" has the barest amount of sexy jiggle.");
				else outputText(" looks great under your gear.");
			} else {
				//FITBUTT
				if (player.butt.type >= Butt.RATING_INCONCEIVABLY_BIG) outputText(" is marvelously large, but completely stacked with muscle.");
				else if (player.butt.type >= Butt.RATING_HUGE) outputText(" threatens to bust out from under your kit each time you clench it.");
				else if (player.butt.type >= Butt.RATING_JIGGLY) outputText(" stretches your gear, flexing it with each step.");
				else if (player.butt.type >= Butt.RATING_NOTICEABLE) outputText(" fills out your clothing nicely.");
				else if (player.butt.type >= Butt.RATING_AVERAGE) outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.");
				else outputText(" molds closely against your form.");
			}
		}
		//TAILS
		describeTail();
		//</mod>
		//LOWERBODY SPECIAL
		var legCountCaps:String = legCountLower.charAt(0).toUpperCase() + legCountLower.slice(1);
		switch (lowerBody) {
			case LowerBody.HUMAN: outputText(" " + legCountCaps + " normal human legs grow down from your waist, ending in normal human feet."); break;
			case LowerBody.FERRET: outputText(" " + legCountCaps + " furry, digitigrade legs form below your [hips]. The fur is thinner on the feet, and your toes are tipped with claws."); break;
			case LowerBody.HOOFED: outputText(" Your " + legCountLower + " legs are muscled and jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves."); break;
			case LowerBody.CANINE: outputText(" " + legCountCaps + " digitigrade legs grow downwards from your waist, ending in clawed сanine-like hind-paws."); break;
			case LowerBody.NAGA: outputText(" Below your waist your flesh is fused together into a very long snake-like tail."); break;
			//Horse body is placed higher for readability purposes
			case LowerBody.DEMONIC_HIGH_HEELS: outputText(" Your " + legCountLower + " perfect lissome legs end in mostly human feet, apart from the horns protruding straight down from the heel that forces you to walk with a sexy, swaying gait."); break;
			case LowerBody.DEMONIC_CLAWS: outputText(" Your " + legCountLower + " lithe legs are capped with flexible clawed feet. Sharp black nails grow where once you had toe-nails, giving you fantastic grip."); break;
			case LowerBody.BEE: outputText(" Your " + legCountLower + " legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton. A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee."); break;
			case LowerBody.GOO: outputText(" In place of legs you have a shifting amorphous blob. Thankfully it's quite easy to propel yourself around on. The lowest portions of your [armor] float around inside you, bringing you no discomfort."); break;
			case LowerBody.CAT: outputText(" " + legCountCaps + " digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws."); break;
			case LowerBody.LIZARD: outputText(" " + legCountCaps + " digitigrade legs grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."); break;
			case LowerBody.SALAMANDER: outputText(" " + legCountCaps + " digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your [hips], ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."); break;
			case LowerBody.BUNNY: outputText(" Your " + legCountLower + " legs thicken below the waist as they turn into soft-furred rabbit-like legs. You even have large bunny feet that make hopping around a little easier than walking."); break;
			case LowerBody.HARPY: outputText(" Your " + legCountLower + " legs are covered with [haircolor] plumage. Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons."); break;
			case LowerBody.KANGAROO: outputText(" Your " + legCountLower + " furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes."); break;
			case LowerBody.CHITINOUS_SPIDER_LEGS: outputText(" Your " + legCountLower + " legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."); break;
			case LowerBody.FOX: outputText(" Your " + legCountLower + " legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends."); break;
			case LowerBody.DRAGON: outputText(" " + legCountCaps + " human-like legs grow down from your [hips], sheathed in scales and ending in clawed feet. There are three long toes on the front, and a small hind-claw on the back."); break;
			case LowerBody.RACCOON: outputText(" Your " + legCountLower + " legs, though covered in fur, are humanlike. Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch."); break;
			case LowerBody.CLOVEN_HOOFED: outputText(" " + legCountCaps + " digitigrade legs form below your [hips], ending in cloven hooves."); break;
			case LowerBody.MANTIS: outputText(" Your " + legCountLower + " legs are covered in a shimmering green, insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton."); break;
			case LowerBody.SHARK: outputText(" Your " + legCountLower + " legs are mostly human save for the webing between your toes."); break;
			case LowerBody.GARGOYLE: {
				outputText(" Your " + legCountLower + " digitigrade ");
				switch (flags[kFLAGS.GARGOYLE_BODY_MATERIAL]) {
					case 1: outputText("marble"); break;
					case 2: outputText("alabaster"); break;
				}
				outputText(" legs end in sharp-clawed stone feet. There are three long toes on the front, and a small hind claw on the back.");
				break;
			}
			case LowerBody.GARGOYLE_2: {
				outputText(" Your " + legCountLower + " ");
				switch (flags[kFLAGS.GARGOYLE_BODY_MATERIAL]) {
					case 1: outputText("marble"); break;
					case 2: outputText("alabaster"); break;
				}
				outputText(" legs aside of their stone structure look pretty much human.");
				break;
			}
			case LowerBody.PLANT_HIGH_HEELS: outputText(" Your " + legCountLower + " perfect lissome legs end in human feet, apart from delicate vines covered in spade-like leaves crawling around them on the whole length."); break;
			case LowerBody.PLANT_ROOT_CLAWS: outputText(" Your " + legCountLower + " legs looks quite normal aside feet. They turned literally into roots only vaguely retaining the shape of the feet."); break;
			case LowerBody.LION: outputText(" Your " + legCountLower + " legs are covered in [skin coat.color] fur up to the thigh where it fades to white. They end with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs."); break;
			case LowerBody.YETI: outputText(" Your " + legCountLower + " fur covered legs end with a pair of very large yeti feet, leaving large tracks and granting you easy mobility in the snow."); break;
			case LowerBody.ORCA: outputText(" Your " + legCountLower + " legs are mostly human save for the webbing between your toes that assists you in swimming."); break;
			case LowerBody.YGG_ROOT_CLAWS: outputText(" Your " + legCountLower + " legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip."); break;
			case LowerBody.ONI: outputText(" Your " + legCountLower + " legs are covered with a set of warlike tattoo and your feet end with sharp black nails."); break;
			case LowerBody.ELF: outputText(" Your " + legCountLower + " perfect lissom legs end in delicate, but agile elven feet allowing you to move gracefully and swiftly."); break;
			case LowerBody.RAIJU: outputText(" You have " + legCountLower + " fluffy, furred legs that look vaguely like kneehigh socks. Your pawed feet end in four thick toes, which serve as your main source of balance. You can walk on them as normally as your old plantigrade legs. A thick strand of darkly colored fur breaks out from your ankles, emulating a bolt of lighting in appearance."); break;
			case LowerBody.RED_PANDA: outputText(" Your " + legCountLower + " legs are equally covered in [skin coat.color] fur, ending on red-panda paws with short claws. They have a nimble and strong build, in case you need to escape from something."); break;
			case LowerBody.AVIAN: outputText(" You have strong thighs perfect for launching you into the air which end in slender, bird-like legs, covered with a [skin coat.color] plumage down to your knees and slightly rough, [skin] below. You have digitigrade feet, with toes that end in sharp talons."); break;
			case LowerBody.GRYPHON: outputText(" You have strong thighs perfect for launching you into the air ending in furred, feline legs, covered with a coat of soft, [skin coat.color2] fur. Your have digitigrade feet, lion-like, with soft, pink soles and paw pads, with feline toes ending in sharp, retractile claws."); break;
		}

		if (player.hasPerk(PerkLib.Incorporeality)) outputText(" Of course, your [legs] are partially transparent due to their ghostly nature."); // isn't goo transparent anyway?
	}

	public function describeTail():void {
		switch (player.tailType) {
			case Tail.HORSE: outputText(" A long [skin coat.color] horsetail hangs from your [butt], smooth and shiny."); break;
			case Tail.FERRET: outputText(" A long ferret tail sprouts from above your [butt]. It is thin, tapered, and covered in shaggy [skin coat.color] fur."); break;
			case Tail.DOG: outputText(" A fuzzy [skin coat.color] dogtail sprouts just above your [butt], wagging to and fro whenever you are happy."); break;
			case Tail.DEMONIC: outputText(" A narrow tail ending in a spaded tip curls down from your [butt], wrapping around your [leg] sensually at every opportunity."); break;
			case Tail.COW: outputText(" A long cowtail with a puffy tip swishes back and forth as if swatting at flies."); break;
			case Tail.SPIDER_ADBOMEN:
				outputText(" A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin. Though it's heavy and bobs with every motion, it doesn't seem to slow you down.");
				if (player.tailVenom < 80) outputText(" Your bulging arachnid posterior feels fairly full of webbing.");
				else if (player.tailVenom < 100) outputText(" Your arachnid rear bulges and feels very full of webbing.");
				else if (player.tailVenom == 100) outputText(" Your swollen spider-butt is distended with the sheer amount of webbing it's holding.");
				break;
			case Tail.BEE_ABDOMEN:
				outputText(" A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.");
				if (player.tailVenom < 80) outputText(" A single drop of poison hangs from your exposed stinger.");
				else if (player.tailVenom < 100) outputText(" Poisonous bee venom coats your stinger completely.");
				else if (player.tailVenom == 100) outputText(" Venom drips from your poisoned stinger regularly.");
				break;
			case Tail.SCORPION:
				outputText(" A large insectile scorpion-like tail dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin and tipped with a stinger.");
				if (player.tailVenom < 120) outputText(" A single drop of poison hangs from your exposed stinger.");
				else if (player.tailVenom < 150) outputText(" Poisonous bee venom coats your stinger completely.");
				else if (player.tailVenom == 150) outputText(" Venom drips from your poisoned stinger regularly.");
				break;
			case Tail.MANTICORE_PUSSYTAIL:
				outputText(" Your tail is covered in armored chitin from the base to the tip, it ends in a flower-like bulb. You can open and close your tail tip at will and its pussy-like interior can be used to milk male organs. ");
				outputText("The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough you can fling them at a target on a whim like the most talented archer.");
				break;
			case Tail.MANTIS_ABDOMEN: outputText(" A large insectile mantis-abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard greenish chitinous material."); break;
			case Tail.SHARK: outputText(" A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air."); break;
			case Tail.CAT: outputText(" A soft [skin coat.color] cat-tail sprouts just above your [butt], curling and twisting with every step to maintain perfect balance."); break;
			case Tail.LIZARD: outputText(" A tapered tail hangs down from just above your [ass]. It sways back and forth, assisting you with keeping your balance."); break;
			case Tail.SALAMANDER: outputText(" A tapered, covered in red scales tail hangs down from just above your [ass]. It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire."); break;
			case Tail.RABBIT: outputText(" A short, soft bunny tail sprouts just above your [ass], twitching constantly whenever you don't think about it."); break;
			case Tail.HARPY: outputText(" A tail of feathers fans out from just above your [ass], twitching instinctively to help guide you if you were to take flight."); break;
			case Tail.KANGAROO:
				outputText(" A conical, ");
				if (player.hasFur()) outputText("furry, " + player.coatColor);
				else outputText("gooey, " + player.skinTone);
				outputText(", tail extends from your [ass], bouncing up and down as you move and helping to counterbalance you.");
				break;
			case Tail.FOX:
				if (player.tailCount <= 1) outputText(" A swishing [skin coat.color] fox's brush extends from your [ass], curling around your body - the soft fur feels lovely.");
				else outputText(" " + Num2Text(player.tailCount) + " swishing [skin coat.color] fox's tails extend from your [ass], curling around your body - the soft fur feels lovely.");
				break;
			case Tail.DRACONIC: outputText(" A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip. Its tip menaces with spikes of bone, meant to deliver painful blows."); break;
			case Tail.RACCOON: outputText(" A black-and-[skin coat.color]-ringed raccoon tail waves behind you."); break;
			case Tail.MOUSE: outputText(" A naked, [skintone] mouse tail pokes from your butt, dragging on the ground and twitching occasionally."); break;
			case Tail.BEHEMOTH: outputText(" A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's."); break;
			case Tail.PIG: outputText(" A short, curly pig tail sprouts from just above your butt."); break;
			case Tail.GOAT: outputText(" A very short, stubby goat tail sprouts from just above your butt."); break;
			case Tail.RHINO: outputText(" A ropey rhino tail sprouts from just above your butt, swishing from time to time."); break;
			case Tail.ECHIDNA: outputText(" A stumpy echidna tail forms just about your [ass]."); break;
			case Tail.DEER: outputText(" A very short, stubby deer tail sprouts from just above your butt."); break;
			case Tail.WOLF: outputText(" A bushy [skin coat.color] wolf tail sprouts just above your [ass], wagging to and fro whenever you are happy."); break;
			case Tail.GARGOYLE: outputText(" A long spiked tail hangs down from just above your [ass]. It sways back and forth assisting in keeping your balance."); break;
			case Tail.GARGOYLE_2: outputText(" A long tail ending with an axe blade on both sides hangs down from just above your [ass]. It sways back and forth assisting in keeping your balance."); break;
			case Tail.ORCA: outputText(" A long, powerful Orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end and a smaller one not so far from your ass."); break;
			case Tail.YGGDRASIL: outputText(" A thin prehensile reptilian tail swings behind, covered by [skin coat]. Adorning the tip of your tail is a leaf, bobbing with each of your tail’s movements."); break;
			case Tail.RAIJU: outputText(" Your silky tail extends out from just above your [ass]. Its fur is lovely to the touch and almost glows at the tip, letting others know of your lightning based motif."); break;
			case Tail.RED_PANDA: outputText(" Sprouting from your [ass], you have a long, bushy tail. It has a beautiful pattern of rings in [skin coat.color] fluffy fur. It waves playfully as you walk giving to your step a mesmerizing touch."); break;
			case Tail.LION: outputText(" A soft [skin coat.color] cat-tail sprouts just above your [ass], curling and twisting with every step to maintain perfect balance. It ends with a small puffy hair balls like that of a lion"); break;
			case Tail.AVIAN: outputText(" A tail shaped like a fan of long, [skin coat.color] feathers rests above your [ass], twitching instinctively to help guide you if you were to take flight."); break;
			case Tail.GRIFFIN: outputText(" From your backside hangs a long tail, leonine in shape and covered mostly by a layer of [skin coat.color2] fur with a tip made of a tuft of [skin coat.color] colored feathers. It moves sinuously as you walk."); break;
		}
	}
	public function describeArms():void {
		switch (player.arms.type) {
			case Arms.HARPY: outputText(" [Skin coat.color] feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look."); break;
			case Arms.SPIDER: outputText(" Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves from a distance."); break;
			case Arms.MANTIS: outputText(" Shining green exoskeleton covers your arms from the biceps down with a long and sharp scythes extending from the wrists."); break;
			case Arms.BEE: outputText(" Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves ended with a yellow fuzz from a distance."); break;
			case Arms.SALAMANDER: outputText(" Shining thick, leathery red scales covers your arms from the biceps down and your fingernails are now a short curved claws."); break;
			case Arms.PLANT: outputText(" Delicate vines crawl down from the upper parts of your arms to your wrists covered in spade-like leaves, that bob whenever you move."); break;
			case Arms.SPHINX: outputText(" Your arms are covered with [skin coat.color] fur. They end with somewhat human-like hands armed with lethal claws."); break;
			case Arms.PLANT2: outputText(" Vines crawl down from your shoulders to your wrists, tipped with slits that drool precum. They look like innocent decorations from a distance."); break;
			case Arms.SHARK: outputText(" A middle sized shark-like fin has sprouted on each of your forearms near the elbow. Additionaly skin between your fingers forming a small webbings helpful when swimming."); break;
			case Arms.GARGOYLE:
				outputText(" Your ");
				switch (flags[kFLAGS.GARGOYLE_BODY_MATERIAL]) {
					case 1: outputText("marble"); break;
					case 2: outputText("alabaster"); break;
				}
				outputText(" arms end in stone sharp clawed hands.");
				break;
			case Arms.GARGOYLE_2:
				outputText(" Your ");
				switch (flags[kFLAGS.GARGOYLE_BODY_MATERIAL]) {
					case 1: outputText("marble"); break;
					case 2: outputText("alabaster"); break;
				}
				outputText(" arms end in normal human like hands.");
				break;
			case Arms.WOLF:
			case Arms.FOX: outputText(" Your arms are covered in thick fur ending up with clawed hands with animal like paw pads."); break;
			case Arms.LION: outputText(" Your arms are covered in [skin coat.color] up to your shoulder where it turns to white. They end with a pair of five-toed lion paws armed with lethal claws."); break;
			case Arms.KITSUNE: outputText(" Your arms are somewhat human save for your sharp nails."); break;
			case Arms.LIZARD:
			case Arms.DRAGON: outputText(" Shining thick, leathery scales covers your arms from the biceps down and your fingernails are now a short curved claws."); break;
			case Arms.YETI: outputText(" Your two arms covered with thick fur end with large, powerful yeti hands. You can use them to smash or punch things when you're angry."); break;
			case Arms.ORCA: outputText(" A middle sized orca-like fin has sprouted on each of your forearms near the elbow. Additionally, the skin between your fingers forms a small webbing that is helpful when swimming."); break;
			case Arms.DEVIL: outputText(" Your forearms are covered with fur and end with four finger paws like hands, but armed with claws. Despite their weird shape you have more then enough manual dexterity to draw even the most complex magical designs when spellcasting."); break;
			case Arms.ONI: outputText(" Your arms are mostly human, although covered in warlike tattoos. You have human hands with sharp black nails."); break;
			case Arms.ELF: outputText(" Your delicate elven hands are almost supernaturally dexterous allowing you to manipulate objects or cast spells with inhuman agility."); break;
			case Arms.RAIJU: outputText(" Your arms and hands are practically human save for the sharp white claws that have replaced your normal nails."); break;
			case Arms.RED_PANDA: outputText(" Soft, black-brown fluff cover your arms. Your paws have cute, pink paw pads and short claws."); break;
			case Arms.CAT: outputText(" Your arms are covered in [skin coat.color] up to your shoulder. They end with a pair of five-toed cat paws armed with lethal claws."); break;
			case Arms.AVIAN: outputText(" Your arms are covered with [skin coat.color] colored feathers just a bit past your elbow. Your humanoid hands have [skintone], slightly rough skin and end in short claws."); break;
			case Arms.GRYPHON: outputText(" The feathers on your arms reach a bit past your elbows, the fringe of [skin coat.color] plumage leading to your [skintone], slightly rough skinned hands. They end in short, avian claws."); break;
		}

		if (player.wings.type == Wings.BAT_ARM ){
			outputText(" Your arm bones are thin and light in order to allow flight. You have grown a few extra fingers, which allow you to hold various items even with your abnormal hands, albeit at the cost of preventing flight while doing so.");
		}
	}
	public function describeRearBody():void {
		switch (player.rearBody.type) {
			case RearBody.FENRIR_ICE_SPIKES: outputText(" Jagged ice shards grows out of your back providing both excellent defence and giving you a menacing look."); break;
			case RearBody.LION_MANE: outputText(" Around your neck there is a thick mane of fur. It looks great on you."); break;
			case RearBody.SHARK_FIN: outputText(" A large shark-like fin has sprouted between your shoulder blades. With it you have far more control over swimming underwater."); break;
			case RearBody.ORCA_BLOWHOLE: outputText(" Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca."); break;
			case RearBody.RAIJU_MANE: outputText(" A thick collar of fur grows around your neck. Multiple strands of fur are colored in a dark shade, making it look like a lightning bolt runs along the center of your fur collar."); break;
			case RearBody.BAT_COLLAR: outputText(" Around your neck is a thick collar of fur reminiscent of a bat's."); break;
			case RearBody.WOLF_COLLAR: outputText(" Around your neck there is a thick coat of [skin coat.color] fur. It looks great on you. That said, you can dismiss every one of your bestial features at any time should the need arise for you to appear human."); break;
		}

	}
	public function describeWings():void {
		switch (player.wings.type) {
			case Wings.BEE_LIKE_SMALL: outputText(" A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly."); break;
			case Wings.BEE_LIKE_LARGE: outputText(" A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly."); break;
			case Wings.MANTIS_LIKE_SMALL: outputText(" A pair of tiny mantis-wings sprout from your back, too small to allow you to fly."); break;
			case Wings.MANTIS_LIKE_LARGE: outputText(" A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly."); break;
			case Wings.BAT_LIKE_TINY: outputText(" A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use."); break;
			case Wings.BAT_LIKE_LARGE: outputText(" A pair of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air."); break;
			case Wings.BAT_LIKE_LARGE_2: outputText(" Two pairs of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air."); break;
			case Wings.MANTICORE_LIKE_SMALL: outputText(" A pair of small leathery wings covered with [skin coat.color] fur rest on your back. Despite being too small to allow flight they at least look cute on you."); break;
			case Wings.MANTICORE_LIKE_LARGE: outputText(" A pair of large ominous leathery wings covered with [skin coat.color] fur expand from your back. You can open them wide to soar high in search of your next prey."); break;
			case Wings.FEATHERED: outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [skin coat.color]-colored wings folded close, they can unfurl to allow you to soar gracefully in the sky."); break;
			case Wings.DRACONIC_SMALL: outputText(" Small, vestigial wings sprout from your shoulders. They might look like bat's wings, but the membranes are covered in fine, delicate scales."); break;
			case Wings.DRACONIC_LARGE: outputText(" Large wings sprout from your shoulders. When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone."); break;
			case Wings.DRACONIC_HUGE: outputText(" Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone."); break;
			case Wings.GIANT_DRAGONFLY: outputText(" Giant dragonfly wings hang from your shoulders. At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly."); break;
			case Wings.GARGOYLE_LIKE_LARGE:
				outputText(" Large stony wings sprout from your shoulders. When unfurled they stretch wider than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like ");
				switch (flags[kFLAGS.GARGOYLE_WINGS_TYPE]) {
					case 1: outputText("bird"); break;
					case 2: outputText("bat"); break;
				}
				outputText(" wings and, although they are clearly made of stone, they allow you to fly around with excellent aerial agility.");
				break;
			case Wings.PLANT: outputText(" Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding."); break;
			case Wings.BAT_ARM: outputText(" Your large winged arms allow you to fly in a similar fashion to the bats they resemble. You sometimes wrap them around you like a cape when you walk around, so as to keep them from encumbering you. That being said, you far prefer using them for their intended purpose, traveling by flight whenever you can."); break;
			case Wings.VAMPIRE: outputText(" Between your shoulder blades rest a pair of large, ominous black wings reminiscent of a bat’s. They can unfurl up to twice your arm’s length, allowing you to gracefully dance in the night sky."); break;
			case Wings.FEY_DRAGON_WINGS: outputText(" Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone. While draconic in appearance the delicate frame of your fey like dragon wings allows for even better speed and maneuverability."); break;
			case Wings.FEATHERED_AVIAN: outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [skin coat.color] wings folded close, they can unfurl to allow you to soar as gracefully as a bird."); break;
			case Wings.NIGHTMARE: outputText(" A pair of large ominous black leathery wings expand from your back. You can open them wide to soar high in the sky."); break;
		}

	}

	public function describeHorns():void {
		const horns:Horns = player.horns;
		if (horns.count <= 0) {
			return;
		}
		switch (horns.type) {
			case Horns.DEMON: {
				if (horns.count == 2) outputText(" A small pair of pointed horns has broken through the [skin.type] on your forehead, proclaiming some demonic taint to any who see them.");
				else if (horns.count == 4) outputText(" A quartet of prominent horns has broken through your [skin.type]. The back pair are longer, and curve back along your head. The front pair protrude forward demonically.");
				else if (horns.count == 6) outputText(" Six horns have sprouted through your [skin.type], the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost " + Measurements.numInchesOrCentimetres(8) + " long upwards and a little forward.");
				else if (horns.count >= 8) outputText(" A large number of thick demonic horns sprout through your [skin.type], each pair sprouting behind the ones before. The front jut forwards nearly " + Measurements.numInchesOrCentimetres(10) + " while the rest curve back over your head, some of the points ending just below your ears. You estimate you have a total of " + num2Text(horns.count) + " horns.");
				break;
			}
				//Minotaur horns
			case Horns.COW_MINOTAUR: {
				if (horns.count < 3) outputText(" Two tiny horns-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.");
				else if (horns.count < 6) outputText(" Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.");
				else if (horns.count < 12) outputText(" Two large horns sprout from your forehead, curving forwards like those of a bull.");
				else if (horns.count < 20) outputText(" Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long. They have dangerous looking points.");
				else outputText(" Two huge horns erupt from your forehead, curving outward at first, then forwards. The weight of them is heavy, and they end in dangerous looking points.");
				break;
			}
			case Horns.DRACONIC_X2: outputText(" A pair of " + Measurements.numInchesOrCentimetres(int(horns.count)) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage."); break;
			case Horns.DRACONIC_X4_12_INCH_LONG: outputText(" Two pairs of horns, roughly a foot long, sprout from the sides of your head. They sweep back and give you a fearsome look, almost like the dragons from your village's legends."); break;
			case Horns.ANTLERS: outputText(" Two antlers, forking into " + num2Text(horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone."); break;
			case Horns.GOAT: {
				if (horns.count == 1) outputText(" A pair of stubby goat horns sprout from the sides of your head.");
				else outputText(" A pair of tall-standing goat horns sprout from the sides of your head. They are curved and patterned with ridges.");
				break;
			}
			case Horns.RHINO: {
				if (horns.count < 2) {
					outputText(" A single horns sprouts from your forehead. It is conical and resembles a rhino's horns. You estimate it to be about " + Measurements.numInchesOrCentimetres(6) + " long.");
				} else {
					if (player.faceType == Face.RHINO) outputText(" A second horns sprouts from your forehead just above the horns on your nose.");
					else outputText(" A single horns sprouts from your forehead. It is conical and resembles a rhino's horns.");
					outputText(" You estimate it to be about " + Measurements.numInchesOrCentimetres(7) + " long.");
				}
				break;
			}
			case Horns.UNICORN: {
				if (horns.count < 3) outputText(" Tiny horns-like nub protrude from your forehead, resembling the horns of the young unicorn.");
				else if (horns.count < 6) outputText(" One moderately sized horns grow from your forehead, similar in size to those on a young unicorn.");
				else if (horns.count < 12) outputText(" One large horns sprout from your forehead, spiraling and pointing forwards like those of an unicorn.");
				else if (horns.count < 20) outputText(" One very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long. It have dangerous looking tip.");
				else outputText(" One huge and long spiraling horns erupt from your forehead, pointing forward. The weight of it is heavy and ends with dangerous and sharp looking tip.");
				break;
			}
			case Horns.BICORN: {
				if (horns.count < 3) outputText(" A pair of tiny horns-like nub protrude from your forehead, resembling the horns of the young bicorns.");
				else if (horns.count < 6) outputText(" Two moderately sized horns grow from your forehead, similar in size to those on a young bicorn.");
				else if (horns.count < 12) outputText(" Two large horns sprout from your forehead, spiraling and pointing forwards like those of a bicorn.");
				else if (horns.count < 20) outputText(" Two very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long. They have dangerous looking tip.");
				else outputText(" Two huge and long spiraling horns erupt from your forehead, pointing forward. The weight of them is heavy and ends with dangerous and sharp looking tips.");
				break;
			}
			case Horns.OAK: outputText(" Two branches, forking into " + num2Text(horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown made of oak wood."); break;
			case Horns.GARGOYLE: outputText(" A large pair of thick demonic looking horns sprout through the side of your head giving you a fiendish appearance."); break;
			case Horns.ORCHID: outputText(" A huge pair of orchids grows on each side of your head, their big long petals flopping gaily when you move."); break;
			case Horns.ONI_X2: outputText(" You have a pair of horns on your head warning anyone who looks that you are an oni and do mean serious business."); break;
			case Horns.ONI: outputText(" You have a single horns on your head warning anyone who looks that you are an oni and do mean serious business."); break;
		}

	}

	public function describeTongue():void {
		switch (player.tongue.type) {
			case Tongue.SNAKE: outputText(" A snake-like tongue occasionally flits between your lips, tasting the air."); break;
			case Tongue.DEMONIC: outputText(" A slowly undulating tongue occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal."); break;
			case Tongue.DRACONIC: outputText(" Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet. It has sufficient manual dexterity that you can use it almost like a third arm."); break;
			case Tongue.ECHIDNA: outputText(" A thin echidna tongue, at least a foot long, occasionally flits out from between your lips."); break;
			case Tongue.CAT: outputText(" Your tongue is rough like that of a cat. You sometimes groom yourself with it."); break;
			case Tongue.ELF: outputText(" One could mistake you for a human but your voice is unnaturally beautiful and melodious giving you away as something else."); break;
			case Tongue.DOG: outputText(" You sometime let your panting canine tongue out to vent heat."); break;
		}
	}

	public function describeBeard():void {
		if (player.beardLength <= 0) { return; }

		outputText(" You have a " + beardDescript() + " ");
		if (player.beardStyle == Beard.GOATEE) {
			outputText("protruding from your chin");
		} else {
			outputText("covering your " + randomChoice("jaw", "chin and cheeks"));
		}
		outputText(".");
	}

	public function describeEyes():void {
		switch (player.eyes.type) {
			case Eyes.FOUR_SPIDER_EYES: outputText(" In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead."); break;
			case Eyes.BLACK_EYES_SAND_TRAP: outputText(" Your eyes are solid spheres of inky, alien darkness."); break;
			case Eyes.SLITS: outputText(" Your [eyecolor] eyes have vertically slit like those of cat."); break;
			case Eyes.FENRIR: outputText(" Your eyes glows with a freezing blue light icy smoke rising in the air around it."); break;
			case Eyes.REPTILIAN: outputText(" Your eyes looks like those of a reptile with [eyecolor] irises and a slit."); break;
			case Eyes.SNAKE: outputText(" Your [eyecolor] eyes have slitted pupils like that of a snake."); break;
			case Eyes.DRAGON: outputText(" Your [eyecolor] eyes have slitted pupils like that of a dragon."); break;
			case Eyes.DEVIL: outputText(" Your eyes look fiendish with their black sclera and glowing [eyecolor] irises."); break;
			case Eyes.ONI: outputText(" Your eyes look normal enough save for their fiendish [eyecolor] iris and slitted pupils."); break;
			case Eyes.ELF: outputText(" Your [eyecolor] elven eyes looks somewhat human, save for their cat-like vertical slit which draws light right in, allowing you to see with perfect precision both at day and night time."); break;
			case Eyes.RAIJU: outputText(" Your eyes are of an electric [eyecolor] hue that constantly glows with voltage power. They have slitted pupils like those of a raiju."); break;
			case Eyes.GEMSTONES: outputText(" Instead of regular eyes you see through a pair of gemstones that change hue based on your mood."); break;
			case Eyes.FERAL: outputText(" In your eyes sometime dance a green light. It encompass your entire pupil when you let the beast within loose."); break;
			case Eyes.GRYPHON: outputText(" Your gifted eyes have a bird-like appearance, having an [eyecolor] sclera and a large, black iris. A thin ring of black separates your sclera from your outer iris."); break;
			default: outputText(" Your eyes are [eyecolor].");
		}
	}
	
	public function describeHairAndEars():void {
		//if bald
		var earType:Number = player.ears.type;
		if (player.hairLength == 0) {
			if (player.skinType == Skin.FUR) {
				outputText(" You have no hair, only a thin layer of fur atop of your head. ");
			} else {
				outputText(" You are totally bald, showing only shiny [skintone] [skin.type]");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				else if (player.skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
				else if (player.skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				outputText(" where your hair should be.");
			}
			switch (earType) {
				case Ears.HORSE:     outputText(" A pair of horse-like ears rise up from the top of your head."); break;
				case Ears.FERRET:    outputText(" A pair of small, rounded ferret ears sit on top of your head."); break;
				case Ears.DOG:       outputText(" A pair of dog ears protrude from your skull, flopping down adorably."); break;
				case Ears.COW:       outputText(" A pair of round, floppy cow ears protrude from the sides of your skull."); break;
				case Ears.ELFIN:     outputText(" A pair of large pointy ears stick out from your skull."); break;
				case Ears.CAT:       outputText(" A pair of cute, fuzzy cat ears have sprouted from the top of your head."); break;
				case Ears.PIG:       outputText(" A pair of pointy, floppy pig ears have sprouted from the top of your head."); break;
				case Ears.LIZARD:    outputText(" A pair of rounded protrusions with small holes on the sides of your head serve as your ears."); break;
				case Ears.BUNNY:     outputText(" A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk."); break;
				case Ears.FOX:       outputText(" A pair of large, adept fox ears sit high on your head, always listening."); break;
				case Ears.DRAGON:    outputText(" A pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them."); break;
				case Ears.RACCOON:   outputText(" A pair of vaguely egg-shaped, furry raccoon ears adorns your head."); break;
				case Ears.MOUSE:     outputText(" A pair of large, dish-shaped mouse ears tops your head."); break;
				case Ears.RHINO:     outputText(" A pair of open tubular rhino ears protrude from your head."); break;
				case Ears.ECHIDNA:   outputText(" A pair of small rounded openings appear on your head that are your ears."); break;
				case Ears.DEER:      outputText(" A pair of deer-like ears rise up from the top of your head."); break;
				case Ears.WOLF:      outputText(" A pair of pointed wolf ears rise up from the top of your head."); break;
				case Ears.LION:      outputText(" A pair of lion ears have sprouted from the top of your head."); break;
				case Ears.YETI:      outputText(" A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head."); break;
				case Ears.ORCA:      outputText(" A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is white while the top is black."); break;
				case Ears.SNAKE:     outputText(" A pair of large pointy ears covered in small scales stick out from your skull."); break;
				case Ears.GOAT:      outputText(" A pair or ears looking similar to those of a goat flapping from time to time in response to sounds."); break;
				case Ears.ONI:       outputText(" A pair of pointed elf-like oni ears stick out from your skull."); break;
				case Ears.ELVEN:     outputText(" A pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound stick out from your skull."); break;
				case Ears.WEASEL:    outputText(" A pair of sideways leaning weasel ears that flick toward every slight sound stick out from your skull."); break;
				case Ears.BAT:       outputText(" A pair of bat ears sit atop your head, always perked up to catch any stray sound."); break;
				case Ears.VAMPIRE:   outputText(" A pair of pointed elfin ears powerful enough to catch even the heartbeat of those around you stick out from your skull."); break;
				case Ears.RED_PANDA: outputText(" Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings."); break;
				case Ears.AVIAN:     outputText(" Two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable."); break;
				case Ears.GRYPHON:   outputText(" A duo of triangular, streamlined ears are located at each side of your head, helping you to pinpoint sounds. They’re covered in soft, [skin coat.color] fur and end in tufts."); break;
			}
			

			if (player.gills.type == Gills.FISH) outputText(" A set of fish like gills reside on your neck, several small slits that can close flat against your skin. They allow you to stay in the water for quite a long time.");
			if (player.antennae.type == Antennae.MANTIS) outputText(" Long prehensile antennae also appear on your skull, bouncing and swaying in the breeze.");
			if (player.antennae.type == Antennae.BEE)  outputText(" Floppy antennae also appear on your skull, bouncing and swaying in the breeze.");
		}
		else {
			//not bald
			switch (earType) {
				case Ears.HUMAN:     outputText(" Your [hair] looks good on you, accentuating your features well."); break;
				case Ears.FERRET:    outputText(" A pair of small, rounded ferret ears burst through the top of your [hair]."); break;
				case Ears.HORSE:     outputText(" The [hair] on your head parts around a pair of very horse-like ears that grow up from your head."); break;
				case Ears.DOG:       outputText(" The [hair] on your head is overlapped by a pair of pointed dog ears."); break;
				case Ears.COW:       outputText(" The [hair] on your head is parted by a pair of rounded cow ears that stick out sideways."); break;
				case Ears.ELFIN:     outputText(" The [hair] on your head is parted by a pair of cute pointed ears, bigger than your old human ones."); break;
				case Ears.CAT:       outputText(" The [hair] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises."); break;
				case Ears.LIZARD:    outputText(" The [hair] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears."); break;
				case Ears.BUNNY:     outputText(" A pair of floppy rabbit ears stick up out of your [hair], bouncing around as you walk."); break;
				case Ears.KANGAROO:  outputText(" The [hair] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle."); break;
				case Ears.FOX:       outputText(" The [hair] atop your head is parted by a pair of large, adept fox ears that always seem to be listening."); break;
				case Ears.DRAGON:    outputText(" The [hair] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them."); break;
				case Ears.RACCOON:   outputText(" The [hair] on your head parts around a pair of egg-shaped, furry raccoon ears."); break;
				case Ears.MOUSE:     outputText(" The [hair] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently."); break;
				case Ears.PIG:       outputText(" The [hair] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it."); break;
				case Ears.RHINO:     outputText(" The [hair] on your head is parted by a pair of tubular rhino ears."); break;
				case Ears.ECHIDNA:   outputText(" Your [hair] makes it near-impossible to see the small, rounded openings that are your ears."); break;
				case Ears.DEER:      outputText(" The [hair] on your head parts around a pair of deer-like ears that grow up from your head."); break;
				case Ears.WOLF:      outputText(" The [hair] on your head is overlapped by a pair of pointed wolf ears."); break;
				case Ears.LION:      outputText(" The [hair] is parted by a pair of lion ears that listen to every sound."); break;
				case Ears.YETI:      outputText(" The [hair] is parted by a pair of yeti ears, bigger than your old human ones."); break;
				case Ears.ORCA:      outputText(" The [hair] on your head is parted by a pair of very large fin at least twice as large as your head which help you orient yourself underwater. Their underside is white while the top is black."); break;
				case Ears.SNAKE:     outputText(" The [hair] on your head is parted by a pair of cute pointed ears covered in small scales, bigger than your old human ones."); break;
				case Ears.GOAT:      outputText(" The [hair] on your head is parted by a pair or ears looking similar to those of a goat flapping from time to time in response to sounds."); break;
				case Ears.ONI:       outputText(" The [hair] on your head is parted by a pair of pointed elf-like oni ears."); break;
				case Ears.ELVEN:     outputText(" The [hair] is parted by a pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound."); break;
				case Ears.WEASEL:    outputText(" Your [hair] is parted by two sideways leaning weasel ears that flick toward every slight sound."); break;
				case Ears.BAT:       outputText(" The [hair] on your head is parted by large bat ears atop your head, always perked up to catch any stray sound."); break;
				case Ears.VAMPIRE:   outputText(" The [hair] on your head is parted by pointed elfin ears powerful enough to catch even the heartbeat of those around you."); break;
				case Ears.RED_PANDA: outputText(" Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings."); break;
				case Ears.AVIAN:     outputText(" The [hair] atop your head compliments you quite well, and two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable."); break;
				case Ears.GRYPHON:   outputText(" Two triangular ears part your [hair] at each side of your head. They’re streamlined and adapted to fly, and are quite useful to locate sounds. They’re covered in soft, [skin coat.color] fur and end in tufts."); break;
			}
			
			//</mod>
			if(player.antennae.type == Antennae.MANTIS) {
				if(earType == Ears.BUNNY) outputText(" Long prehensile antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText(" Long prehensile antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
			if(player.antennae.type == Antennae.BEE) {
				if(earType == Ears.BUNNY) outputText(" Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText(" Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
		}
	}
	public function describeFaceShape():void {
		// story.display("faceShape");
		var faceType:Number = player.faceType;
		var skin:Skin = player.skin;
		if (player.facePart.isHumanShaped()) {
			var odd:int = 0;
			var skinAndSomething:String = "";
			if (player.facePart.type == Face.BUCKTEETH) {
				skinAndSomething = " and mousey buckteeth";
				odd++;
			}
			if (skin.coverage < Skin.COVERAGE_COMPLETE) {
				outputText(" Your face is human in shape and structure, with [skin]" + skinAndSomething);
				if (skin.hasMagicalTattoo()) {
					outputText(" covered with magical tattoo");
					odd++;
				} else if (skin.hasBattleTattoo()) {
					outputText(" covered with battle tattoo");
					odd++;
				} else if (skin.hasLightningShapedTattoo()) {
					outputText(" covered with a few glowing lightning tattoos");
					odd++;
				}
				if (skin.isCoverLowMid()) {
					outputText(".");
					outputText(" On your cheek you have [skin coat]");
					odd++;
				}
			} else if (skin.hasCoatOfType(Skin.FUR)) {
				odd++;
				outputText(" Under your [skin coat] you have a human-shaped head with [skin base]" + skinAndSomething);
			} else if (skin.hasCoat() && !skinAndSomething) {
				odd++;
				outputText(" Your face is fairly human in shape, but is covered in [skin coat]");
			} else {
				outputText(" Your face is human in shape and structure, with [skin full]" + skinAndSomething);
			}
			outputText(".");

			switch (faceType) {
				case Face.SHARK_TEETH: outputText(" A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance."); break;
				case Face.BUNNY: outputText(" The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness."); break;
				case Face.SPIDER_FANGS: outputText(" A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom."); break;
				case Face.FERRET_MASK: outputText(" The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask."); break;
				case Face.SHARPTEETH: outputText(" You have a set of sharp animal-like teeth in your mouth."); break;
				case Face.SNAKE_FANGS:
					if (odd == 0) {
						outputText(" The only oddity is your pair of dripping fangs which often hang over your lower lip.");
					} else {
						outputText(" In addition, a pair of fangs hang over your lower lip, dripping with venom.");
					}
					break;
				case Face.YETI_FANGS:
					if (odd == 0){
						outputText(". Your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
					} else {
						outputText(" In addition, your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
					}
					break;
				case Face.VAMPIRE: outputText(" Your mouth could pass for human if not for the pair of long and pointy canines you use to tear into your victims to get at their blood."); break;
			}
			return;
		}

		switch (faceType) {
			case Face.FERRET:
				if (player.hasFullCoatOfType(Skin.FUR)) outputText(" Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features. It is complete with a wet nose and whiskers.");
				else if (player.hasCoat()) outputText(" Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is [skin base] covered with [skin coat].");
				else outputText(" Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.");
				break;

			case Face.RACCOON_MASK:
				if (player.hasCoat()) {
					if (InCollection(skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight")) {
						outputText(" Under your [skin coat] hides a black raccoon mask, barely visible due to your inky hue, and");
					} else {
						outputText(" Your [skin coat] are decorated with a sly-looking raccoon mask, and under them");
					}
					outputText(" you have a human-shaped head with [skin base].");
				} else {
					outputText(" Your face is human in shape and structure, with [skin bases");
					if (InCollection(skin.base.color, "ebony", "black")) {
						outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
					} else if (skin.hasMagicalTattoo()) {
						outputText(" covered with magical tattoo, though it is decorated with a sly-looking raccoon mask over your eyes.");
					} else if (skin.hasBattleTattoo()) {
						outputText(" covered with battle tattoo, though it is decorated with a sly-looking raccoon mask over your eyes.");
					} else if (skin.hasLightningShapedTattoo()) {
						outputText(" covered with a few glowing lightning tattoos, though it is decorated with a sly-looking raccoon mask over your eyes.");
					} else {
						outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
					}
				}
				break;

			case Face.RACCOON:
				outputText(" You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skin coat] by a band of white.");
				if (player.hasPlainSkinOnly()) {
					outputText(" It looks a bit strange with only the skin and no fur.");
				} else if (skin.hasMagicalTattoo()) {
					outputText(" It looks a bit strange with only the skin covered with magical tattoo and no fur.");
				} else if (skin.hasBattleTattoo()) {
					outputText(" It looks a bit strange with only the skin covered with battle tattoo and no fur.");
				} else if (skin.hasLightningShapedTattoo()) {
					outputText(" It looks a bit strange with only the skin covered with a few glowing lightning tattoos and no fur.");
				} else if (player.hasScales()) {
					outputText(" The presence of said scales gives your visage an eerie look, more reptile than mammal.");
				} else if (skin.hasChitin()) {
					outputText(" The presence of said chitin gives your visage an eerie look, more insect than mammal.");
				}
				break;

			case Face.FOX:
				outputText(" You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
				if (!player.hasCoat()) {
					outputText(" Oddly enough, there's no fur on your animalistic muzzle, just [skin coat].");
				} else if (skin.hasMagicalTattoo()) {
					outputText(" Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with magical tattoo.");
				} else if (skin.hasBattleTattoo()) {
					outputText(" Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with battle tattoo.");
				} else if (skin.hasLightningShapedTattoo()) {
					outputText(" Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with a few glowing lightning tattoos.");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" A coat of [skin coat] decorates your muzzle.");
				} else if (skin.isCoverLowMid()) {
					outputText(" Strangely, [skin coat] adorn your animalistic visage.");
				} else {
					outputText(" Strangely, [skin coat] adorn every inch of your animalistic visage.");
				}
				break;

			case Face.MOUSE:
				outputText(" You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin full]");
				outputText(". Two large incisors complete it.");
				break;

			case Face.HORSE:
				if (!player.hasCoat()) {
					outputText(" Your face is equine in shape and structure. The odd visage is hairless and covered with [skin base].");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" Your face is almost entirely equine in appearance, even having [skin coat]. Underneath the fur, you believe you have [skin base].");
				} else {
					outputText(" You have the face and head structure of a horse, overlaid with glittering [skin coat].");
				}
				break;

			case Face.DOG:
				if (!player.hasCoat()) {
					outputText(" You have a dog-like face, complete with a wet nose. The odd visage is hairless and covered with [skin base].");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" You have a dog's face, complete with wet nose and panting tongue. You've got [skin coat], hiding your [skin base] underneath your furry visage.");
				} else {
					outputText(" You have the facial structure of a dog, wet nose and all, but overlaid with glittering [skin coat]");
				}
				break;

			case Face.WOLF:
				if (!player.hasCoat()) {
					outputText(" You have a wolf-like face, complete with a wet nose. ");
					if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth. ");
					outputText("The odd visage is hairless and covered with [skin coat]");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					outputText(".");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth. ");
					if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth. ");
					outputText("You've got [skin coat], hiding your [skin noadj] underneath your furry visage.");
				} else {
					outputText(" You have the facial structure of a wolf, wet nose and all, but overlaid with glittering [skin coat].");
					if (player.hasKeyItem("Fenrir Collar") >= 0) outputText(" Cold blue mist seems to periodically escape from your mouth.");
				}
				break;

			case Face.CAT:
			case Face.CHESHIRE:
				if (!player.hasCoat()) {
					outputText(" You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					outputText(".");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.");
				} else {
					outputText(" Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering [skin coat].");
				}
				if (faceType == Face.CHESHIRE) outputText(" For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
				break;

			case Face.CHESHIRE_SMILE:
				outputText(" Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your cat-like canines. For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
				break;

			case Face.COW_MINOTAUR:
				if (!player.hasCoat()) {
					outputText(" You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
				} else if (player.hasFullCoat()) {
					outputText(" Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
				} else {
					outputText(" Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
				}
				break;

			case Face.LIZARD:
				if (!player.hasCoat()) {
					outputText(" You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin].");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" You have a face resembling that of a lizard. Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.");
				} else if (player.hasFullCoat()) {
					outputText(" Your face is that of a lizard, complete with a toothy maw and pointed snout. Reflective [skin coat] complete the look, making you look quite fearsome.");
				} else {
					outputText(" You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin coat].");
				}
				break;

			case Face.DRAGON:
				outputText(" Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals several rows of dagger-like sharp teeth. The fearsome visage is decorated by [skin coat].");
				break;

			case Face.JABBERWOCKY:
				outputText(" Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals two buck tooth, which are abnormally large. Like a rabbit or rather a Jabberwocky. The fearsome visage is decorated by [skin coat].");
				break;

			case Face.PLANT_DRAGON:
				outputText(" Your face is a narrow, reptilian and regal, reminiscent of a dragon. A [skin coat] decorates your visage.");
				break;

			case Face.ORCA:
				if (skin.hasPlainSkinOnly() && player.skinAdj == "glossy" && player.skinTone == "white and black")
					outputText(" Your face is fairly human in shape save for a wider yet adorable nose. Your skin is pitch black with a white underbelly. From your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes. While at first one could mistake it for human skin, it has a glossy shine only found on sea animals.");
				else if (!player.hasFullCoat()) {
					if (skin.hasCoatOfType(Skin.SCALES, Skin.FUR)) {
						outputText(" You have a fairly normal face, with [skin base]. On your cheek you have [skin coat]");
					} else {
						outputText(" You have a fairly normal face, with [skin base]");
						if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
						else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
						else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					}
					outputText(". In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" Under your [skin coat] you have a human-shaped head with [skin base]. In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
				} else {
					outputText(" Your face is fairly human in shape, but is covered in [skin coat]. In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
				}
				break;

			case Face.KANGAROO:
				outputText(" Your face is ");
				if (player.hasCoat()) {
					outputText("covered with [skin coat]");
				} else {
					outputText("bald");
					switch (skin.base.adj) {
						case "sexy tattooed": outputText(" covered with magical tattoo"); break;
						case "battle tattooed": outputText(" covered with battle tattoo"); break;
						case "lightning shaped tattooed": outputText(" covered with a few glowing lightning tattoos"); break;
					}
				}
				outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.");
				break;

			case Face.PIG:
				outputText(" Your face is like that of a pig, with [skintone] skin, complete with a snout that is always wiggling.");
				break;

			case Face.BOAR:
				outputText(" Your face is like that of a boar, ");
				if (player.skinType == Skin.FUR) {
					outputText("with [skintone] skin underneath your [skin coat.color] fur");
				}
				outputText(", complete with tusks and a snout that is always wiggling.");
				break;

			case Face.RHINO:
				outputText(" Your face is like that of a rhino");
				if (!player.hasCoat()) {
					outputText(", with [skin], complete with a long muzzle and a horns on your nose");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					outputText(".");
				} else {
					outputText(" with a long muzzle and a horns on your nose. Oddly, your face is also covered in [skin coat].");
				}
				break;

			case Face.ECHIDNA:
				outputText(" Your odd visage consists of a long, thin echidna snout.");
				if (!player.hasCoat()) {
					outputText(" The [skin base]");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					outputText(" that is revealed by your lack of fur looks quite unusual.");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" It's covered in [skin coat].");
				} else {
					outputText(" It's covered in [skin coat], making your face even more unusual.");
				}
				break;

			case Face.DEER:
				outputText(" Your face is like that of a deer, with a nose at the end of your muzzle.");
				if (!player.hasCoat()) {
					outputText(" The [skin]");
					if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
					else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
					else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
					outputText(" that is revealed by your lack of fur looks quite unusual.");
				} else if (player.hasFullCoatOfType(Skin.FUR)) {
					outputText(" It's covered in [skin coat] that covers your [skintone] skin underneath.");
				} else {
					outputText(" It's covered in [skin coat], making your face looks more unusual.");
				}
				break;

			case Face.RED_PANDA:
				outputText(" Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose.");
				if (player.hasFullCoatOfType(Skin.FUR)) outputText(" A coat of soft, [skin coat.color] colored fur covers your head, with patches of white on your muzzle, cheeks and eyebrows.")
				break;

			case Face.AVIAN:
				outputText(" Your visage has a bird-like appearance, complete with an avian beak. A couple of small holes on it makes up for your nostrils, while a long, nimble tongue is hidden inside.");
				if (player.hasFullCoatOfType(Skin.FEATHER)) outputText(" The rest of your face is decorated with a coat of [skin coat].")
				break;
		}
		//</mod>
	}

	public function RacialScores():void {
		clearOutput();
		outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n");
		outputText("\nCHIMERA: " + player.chimeraScore());
		outputText("\nGRAND CHIMERA: " + player.grandchimeraScore());
		if (player.internalChimeraScore() >= 1) {
			outputText("\n<font color=\"#0000a0\">INTERNAL CHIMERICAL DISPOSITION: " + player.internalChimeraScore() + " (+" + (5 * player.internalChimeraScore()) + " max Str / Tou / Spe / Int / Wis / Lib)</font>");
		} else {
			outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0</font>");
		}
		outputText("\n\n");
		var metrics:* = Race.MetricsFor(player);
		for each (var race:Race in Race.RegisteredRaces) {
			outputText("<b>" + race.name + "</b>:\n<ul>");
			var simple:* = race.explainSimpleScore(metrics);
			/*
			 * simple = object{
			 *     total:int,
			 *     items:list[
			 *         item:object{
			 *             metric:string,
			 *             actual:*,
			 *             bonus:int,
			 *             checks:list[ pair[expected,bonus] ]
			 *         }
			 *     ]
			 * }
			 */
			for each (var item:* in simple.items) {
				outputText("<li>");
				var metric:String = item.metric;
				var actual:*      = item.actual;
				if (item.bonus == 0) outputText("<font color='#777777'>");
				outputText(metric + ": ");
				if (item.bonus == 0) outputText("</font>");
				for (var i:int = 0; i < item.checks.length; i++) {
					if (i != 0) outputText(", ");
					var check:* = item.checks[i];
					if (check[0] != actual) outputText("<font color='#777777'>");
					var bonus:String = (check[1] > 0 ? "+" : "") + check[1];
					outputText(bonus + " for " + Race.ExplainMetricValue(metric, check[0]));
					if (check[0] != actual) outputText("</font>");
				}

				outputText("</li>")
			}
			var complex:* = race.explainComplexScore(metrics);
			/*
			 * complex = object{
			 *     total:int,
			 *     items:list[
			 *         item:object{
			 *             checks:list[
			 *                 check:object{
			 *                     metric:string,
			 *                     actual:*,
			 *                     expected:* | list[*],
			 *                     passed:boolean
			 *                 }
			 *             ],
			 *             passed:boolean,
			 *             bonus:int
			 *         ]
			 *     ]
			 * }
			 */
			for each(item in complex.items) {
				outputText("<li>");
				if (!item.passed) outputText("<font color='#777777'>");
				bonus = (item.bonus > 0 ? "+" : "") + item.bonus;
				outputText(bonus + " for ");
				if (!item.passed) outputText("</font>");
				for (i = 0; i < item.checks.length; i++) {
					check = item.checks[i];
					if (i != 0) outputText(", ");
					if (check.passed) {
						outputText(Race.ExplainMetricValue(check.metric, check.actual));
					} else {
						outputText("<font color='#777777'>");
						if (check.expected is Array) {
							outputText(check.expected.map(function (el:*, i:int, a:Array):String {
								return Race.ExplainMetricValue(check.metric, el);
							}).join("/"));
						} else {
							outputText(Race.ExplainMetricValue(check.metric, check.expected));
						}
						outputText(" " + check.metric);
						outputText("</font>");
					}
				}
				outputText("</li>")
			}
			var total:int = race.scoreFor(player, metrics);
			if (total != simple.total + complex.total) {
				outputText("<li>+ some magic calculations</li>");
			}
			outputText("</ul>Total: " + total + "\n");
			var tierused:int = -1;
			for each(var tier:Array in race.bonusTiers) {
				if (total >= tier[0] && tier[0] > tierused) tierused = tier[0];
			}
			for each(tier in race.bonusTiers) {
				if (tier[0] != tierused) outputText("<font color='#777777'>");
				outputText("At " + tier[0] + ": ");
				for (bonus in tier[1]) {
					item = tier[1][bonus];
					outputText((item > 0 ? "+" : "") + item + " " + bonus + " ");
				}
				if (tier[0] != tierused) outputText("</font>");
				outputText("\n");
			}
			outputText("\n\n");
		}
		doNext(playerMenu);
	}

	public function GenderForcedSetting():void {
		clearOutput();
		outputText("This menu allows you to choose if the game will treat your character as a female or a male. Using the automatic option will let the game orginal system do the work instead of setting your sex in one or another way.");
		menu();
		addButton(0, "Next", playerMenu);
		addButton(1, "Auto", doSetForced, 0).disableIf(flags[kFLAGS.MALE_OR_FEMALE] == 0, "This is the currently used setting.");
		addButton(2, "Male", doSetForced, 1).disableIf(flags[kFLAGS.MALE_OR_FEMALE] == 1, "This is the currently used setting.");
		addButton(3, "Female", doSetForced, 2).disableIf(flags[kFLAGS.MALE_OR_FEMALE] == 2, "This is the currently used setting.");

		function doSetForced(value:int):void {
			flags[kFLAGS.MALE_OR_FEMALE] = value;
			doNext(GenderForcedSetting);
		}
	}

	public function sockDescript(index:int):void {
		outputText(" ");
		switch (player.cocks[index].sock) {
			case "wool":      outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");break;
			case "alabaster": outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");break;
			case "cockring":  outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");break;
			case "viridian":  outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns. Just wearing it makes your body, especially your cock, tingle.");break;
			case "scarlet":   outputText("It's covered by a lacey red cock-sock that clings tightly to your member. Just wearing it makes your cock throb, as if it yearns to be larger...");break;
			case "cobalt":    outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly. It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");break;
			case "gilded":    outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems. Despite the warmth of your body, the cock-sock remains cool.");break;
			case "red":   outputText("It's covered by a red cock-sock that seems to glow. Just wearing it makes you feel a bit powerful.");break;
			case "green": outputText("It's covered by a green cock-sock that seems to glow. Just wearing it makes you feel a bit healthier.");break;
			case "blue":  outputText("It's covered by a blue cock-sock that seems to glow. Just wearing it makes you feel like you can cast spells more effectively.");break;
			case "amaranthine":
				outputText("It's covered by a lacey purple cock-sock");
				if (player.cocks[index].cockType != CockTypesEnum.DISPLACER) {
					outputText(" that fits somewhat awkwardly on your member");
				} else {
					outputText(" that fits your coeurl cock perfectly");
				}
				outputText(". Just wearing it makes you feel stronger and more powerful.");
				break;
			default:      outputText("<b>Yo, this is an error.</b>");break;
		}
	}
}
}