package states;

import config.SaveData;
import extension.mobileprefs.MobilePrefs;
import extension.mobileprefs.SaveDataSalvager;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import lime.system.System;
import openfl.net.SharedObject;
import sys.FileSystem;
import sys.io.File;

@:access(openfl.net.SharedObject)
class RootState extends FlxState
{
	private var text:FlxText = new FlxText(0, 20);
	
	private var createOldSavedataButton:FlxButton;
	private var printOldSavedataButton:FlxButton;
	private var clearOldSavedataToDefaultsButton:FlxButton;
	
	private var loadNewSavedataButton:FlxButton;
	private var deleteNewSavedataButton:FlxButton;
	private var salvageOldSavedataButton:FlxButton;
	private var printNewSavedataButton:FlxButton;
	private var flushNewSavedataButton:FlxButton;
	
	private var listStorageDirectoriesButton:FlxButton;
	
	override public function create():Void {
		super.create();
		
		// Commit a copy-paste of a .sol file from an old desktop build of Werewolf Tycoon
		// to the old preferences
		createOldSavedataButton = new FlxButton(0, 0, "Create Old Save", function() {
			appendMessage("Creating an old-style savedata file...");
			MobilePrefs.setUserPreference(SaveData.saveFileName,
			"oy19:highestKillsReachedzy27:shouldShowTitleRateUsButtonfy18:currentSaveVersioni1y10:stepsTakeni1y10:totalKillszy25:timesManuallyHiddenInBushi16y19:hasShownLamppostTipty23:gamesPlayedThisSaveFilei3y16:ratingPaperShownfy19:highestNightReachedi1g");
		});
		
		// Print out the old savedata, if any
		printOldSavedataButton = new FlxButton(0, 0, "Print Old Save", function() {
			appendMessage("Printing out old savedata...");
			appendMessage(MobilePrefs.getUserPreference(SaveData.saveFileName));
		});
		
		// Clears the old savedata to an empty string
		clearOldSavedataToDefaultsButton = new FlxButton(0, 0, "Reset Old Save", function() {
			appendMessage("Resetting old savedata to default values...");
			MobilePrefs.clearUserPreference(SaveData.saveFileName);
		});
		
		// Run the old savedata salvager, which will copy the sol data out from preferences to
		// an external .sol file in the application storage directory if possible
		salvageOldSavedataButton = new FlxButton(0, 0, "Salvage Old Save", function() {
			appendMessage("Salvaging old savedata, writing it to new file");
			
			var result = SaveDataSalvager.salvageSaveData(SaveData.saveFileName);
			appendMessage("Salvaging result: " + Std.string(result));
		});
		
		// Loads (or sets up defaults + flushes) new .sol file savedata
		loadNewSavedataButton = new FlxButton(0, 0, "Load New Save", function() {
			appendMessage("Loading new savedata...");
			
			Main.saveData.initSaveData(false);
		});
		
		// Deletes the new .sol file savedata
		deleteNewSavedataButton = new FlxButton(0, 0, "Delete New Save", function() {
			appendMessage("Deleting new savedata...");
			
			try {
				FileSystem.deleteFile(System.applicationStorageDirectory + "/" + SaveData.saveFileName + ".sol");
				appendMessage("Deleted new savedata");
				return;
			} catch (e:Dynamic) {
				appendMessage("Failed to delete new savedata, did it actually exist: " + e);
			}
		});
		
		// Prints the new .sol file savedata, if any
		printNewSavedataButton = new FlxButton(0, 0, "Print New Save", function() {
			appendMessage("Printing out new savedata...");
			
			try {
				appendMessage("Whole file: " + File.getContent(SharedObject.__getPath("", SaveData.saveFileName)));
			} catch (e:Dynamic) {
				appendMessage("Failed to print whole new savedata file contents: " + e);
			}
			
			try {
				appendMessage("Highest night = " + Main.saveData.highestNight);
				appendMessage("Highest kills = " + Main.saveData.highestScore);
			} catch (e:Dynamic) {
				appendMessage("Failed to print night and/or kills fields of new savedata: " + e);
			}
		});
		
		// Flushes the new .sol file savedata from memory to disk
		flushNewSavedataButton = new FlxButton(0, 0, "Flush New Save", function() {
			appendMessage("Flushing new savedata...");
			
			Main.saveData.flush();
		});
		
		// Lists the contents of the application storage directory (expect the new .sol file to go here e.g. saveone.sol)
		listStorageDirectoriesButton = new FlxButton(0, 0, "List Storage Dirs", function() {
			appendMessage("Listing contents at app storage dir: " + System.applicationStorageDirectory);
			
			var newFiles = FileSystem.readDirectory(System.applicationStorageDirectory);
			for (file in newFiles) {
				appendMessage(file);
			}
		});
		
		add(text);
		
		// Add the buttons to the bottom of the screen
		var i = 1;
		var x = 0;
		for (button in [createOldSavedataButton, printOldSavedataButton, clearOldSavedataToDefaultsButton, salvageOldSavedataButton, loadNewSavedataButton, deleteNewSavedataButton, printNewSavedataButton, flushNewSavedataButton, listStorageDirectoriesButton]) {
			x += 5;
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