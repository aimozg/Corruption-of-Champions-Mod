/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.Appearance;
import classes.BodyParts.Skin;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.SceneLib;

import coc.xlogic.ExecContext;

public class StoryContext extends ExecContext{
	public var game:CoC;
	private var _recording:Boolean = false;
	public var outputBuffer:String = "";
	public function get recording():Boolean {
		return _recording;
	}
	public function output(content:String):void {
		debug(this,'print');
		if (_recording) {
			outputBuffer += content;
		} else {
			EngineCore.outputText(content);
		}
	}
	public function startRecording():void {
		outputBuffer = "";
		_recording   = true;
	}
	public function stopRecording():String {
		var s:String = outputBuffer;
		outputBuffer = "";
		_recording   = false;
		return s;
	}
	public function StoryContext(game:CoC) {
		super([
			game,
			CoC,
			{
				Appearance:Appearance,
				CockTypesEnum:CockTypesEnum,
				kFLAGS:kFLAGS,
				kGAMECLASS:CoC.instance,
				Math:Math,
				SceneLib:SceneLib,
				Skin:Skin,
				silly:EngineCore.silly
			}
		]);
		this.game = game;
	}
}
}
