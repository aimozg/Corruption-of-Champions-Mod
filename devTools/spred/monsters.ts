///<reference path="typings/jquery.d.ts"/>
///<reference path="utils.ts"/>
///<reference path="dump.ts"/>

enum SkinCoverages {
	NONE=0,
	LOW=1,
	MEDIUM=2,
	HIGH=3,
	COMPLETE=4
}
namespace monsters {
	
	import loadFile = utils.loadFile;
	import basedir = utils.basedir;
	import xmlget = utils.xmlget;
	import parseLength = utils.parseLength;
	import dictLookup = utils.dictLookup;
	import xmlgeti = utils.xmlgeti;
	import unindent = utils.unindent;
	
	interface Vagina {
		virgin?: boolean;
		wetness?: number;
		looseness?: number;
	}
	
	const DefaultVagina: Vagina = {
		virgin: true, wetness: 1, looseness: 0
	};
	
	interface BreastRow {
		size?: number;
		nipplesPerBreast?: number;
	}
	
	const DefaultBreastRow: BreastRow = {
		size: 0, nipplesPerBreast: 1
	};
	
	interface SkinData {
		coverage?: number;
		baseType?: SkinTypes;
		baseColor?: string;
		baseColor2?: string;
		baseAdj?: string;
		baseDesc?: string;
		basePattern?: SkinPatterns;
		coatType?: SkinTypes;
		coatColor?: string;
		coatColor2?: string;
		coatAdj?: string;
		coatDesc?: string;
		coatPattern?: SkinPatterns;
	}
	
	const DefaultSkinData: SkinData = {
		coverage   : 0,
		baseType   : SkinTypes.PLAIN,
		baseColor  : 'pale',
		baseColor2 : '',
		baseAdj    : '',
		baseDesc   : '',
		basePattern: SkinPatterns.PATTERN_NONE,
		coatType   : SkinTypes.PLAIN,
		coatColor  : 'pale',
		coatColor2 : '',
		coatAdj    : '',
		coatDesc   : '',
		coatPattern: SkinPatterns.PATTERN_NONE,
	};
	
	interface BodyData {
		height?: number;
		hipRating?: number;
		buttRating?: number;
		beardStyle?: BeardTypes;
		beardLength?: number;
		hairType?: HairTypes;
		hairColor?: string;
		hairLength?: number;
		
		antennaeType?: AntennaeTypes;
		armsType?: ArmTypes;
		clawsType?: ClawTypes;
		clawsTone?: string;
		earsType?: EarTypes;
		eyeCount?: number;
		eyeType?: EyeTypes;
		eyeColor?: string;
		faceType?: FaceTypes;
		gillsType?: GillTypes;
		hornsType?: HornTypes;
		hornsCount?: number;
		legsType?: LowerBodyTypes;
		legsCount?: number;
		rearBodyType?: RearBodyTypes;
		tailType?: TailTypes;
		tailsCount?: number;
		tongueType?: TongueTypes;
		wingsType?: WingTypes;
		
		analLooseness?: number;
		analWetness?: number;
	}
	
	const DefaultBodyData: BodyData = {
		height     : 0,
		hipRating  : 0,
		buttRating : 0,
		beardStyle : BeardTypes.NORMAL,
		beardLength: 0,
		hairType   : HairTypes.NORMAL,
		hairColor  : 'no',
		hairLength : 0,
		
		antennaeType: AntennaeTypes.NONE,
		armsType    : ArmTypes.HUMAN,
		clawsType   : ClawTypes.NORMAL,
		clawsTone   : '',
		earsType    : EarTypes.HUMAN,
		eyeCount    : 2,
		eyeType     : EyeTypes.HUMAN,
		eyeColor    : 'brown',
		faceType    : FaceTypes.HUMAN,
		gillsType   : GillTypes.NONE,
		hornsType   : HornTypes.NONE,
		hornsCount  : 0,
		legsType    : LowerBodyTypes.HUMAN,
		legsCount   : 2,
		rearBodyType: RearBodyTypes.NONE,
		tailType    : TailTypes.NONE,
		tailsCount  : 0,
		tongueType  : TongueTypes.HUMAN,
		wingsType   : WingTypes.NONE,
		
		analLooseness: 0,
		analWetness  : 0,
	};
	
