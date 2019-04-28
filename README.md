# Savedata Salvaging Test

Simple test application to check that some old HaxeFlixel FlxSave/OpenFL SharedObject savedata salvaging code actually works for Werewolf Tycoon 1 for Android and iOS.

Made for salvaging user's old savedata when updating an app using a legacy OpenFL version (~3.6) to a new version (~8.0). See [this forum thread](https://community.openfl.org/t/need-help-loading-old-android-and-ios-saves/10400) for details.

Uses this [haxelib](https://github.com/Tw1ddle/samcodes-mobileprefs) made just for salvaging old savedata.

## Usage

Press the buttons. This example creates "old" savedata, extracts it out into a new .sol file, and then loads it up using the usual HaxeFlixel FlxSave class.

 * Press "Create Old Save" to create a sample old savedata file. This is the type that used to exist under SharedPreferences on Android, for example.
 * Press "Print Old Save" to check that the savedata (in Haxe serialization format) has been written to preferences.
 * Press "Salvage Old Save". If the log says "SUCCESS" the old savedata was copied out into a new .sol file, else if it says "NEW_SAVEDATA_ALREADY_EXISTS" you must have run the app once already - so hit "Delete New Save" and repeat.
 * Press "List Storage Dir" to check that the salvaged save data file actually exists now, expect to see a file e.g. "yoursavefile.sol".
 * Press "Load New Save" to actually load the new savedata from disk into our SaveData instance.
 * Press "Print New Save" and check that the fields match what the original old save data contained.
 * Press "Flush New Save" to flush the new savedata to disk.

 ### Notes

 * Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).