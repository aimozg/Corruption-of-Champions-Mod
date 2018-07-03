/**
 * Coded by aimozg on 03.07.2018.
 */
package coc.xxc.stmts {
import classes.CoC;
import classes.Modding.MonsterPrototype;
import classes.Scenes.SceneLib;

import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.StoryContext;

public class BattleStmt extends Statement {
	private var monsterref:String;
	private var options:Eval;
	public function BattleStmt(monsterref:String,options:String) {
		this.monsterref = monsterref;
		this.options = options?Eval.compile(options):null;
	}
	
	
	override public function execute(context:ExecContext):void {
		var game:CoC                          = (context as StoryContext).game;
		var mp:MonsterPrototype = game.findModMonster(monsterref);
		if (mp == null) {
			throw "Unable to find monster ref "+monsterref;
		}
		SceneLib.combat.startCombatImpl(mp.spawn(options?options.call(context.scopes):options));
	}
}
}
