package config;

import flixel.util.FlxSave;

class SaveData {
	private var save:FlxSave = new FlxSave();
	
	public static inline var saveFileName:String = "saveone";
	public static inline var saveVersion:Int = 3;
	
	public var highestNight(get, set):Int;
	public var highestScore(get, set):Int;
	
	public function new() {
	}
	
	public function bind():Void {
		save.bind(saveFileName);
	}
	
	public function flush():Void {
		save.flush();
	}
	
	public function initSaveData(reset:Bool):Void {
		bind();
		
		if (reset || save.data.highestNightReached == null)			highestNight = 0;
		if (reset || save.data.highestKillsReached == null)			highestScore = 0;
		
		flush();
	}
	
	private function get_highestNight():Int { return save.data.highestNightReached; }
	private function set_highestNight(night:Int):Int { return save.data.highestNightReached = night; }
	
	private function get_highestScore():Int { return save.data.highestKillsReached; }
	private function set_highestScore(kills:Int):Int { return save.data.highestKillsReached = kills; }
}