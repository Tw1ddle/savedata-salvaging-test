package;

import config.SaveData;
import flash.Lib;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.system.scaleModes.RatioScaleMode;
import states.RootState;

class Main extends Sprite {
	public static var saveData(default, null):SaveData;
	
	private var gameWidth:Int = 800; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	private var gameHeight:Int = 500; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	
	private var initialState:Class<FlxState> = RootState;
	
	private var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	private var framerate:Int = 60; // How many frames per second the game should run at.
	private var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	private var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	
	static public function main():Void {
		Lib.current.addChild(new Main());
	}
	
	public function new() {
		super();
		
		if (stage != null) {
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void  {
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		// NOTE potential problematic bit, make sure the camera bounds and rendering is correct with this
		if (zoom == -1) {
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}
		zoom = 1;
		
		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom,
		                     framerate, framerate, skipSplash, startFullscreen));
		
		FlxG.scaleMode = new RatioScaleMode();
		FlxG.fixedTimestep = false;
		
		// NOTE this has to be set up as early as possible to avoid access-before-init bugs
		// However it has to be after the FlxGame object has been created because FlxSave and other Flixel stuff
		// may be accessing FlxG and other global objects!
		Main.saveData = new SaveData();
		Main.saveData.initSaveData(false);
	}
}