	export interface MonsterData {
		name?: string;
		desc?: string;
		a?: string;
		plural?: boolean;
		level?: number;
		str?: number;
		tou?: number;
		spe?: number;
		int?: number;
		wis?: number;
		lib?: number;
		sen?: number;
		cor?: number;
		weaponName?: string;
		weaponVerb?: string;
		weaponAttack?: number;
		armorName?: string;
		armorDefense?: number;
		bonusHP?: number;
	}
	
	const DefaultData: MonsterData = {
		name      : '',
		desc      : '',
		a         : 'a ',
		plural    : false,
		level     : 1,
		str       : 1, tou: 1, spe: 1, int: 1, wis: 1, lib: 1, sen: 1, cor: 1,
		weaponName: '', weaponVerb: '', weaponAttack: 0,
		armorName : '', armorDefense: 0,
		bonusHP   : 0,
	};
	
	export class Monster {
		// text
		public base: string;
		
		get baseMonster(): Monster | undefined {
			return this.base ? lib[this.base] : undefined;
		}
		
		public data: MonsterData = {};
		public body: BodyData    = {};
		public skin: SkinData    = {};
		// combat
		/*
			element loot {
				loot
			}?
		}
		loot = element item { text }
		 */
		
		constructor(public id: string) {
		}
		
		public inherit(): Monster {
			let m    = new Monster(this.id);
			let base = this.baseMonster;
			m        = m.merge(base ? base.inherit() : Monster.DefaultMonster);
			return m.merge(this);
		}
		
		public merge(m: Monster): Monster {
			this.data = $.extend(this.data, m.data);
			this.body = $.extend(this.body, m.body);
			this.skin = $.extend(this.skin, m.skin);
			return this;
		}
		
		public static DefaultMonster = ((m: Monster) => {
			m.data = $.extend({}, DefaultData);
			m.body = $.extend({}, DefaultBodyData);
			m.skin = $.extend({}, DefaultSkinData);
			return m
		})(new Monster(undefined))
	}
	
