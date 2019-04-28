package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import extension.mobileprefs.MobilePrefs;
import extension.mobileprefs.SaveDataSalvager;
import extension.mobileprefs.SaveDataSalvagingResult;
import config.SaveData;
import flixel.FlxG;

class RootState extends FlxState
{
	private var text:FlxText = new FlxText(0, 20);
	
	private var createOldSavedataButton:FlxButton;
	
	private var printOldSavedataButton:FlxButton;
	private var clearOldSavedataButton:FlxButton;
	
	private var salvageOldSavedataButton:FlxButton;
	private var printNewSavedataButton:FlxButton;
	private var clearNewSavedataButton:FlxButton;
	private var flushNewSavedataButton:FlxButton;
	
	override public function create():Void {
		super.create();
		
		createOldSavedataButton = new FlxButton(0, 0, "Create Old Save", function() {
			appendMessage("Creating fake old savedata...");
			
			var highestNight = "8999";
			var highestKills = "9001";
			
			appendMessage("Highest night = " + MobilePrefs.getUserPreference(highestNight));
			appendMessage("Highest kills = " + MobilePrefs.getUserPreference(highestKills));
			
			MobilePrefs.setUserPreference("highestNightReached", highestNight);
			MobilePrefs.setUserPreference("highestKillsReached", highestKills);
		});
		
		printOldSavedataButton = new FlxButton(0, 0, "Print Old Save", function() {
			appendMessage("Printing out old savedata...");
			
			appendMessage("Highest night = " + MobilePrefs.getUserPreference("highestNightReached"));
			appendMessage("Highest kills = " + MobilePrefs.getUserPreference("highestKillsReached"));
		});
		clearOldSavedataButton = new FlxButton(0, 0, "Clear Old Save", function() {
			appendMessage("Clearing old savedata...");
			
			MobilePrefs.clearUserPreference("highestNightReached");
			MobilePrefs.clearUserPreference("highestKillsReached");
		});
		
		salvageOldSavedataButton = new FlxButton(0, 0, "Salvage Old Save", function() {
			appendMessage("Salvaging old savedata, writing it to new file + deleting old file");
			
			var result = SaveDataSalvager.salvageSaveData("saveone");
			appendMessage("Salvaging result: " + Std.string(result));
		});
		
		printNewSavedataButton = new FlxButton(0, 0, "Print New Save", function() {
			appendMessage("Printing out new savedata...");
			
			appendMessage("Highest night = " + Main.saveData.highestNight);
			appendMessage("Highest kills = " + Main.saveData.highestScore);
		});
		clearNewSavedataButton = new FlxButton(0, 0, "Clear New Save", function() {
			appendMessage("Clearing out new savedata...");
			
			Main.saveData.initSaveData(true);
		});
		flushNewSavedataButton = new FlxButton(0, 0, "Flush New Save", function() {
			appendMessage("Flushing new savedata...");
			
			Main.saveData.flush();
		});
		
		add(text);
		
		var i = 1;
		for (button in [createOldSavedataButton, printOldSavedataButton, clearOldSavedataButton, salvageOldSavedataButton, printNewSavedataButton, clearNewSavedataButton, flushNewSavedataButton]) {
			button.x = i * 80 + button.width;
			i++;
			button.y = FlxG.height * 0.8;
			add(button);
		}
		
		appendMessage("Press some buttons...");
	}
	
	override public function update(dt:Float):Void {
		super.update(dt);
	}
	
	private function appendMessage(t:String):Void {
		logText = logText + "\n" + t;
	}
	
	private var logText(get, set):String;
	
	private function get_logText():String {
		return text.text;
	}
	private function set_logText(t:String):String {
		return text.text = t;
	}
}