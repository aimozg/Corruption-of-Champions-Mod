///<reference path="typings/jquery.d.ts"/>
///<reference path="utils.ts"/>
///<reference path="dump.ts"/>

namespace monsters {
	
	import loadFile = utils.loadFile;
	import basedir = utils.basedir;
	import xmlget = utils.xmlget;
	import parseLength = utils.parseLength;
	import dictLookup = utils.dictLookup;
	import xmlgeti = utils.xmlgeti;
	
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
		skinCoverage?: number;
		baseType?: number;
		baseColor?: string;
		baseColor2?: string;
		baseAdj?: string;
		baseDesc?: string;
		basePattern?: number;
		coatType?: number;
		coatColor?: string;
		coatColor2?: string;
		coatAdj?: string;
		coatDesc?: string;
		coatPattern?: number;
	}
	
	const DefaultSkinData: SkinData = {
		skinCoverage: 0,
		baseType    : SkinTypes.PLAIN,
		baseColor   : 'pale',
		baseColor2  : '',
		baseAdj     : '',
		baseDesc    : '',
		basePattern : SkinPatterns.PATTERN_NONE,
		coatType    : SkinTypes.PLAIN,
		coatColor   : 'pale',
		coatColor2  : '',
		coatAdj     : '',
		coatDesc    : '',
		coatPattern : SkinPatterns.PATTERN_NONE,
	};
	
	interface BodyData {
		height?: number;
		hipRating?: number;
		buttRating?: number;
		beardStyle?: number;
		beardLength?: number;
		hairType?: number;
		hairColor?: string;
		hairLength?: number;
		
		antennaeType?: number;
		armsType?: number;
		clawsType?: number;
		clawsTone?: string;
		earsType?: number;
		eyeCount?: number;
		eyeType?: number;
		eyeColor?: string;
		faceType?: number;
		gillsType?: number;
		hornsType?: number;
		hornsCount?: number;
		legsType?: number;
		legsCount?: number;
		rearBodyType?: number;
		tailType?: number;
		tailsCount?: number;
		tongueType?: number;
		wingsType?: number;
		
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
	
	interface MonsterData {
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
	
	class Monster {
		// text
		public base: string;
		
		get baseMonster(): Monster | undefined {
			return this.base ? lib[this.base] : undefined;
		}
		
		public data: MonsterData = {};
		public body: BodyData    = {};
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
			if (!base) return m.merge(Monster.DefaultMonster);
			return m.merge(base.inherit());
		}
		
		public merge(m: Monster): Monster {
			this.data = $.extend(this.data, m.data);
			this.body = $.extend(this.body, m.body);
			return this;
		}
		
		public static DefaultMonster = ((m: Monster) => {
			m.data = $.extend({}, DefaultData);
			m.body = $.extend({}, DefaultBodyData);
			return m
		})(new Monster(undefined))
	}
	
	export function loadMonster(x: Element): Monster {
		let m               = new Monster(x.getAttribute('id'));
		m.base              = xmlget(x, '@base');
		m.data.a            = xmlget(x, 'a');
		m.data.name         = xmlget(x, 'name');
		m.data.desc         = xmlget(x, 'desc');
		if (m.data.desc) m.data.desc = m.data.desc.replace(/ {2,}/g,' ');
		m.body.height       = parseLength(xmlget(x, 'body > height'));
		m.body.hairType     = dictLookup(HairTypes, xmlget(x, 'body > hair@type'));
		m.body.hairColor    = xmlget(x, 'body > hair@color');
		m.body.hairLength   = parseLength(xmlget(x, 'body > hair@length'));
		m.body.wingsType    = dictLookup(WingTypes, xmlget(x, 'body > wings'));
		m.data.level        = xmlgeti(x, 'combat > level');
		m.data.str          = xmlgeti(x, 'combat > str');
		m.data.tou          = xmlgeti(x, 'combat > tou');
		m.data.spe          = xmlgeti(x, 'combat > spe');
		m.data.int          = xmlgeti(x, 'combat > int');
		m.data.wis          = xmlgeti(x, 'combat > wis');
		m.data.lib          = xmlgeti(x, 'combat > lib');
		m.data.sen          = xmlgeti(x, 'combat > sen');
		m.data.cor          = xmlgeti(x, 'combat > cor');
		m.data.weaponName   = xmlget(x, 'combat > weapon@name');
		m.data.weaponVerb   = xmlget(x, 'combat > weapon@verb');
		m.data.weaponAttack = xmlgeti(x, 'combat > weapon@attack');
		m.data.armorName    = xmlget(x, 'combat > armor@name');
		m.data.armorDefense = xmlgeti(x, 'combat > armor@defense');
		m.data.bonusHP      = xmlgeti(x, 'combat > bonusHP');
		for (let k in m.data) if (m.data[k] === undefined) delete m.data[k];
		for (let k in m.body) if (m.body[k] === undefined) delete m.body[k];
		return m;
	}
	
	export let lib: Dict<Monster>                  = {};
	export let currentMonster: Monster | undefined = undefined;
	
	export function showMonster(m: Monster) {
		let monsterList = $('#monsterList');
		let monsterBase = $('#monster-base');
		monsterList.find('.list-group-item.active').removeClass('active');
		monsterList.find('.list-group-item[href="#' + m.id + '"]').addClass('active');
		currentMonster = m;
		monsterBase.find('option').removeAttr('disabled');
		monsterBase.find('option[value='+m.id+']').attr('disabled','true');
		
		$('#monster-id').val(m.id);
		monsterBase.val(m.base || '');
		$('#monster-name').val(m.data.name);
		$('#monster-a').val(m.data.a);
		$('#monster-desc').val(m.data.desc);
		$('#monster-level').val(m.data.level);
		$('#monster-str').val(m.data.str);
		$('#monster-tou').val(m.data.tou);
		$('#monster-spe').val(m.data.spe);
		$('#monster-int').val(m.data.int);
		$('#monster-wis').val(m.data.wis);
		$('#monster-lib').val(m.data.lib);
		$('#monster-sen').val(m.data.sen);
		$('#monster-cor').val(m.data.cor);
		$('#monster-bonushp').val(m.data.bonusHP);
	}
	
	export function listMonsters() {
		let j1 = $('#monsterList');
		let j2 = $('#monster-base');
		j1.html('');
		j2.html('');
		j2.append($('<option>').html('(No prototype)').val(''));
		for (let id in lib) {
			let m    = lib[id].inherit();
			let name = id + ' (' + m.data.name + ' lvl ' + m.data.level + ')';
			j1.append($('<a>')
				.addClass('list-group-item list-group-item-action')
				.attr('href', '#' + id)
				.html(name)
				.attr('role', 'tab')
				.click((e) => {
					showMonster(lib[e.target.getAttribute('href').substring(1)]);
					e.stopPropagation();
				})
			)
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
		$('a[href="#tab-monsters"]').on('shown.bs.tab', function (e) {
			if (!loaded) {
				loaded = true;
				initMonsters();
			}
		})
	});
}