	export function loadMonster(x: Element): Monster {
		let m                = new Monster(x.getAttribute('id'));
		m.base               = xmlget(x, '@base');
		m.data.a             = xmlget(x, 'a');
		m.data.name          = xmlget(x, 'name');
		m.data.desc          = unindent(xmlget(x, 'desc'));
		
		m.body.height        = parseLength(xmlget(x, 'body > height'));
		m.body.hipRating     = xmlgeti(x, 'body > hips');
		m.body.buttRating    = xmlgeti(x, 'body > butt');
		m.body.beardStyle    = dictLookup(BeardTypes, xmlget(x, 'body > beard@style'));
		m.body.beardLength   = parseLength(xmlgeti(x, 'body > beard@length'));
		m.body.hairType      = dictLookup(HairTypes, xmlget(x, 'body > hair@type'));
		m.body.hairColor     = xmlget(x, 'body > hair@color');
		m.body.hairLength    = parseLength(xmlget(x, 'body > hair@length'));
		
		m.skin.coverage = dictLookup(SkinCoverages, xmlget(x, 'body > skin@coverage'));
		m.skin.baseType = dictLookup(SkinTypes, xmlget(x, 'body > skin > base@type'));
		m.skin.baseColor = xmlget(x, 'body > skin > base@color');
		m.skin.baseColor2 = xmlget(x, 'body > skin > base@color2');
		m.skin.baseAdj = xmlget(x, 'body > skin > base@adj');
		m.skin.baseDesc = xmlget(x, 'body > skin > base@desc');
		m.skin.basePattern = dictLookup(SkinPatterns, xmlget(x, 'body > skin > base@pattern'));
		m.skin.coatType = dictLookup(SkinTypes, xmlget(x, 'body > skin > coat@type'));
		m.skin.coatColor = xmlget(x, 'body > skin > coat@color');
		m.skin.coatColor2 = xmlget(x, 'body > skin > coat@color2');
		m.skin.coatAdj = xmlget(x, 'body > skin > coat@adj');
		m.skin.coatDesc = xmlget(x, 'body > skin > coat@desc');
		m.skin.coatPattern = dictLookup(SkinPatterns, xmlget(x, 'body > skin > coat@pattern'));
		
		m.body.antennaeType  = dictLookup(AntennaeTypes, xmlget(x, 'body > antennae'));
		m.body.armsType      = dictLookup(ArmTypes, xmlget(x, 'body > arms'));
		m.body.clawsType     = dictLookup(ClawTypes, xmlget(x, 'body > claws@type'));
		m.body.clawsTone     = xmlget(x, 'body > claws@tone');
		m.body.earsType      = dictLookup(EarTypes, xmlget(x, 'body > ears'));
		m.body.eyeCount      = xmlgeti(x, 'body > eyes@count');
		m.body.eyeType       = dictLookup(EyeTypes, xmlget(x, 'body > eyes@type'));
		m.body.eyeColor      = xmlget(x, 'body > eyes@color');
		m.body.faceType      = dictLookup(FaceTypes, xmlget(x, 'body > face'));
		m.body.gillsType     = dictLookup(GillTypes, xmlget(x, 'body > gills'));
		m.body.hornsType     = dictLookup(HornTypes, xmlget(x, 'body > horns@type'));
		m.body.hornsCount    = xmlgeti(x, 'body > horns@count');
		m.body.legsType      = dictLookup(LowerBodyTypes, xmlget(x, 'body > legs@type'));
		m.body.legsCount     = xmlgeti(x, 'body > legs@count');
		m.body.rearBodyType  = dictLookup(RearBodyTypes, xmlget(x, 'body > rearBody'));
		m.body.tailType      = dictLookup(TailTypes, xmlget(x, 'body > tail@type'));
		m.body.tailsCount    = xmlgeti(x, 'body > tail@count');
		m.body.tongueType    = dictLookup(TongueTypes, xmlget(x, 'body > tongue'));
		m.body.wingsType     = dictLookup(WingTypes, xmlget(x, 'body > wings'));
		
		m.body.analLooseness = xmlgeti(x, 'body > anal@looseness');
		m.body.analWetness   = xmlgeti(x, 'body > anal@wetness');
		
		m.data.level         = xmlgeti(x, 'combat > level');
		m.data.str           = xmlgeti(x, 'combat > str');
		m.data.tou           = xmlgeti(x, 'combat > tou');
		m.data.spe           = xmlgeti(x, 'combat > spe');
		m.data.int           = xmlgeti(x, 'combat > int');
		m.data.wis           = xmlgeti(x, 'combat > wis');
		m.data.lib           = xmlgeti(x, 'combat > lib');
		m.data.sen           = xmlgeti(x, 'combat > sen');
		m.data.cor           = xmlgeti(x, 'combat > cor');
		m.data.weaponName    = xmlget(x, 'combat > weapon@name');
		m.data.weaponVerb    = xmlget(x, 'combat > weapon@verb');
		m.data.weaponAttack  = xmlgeti(x, 'combat > weapon@attack');
		m.data.armorName     = xmlget(x, 'combat > armor@name');
		m.data.armorDefense  = xmlgeti(x, 'combat > armor@defense');
		m.data.bonusHP       = xmlgeti(x, 'combat > bonusHP');
		
		for (let k in m.data) if (m.data[k] === undefined) delete m.data[k];
		for (let k in m.body) if (m.body[k] === undefined) delete m.body[k];
		for (let k in m.skin) if (m.skin[k] === undefined) delete m.skin[k];
		return m;
	}
	
	export let lib: { [index: string]: Monster }   = {};
	export let currentMonster: Monster | undefined = undefined;
	
