package states;

import extension.mobileprefs.MobilePrefs;
import extension.mobileprefs.SaveDataSalvager;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.net.SharedObject;
import lime.system.System;

import sys.FileSystem;

class RootState extends FlxState
{
	private var text:FlxText = new FlxText(0, 20);
	
	private var createOldSavedataButton:FlxButton;
	private var printOldSavedataButton:FlxButton;
	private var resetOldSavedataToDefaultsButton:FlxButton;
	
	private var createNewSavedataButton:FlxButton;
	private var salvageOldSavedataButton:FlxButton;
	private var printNewSavedataButton:FlxButton;
	private var deleteNewSavedataButton:FlxButton;
	private var flushNewSavedataButton:FlxButton;
	
	private var listStorageDirectoryButton:FlxButton;
	
	override public function create():Void {
		super.create();
		
		createOldSavedataButton = new FlxButton(0, 0, "Create Old Save", function() {
			appendMessage("Creating fake old savedata...");
			
			var highestNight = "8999";
			var highestKills = "9001";
			
			MobilePrefs.setUserPreference("highestNightReached", highestNight);
			MobilePrefs.setUserPreference("highestKillsReached", highestKills);
			
			appendMessage("Highest night = " + MobilePrefs.getUserPreference("highestNightReached"));
			appendMessage("Highest kills = " + MobilePrefs.getUserPreference("highestKillsReached"));
		});
		
		printOldSavedataButton = new FlxButton(0, 0, "Print Old Save", function() {
			appendMessage("Printing out old savedata...");
			appendMessage("Highest night = " + MobilePrefs.getUserPreference("highestNightReached"));
			appendMessage("Highest kills = " + MobilePrefs.getUserPreference("highestKillsReached"));
		});
		
		resetOldSavedataToDefaultsButton = new FlxButton(0, 0, "Reset Old Save", function() {
			appendMessage("Resetting old savedata to default values...");
			MobilePrefs.clearUserPreference("highestNightReached");
			MobilePrefs.clearUserPreference("highestKillsReached");
		});
		
		salvageOldSavedataButton = new FlxButton(0, 0, "Salvage Old Save", function() {
			appendMessage("Salvaging old savedata, writing it to new file + deleting old file");
			var result = SaveDataSalvager.salvageSaveData("saveone");
			appendMessage("Salvaging result: " + Std.string(result));
		});
		
		createNewSavedataButton = new FlxButton(0, 0, "Create New Save", function() {
			appendMessage("Creating new savedata...");
			Main.saveData.initSaveData(true);
		});
		
		printNewSavedataButton = new FlxButton(0, 0, "Print New Save", function() {
			appendMessage("Printing out new savedata...");
			appendMessage("Highest night = " + Main.saveData.highestNight);
			appendMessage("Highest kills = " + Main.saveData.highestScore);
		});
		
		deleteNewSavedataButton = new FlxButton(0, 0, "Clear New Save", function() {
			appendMessage("Deleting new savedata...");
			FileSystem.deleteFile(System.applicationStorageDirectory + "/" + "saveone.sol");
		});
		
		flushNewSavedataButton = new FlxButton(0, 0, "Flush New Save", function() {
			appendMessage("Flushing new savedata...");
			Main.saveData.flush();
		});
		
		listStorageDirectoryButton = new FlxButton(0, 0, "List Storage Dir", function() {
			appendMessage("Listing storage dir contents at : " + System.applicationStorageDirectory);
			var files = FileSystem.readDirectory(System.applicationStorageDirectory);
			for (file in files) {
				appendMessage(file);
			}
		});
		
		add(text);
		
		var i = 1;
		var x = 0;
		for (button in [createOldSavedataButton, printOldSavedataButton, resetOldSavedataToDefaultsButton, salvageOldSavedataButton, createNewSavedataButton, printNewSavedataButton, deleteNewSavedataButton, flushNewSavedataButton, listStorageDirectoryButton]) {
			x += 20;
			i++;
			
			button.x = x;
			x += Std.int(button.width);
			
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