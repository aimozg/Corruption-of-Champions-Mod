package coc.view {
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Player;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.Stats.BuffableStat;
import classes.Stats.IStat;
import classes.Stats.PrimaryStat;
import classes.internals.Utils;

import flash.events.MouseEvent;

import flash.text.TextField;
import flash.text.TextFormat;

public class StatsView extends Block {
	[Embed(source = "../../../res/ui/sidebar1.png")]
	public static var SidebarBg1:Class;
	[Embed(source = "../../../res/ui/sidebar2.png")]
	public static var SidebarBg2:Class;
	[Embed(source = "../../../res/ui/sidebar3.png")]
	public static var SidebarBg3:Class;
	[Embed(source = "../../../res/ui/sidebar4.png")]
	public static var SidebarBg4:Class;
	[Embed(source = "../../../res/ui/sidebarKaizo.png")]
	public static var SidebarBgKaizo:Class;
	public static var SidebarBackgrounds:Array = [SidebarBg1,SidebarBg1,SidebarBg2,SidebarBg3,SidebarBg4,null,SidebarBgKaizo];
	public static const ValueFontOld:String    = 'Lucida Sans Typewriter';
	public static const ValueFont:String       = 'Georgia';
	
	public static const LABEL_FORMAT:Object = {
		font:'Times New Roman',
		bold:true,
		size:22
	};
	public static const TEXT_FORMAT:Object = {
		font:ValueFont,
		size:16
	};
	public static const TIME_FORMAT:Object = {
		font:'Lucida Sans Typewriter',
		size:18
	};

	private var sideBarBG:BitmapDataSprite;
	private var nameText:TextField;
	private var coreStatsText:TextField;
	private var combatStatsText:TextField;
	private var advancementText:TextField;
	private var timeText:TextField;
	private var strBar:StatBar;
	private var touBar:StatBar;
	private var speBar:StatBar;
	private var intBar:StatBar;
	private var wisBar:StatBar;
	private var libBar:StatBar;
	private var senBar:StatBar;
	private var corBar:StatBar;
	private var hpBar:StatBar;
	private var wrathBar:StatBar;
	private var lustBar:StatBar;
	private var fatigueBar:StatBar;
	private var manaBar:StatBar;
	private var kiBar:StatBar;
	private var hungerBar:StatBar;
	private var levelBar:StatBar;
	private var xpBar:StatBar;
	private var gemsBar:StatBar;

	private var allStats:/*StatBar*/Array;

	private var mainView:MainView;

	public function StatsView(mainView:MainView) {
		super({
			x    : MainView.STATBAR_X,
			y    : MainView.STATBAR_Y,
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			layoutConfig: {
				padding: MainView.GAP,
				type: 'flow',
				direction: 'column',
				ignoreHidden: true,
				gap: 1
			}
		});
		this.mainView = mainView;
		StatBar.setDefaultOptions({
			barColor: '#600000',
			width: innerWidth
		});
		sideBarBG     = addBitmapDataSprite({
			width: MainView.STATBAR_W,
			height: MainView.STATBAR_H,
			stretch: true
		},{ ignore:true });
		nameText      = addTextField({
			defaultTextFormat: LABEL_FORMAT
		});
		coreStatsText = addTextField({
			text: 'Core stats:',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		addElement(strBar = new StatBar({
			statName: "Strength:",
			dataset: { statname: 'str' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(touBar = new StatBar({
			statName: "Toughness:",
			dataset: { statname: 'tou' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(speBar = new StatBar({
			statName: "Speed:",
			dataset: { statname: 'spe' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(intBar = new StatBar({
			statName: "Intelligence:",
			dataset: { statname: 'int' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(wisBar = new StatBar({
			statName: "Wisdom:",
			dataset: { statname: 'wis' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(libBar = new StatBar({
			statName: "Libido:",
			dataset: { statname: 'lib' },
			onrollOver: hoverStat,
			onrollOut: hoverStat
		}));
		addElement(senBar = new StatBar({statName: "Sensitivity:"}));
		addElement(corBar = new StatBar({statName: "Corruption:"}));
		combatStatsText = addTextField({
			text: 'Combat stats',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		addElement(hpBar = new StatBar({
			statName: "HP:",
			barColor: '#008000',
			bgColor : '#ff0000',
			showMax : true
		}));
		addElement(lustBar = new StatBar({
			statName   : "Lust:",
		//	barColor   : '#ff1493',
			minBarColor: '#ff0000',
			hasMinBar  : true,
			showMax    : true
		}));
		addElement(wrathBar = new StatBar({
			statName: "Wrath:",
			showMax : true
		}));
		addElement(fatigueBar = new StatBar({
			statName: "Fatigue:",
			showMax : true
		}));
		addElement(manaBar = new StatBar({
			statName: "Mana:",
		//	barColor: '#0000ff',
			showMax : true
		}));
		addElement(kiBar = new StatBar({
			statName: "Ki:",
		//	barColor: '#ffd700',
			showMax : true
		}));
		addElement(hungerBar = new StatBar({
			statName: "Satiety:",
			showMax : true
		}));
		advancementText = addTextField({
			text:'Advancement',
			defaultTextFormat: LABEL_FORMAT
		},{before:1});
		addElement(levelBar = new StatBar({
			statName: "Level:",
			hasBar  : false
		}));
		addElement(xpBar = new StatBar({
			statName: "XP:"
		}));
		addElement(gemsBar = new StatBar({
			statName: "Gems:",
			hasBar: false
		}));
		timeText = addTextField({
			htmlText: '<u>Day#: 0</u>\nTime: 00:00',
			defaultTextFormat: TIME_FORMAT
		},{before:1});
		///////////////////////////
		allStats = [];
		for (var ci:int = 0, cn:int = this.numElements; ci < cn; ci++) {
			var e:StatBar = this.getElementAt(ci) as StatBar;
			if (e) allStats.push(e);
		}
	}
	
	private function hoverStat(event:MouseEvent):void {
		var player:Player = CoC.instance.player;
		switch (event.type) {
			case MouseEvent.ROLL_OVER:
				var bar:StatBar = event.target as StatBar;
				if (!bar) return;
				var statname:String  = bar.dataset.statname;
				var stat:PrimaryStat = player.findPrimaryStat(statname);
				if (!stat) return;
				var text:String            = '';
				text += '<b>Base value:</b> ' + Utils.floor(stat.core.value, 1) + '\n';
				var buffs:/*Buff*/Array = stat.mult.listBuffs();
				var hasHidden:Boolean = false;
				for each(var buff:Buff in buffs) {
					var value:Number = buff.value;
					if (value >= 0.0 && value < 0.01) continue;
					if (!buff.show) {
						hasHidden = true;
						continue;
					}
					text += '<b>' + buff.text + ':</b> ';
					text += (value >= 0 ? '+' : '') + Utils.floor(value * 100) + '%';
					text += '\n';
				}
				buffs = stat.bonus.listBuffs();
				for each(buff in buffs) {
					value = buff.value;
					if (value >= 0.0 && value < 0.1) continue;
					if (!buff.show) {
						hasHidden = true;
						continue;
					}
					text += '<b>' + buff.text + ':</b> ' + (value >= 0 ? '+' : '') + Utils.floor(value, 1) + '\n';
				}
				if (hasHidden) text += '<b>Unknown Sources:</b> ±??\n';
				text += '\n';
				text += '<b>Total:</b> ' + Utils.floor(stat.value, 1);
				mainView.toolTipView.header = bar.nameLabel.text.replace(':', '') + ' ' +
											  Utils.floor(stat.value) + ' / ' +
											  Utils.floor(stat.max);
				mainView.toolTipView.text   = text;
				
				mainView.toolTipView.showForElement(bar);
				break;
			case MouseEvent.ROLL_OUT:
				mainView.toolTipView.hide();
				break;
		}
	}

	public function show():void {
		this.visible = true;
	}

	public function hide():void {
		this.visible = false;
	}

	// <- hideUpDown
	public function hideUpDown():void {
		var ci:int, cc:int = this.allStats.length;
		for (ci = 0; ci < cc; ++ci) {
			var c:StatBar = this.allStats[ci];
			c.isUp        = false;
			c.isDown      = false;
		}
	}

	public function showLevelUp():void {
		this.levelBar.isUp = true;
	}

	public function hideLevelUp():void {
		this.levelBar.isUp = false;
	}

	public function statByName(statName:String):StatBar {
		switch (statName.toLowerCase()) {
			case 'str':
				return strBar;
			case 'tou':
				return touBar;
			case 'spe':
				return speBar;
			case 'inte':
			case 'int':
				return intBar;
			case 'wis':
				return wisBar;
			case 'lib':
				return libBar;
			case 'sens':
			case 'sen':
				return senBar;
			case 'cor':
				return corBar;
			case 'hp':
				return hpBar;
			case 'wrath':
				return wrathBar;
			case 'lust':
				return lustBar;
			case 'fatigue':
				return fatigueBar;
			case 'mana':
				return manaBar;
			case 'ki':
				return kiBar;
			case 'hunger':
				return hungerBar;
			case 'level':
				return levelBar;
			case 'xp':
				return xpBar;
			case 'gems':
				return gemsBar;
		}
		return null;
	}
	public function showStatUp(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isUp        = true;
		else trace("[ERROR] Cannot showStatUp "+statName);
	}

	public function showStatDown(statName:String):void {
		var stat:StatBar = statByName(statName);
		if (stat) stat.isDown      = true;
		else trace("[ERROR] Cannot showStatDown "+statName);
	}
	public function toggleHungerBar(show:Boolean):void {
		hungerBar.visible = show;
		invalidateLayout();
	}
	public function refreshStats(game:CoC):void {
		var player:Player            = game.player;
		var maxes:Object      = player.getAllMaxStats();
		nameText.htmlText     = "<b>Name: " + player.short + "</b>";
		for each(var e:StatBar in allStats) {
			if (!e.dataset.statname) continue;
			var stat:PrimaryStat = player.findPrimaryStat(e.dataset.statname);
			if (!stat) continue;
			e.maxValue = stat.max;
			e.value = stat.value;
			if (stat.bonus.value > 0) {
				e.valueLabel.textColor = Color.fromRgb(0x10,0x8f,0x10);
			} else if (stat.bonus.value < 0) {
				e.valueLabel.textColor = Color.fromRgb(0xaf,0x10,0x10);
			} else {
				e.valueLabel.textColor = e.valueLabel.defaultTextFormat.color as uint;
			}
		}
		senBar.maxValue       = maxes.sens;
		senBar.value          = player.sens;
		corBar.value          = player.cor;
		hpBar.maxValue        = player.maxHP();
		hpBar.value           = player.HP;
		wrathBar.maxValue 	  = player.maxWrath();
		wrathBar.value    	  = player.wrath;
		lustBar.maxValue      = player.maxLust();
		lustBar.minValue      = player.minLust();
		lustBar.value         = player.lust;
		fatigueBar.maxValue   = player.maxFatigue();
		fatigueBar.value      = player.fatigue;
		manaBar.maxValue 	  = player.maxMana();
		manaBar.value    	  = player.mana;
		kiBar.maxValue        = player.maxKi();
		kiBar.value           = player.ki;
		hungerBar.maxValue    = player.maxHunger();
		hungerBar.value       = player.hunger;
		/* okay that needs to be done properly (blinking?)
		if (player.hunger < 25) {
			hungerBar.statName = '/!\\ Satiety:';
		} else {
			hungerBar.statName = 'Satiety:';
		}
		*/
		advancementText.htmlText = "<b>Advancement</b>";
		levelBar.value           = player.level;
		if (player.level < CoC.instance.levelCap) {
			xpBar.maxValue = player.requiredXP();
			xpBar.value    = player.XP;
		} else {
			xpBar.maxValue  = player.XP;
			xpBar.value     = player.XP;
			xpBar.valueText = 'MAX';
		}
		gemsBar.valueText = Utils.addComma(Math.floor(player.gems));

		var minutesDisplay:String = "" + game.model.time.minutes;
		if (minutesDisplay.length == 1) minutesDisplay = "0" + minutesDisplay;

		var hours:Number = game.model.time.hours;
		var hrs:String, ampm:String;
		if (game.flags[kFLAGS.USE_12_HOURS] == 0) {
			hrs  = "" + hours;
			ampm = "";
		} else {
			hrs  = (hours % 12 == 0) ? "12" : "" + (hours % 12);
			ampm = hours < 12 ? "am" : "pm";
		}
		timeText.htmlText = "<u>Day#: " + game.model.time.days + "</u>"+
						"\nTime: " + hrs + ":" + minutesDisplay + ampm;

		invalidateLayout();
	}

	public function setBackground(bitmapClass:Class):void {
		sideBarBG.bitmapClass = bitmapClass;
	}
	public function setTheme(font:String,
							 textColor:uint,
							 barAlpha:Number):void {
		var dtf:TextFormat;
		for each(var e:StatBar in allStats) {
			dtf = e.valueLabel.defaultTextFormat;
			dtf.color = textColor;
			dtf.font = font;
			e.valueLabel.defaultTextFormat = dtf;
			e.valueLabel.setTextFormat(dtf);
			e.nameColor = textColor;
			if (e.bar) e.bar.alpha    = barAlpha;
			if (e.minBar) e.minBar.alpha = (1 - (1 - barAlpha) / 2); // 2 times less transparent than bar
		}
		for each(var tf:TextField in [nameText,coreStatsText,combatStatsText,advancementText,timeText]) {
			dtf = tf.defaultTextFormat;
			dtf.color = textColor;
			tf.defaultTextFormat = dtf;
			tf.setTextFormat(dtf);
		}
	}
}
}