	function forEachMonsterInput(cb: (input: JQuery) => void) {
		$('#monsterEditor [data-mget]').each((i, e) => {
			cb($(e));
		});
	}
	
	export function showMonster(m: Monster) {
		m = m.inherit();
		let monsterList = $('#monsterList');
		let monsterBase = $('#monster-base');
		monsterList.find('.list-group-item.active').removeClass('active');
		monsterList.find('.list-group-item[href="#' + m.id + '"]').addClass('active');
		currentMonster = m;
		monsterBase.find('option').removeAttr('disabled');
		monsterBase.find('option[value=' + m.id + ']').attr('disabled', 'true');
		
		forEachMonsterInput(e => {
			e.val(eval(e.attr('data-mget')));
		});
	}
	
	export function listMonsters() {
		let j1 = $('#monsterList');
		let j2 = $('#monster-base');
		j1.html('');
		j2.html('');
		j2.append($('<option>').html('(No prototype)').val(''));
		for (let id in lib) {
			let m: Monster = lib[id].inherit();
			let name       = id + ' (' + m.data.name + ' lvl ' + m.data.level + ')';
			j1.append($('<a>')
				.addClass('list-group-item list-group-item-action')
				.attr('href', '#' + id)
				.html(name)
				.attr('role', 'tab')
				.click((e) => {
					showMonster(lib[e.target.getAttribute('href').substring(1)]);
					e.stopPropagation();
				})
			);
			j2.append($('<option>').val(id).html(name));
		}
	}
	
	export function loadMod(data: XMLDocument) {
		let xmod = $(data).children('mod');
		lib      = {};
		xmod.find('monster').each((i, e) => {
			let m     = loadMonster(e);
			lib[m.id] = m;
		});
		listMonsters();
		showMonster(lib[Object.keys(lib)[0]]);
	}
	
	export function initMonsters() {
		loadFile(basedir + 'content/coc/NPC/diva2.xml', 'xml')
			.then(loadMod);
	}
	
	let loaded = false;
	$(() => {
		$('#monster-beard-style').append(utils.enumAsOptions(BeardTypes));
		$('#monster-hair-type').append(utils.enumAsOptions(HairTypes));
		$('#monster-antennae-type').append(utils.enumAsOptions(AntennaeTypes));
		$('#monster-arms-type').append(utils.enumAsOptions(ArmTypes));
		$('#monster-claws-type').append(utils.enumAsOptions(ClawTypes));
		$('#monster-ears-type').append(utils.enumAsOptions(EarTypes));
		$('#monster-eye-type').append(utils.enumAsOptions(EyeTypes));
		$('#monster-face-type').append(utils.enumAsOptions(FaceTypes));
		$('#monster-gills-type').append(utils.enumAsOptions(GillTypes));
		$('#monster-horns-type').append(utils.enumAsOptions(HornTypes));
		$('#monster-legs-type').append(utils.enumAsOptions(LowerBodyTypes));
		$('#monster-rearBody-type').append(utils.enumAsOptions(RearBodyTypes));
		$('#monster-tail-type').append(utils.enumAsOptions(TailTypes));
		$('#monster-tongue-type').append(utils.enumAsOptions(TongueTypes));
		$('#monster-wings-type').append(utils.enumAsOptions(WingTypes));
		$('#monster-skin-coverage').append(utils.enumAsOptions(SkinCoverages));
		$('#monster-skin-base-type').append(utils.enumAsOptions(SkinTypes));
		$('#monster-skin-base-pattern').append(utils.enumAsOptions(SkinPatterns));
		$('#monster-skin-coat-type').append(utils.enumAsOptions(SkinTypes));
		$('#monster-skin-coat-pattern').append(utils.enumAsOptions(SkinPatterns));
		$('a[href="#tab-monsters"]').on('shown.bs.tab', function (e) {
			if (!loaded) {
				loaded = true;
				initMonsters();
			}
		})
	});
}
