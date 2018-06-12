///<reference path="typings/jquery.d.ts"/>
///<reference path="utils.ts"/>

namespace monsters {
	
	export function initMonsters() {
	
	}
	
	let loaded=false;
	$(()=>{
		$('a[href="#tab-monsters"]').on('shown.bs.tab', function (e) {
			if (!loaded) {
				loaded = true;
				initMonsters();
			}
		})
	});
}
