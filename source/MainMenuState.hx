package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import sys.io.File;
import flixel.util.FlxColor;
import flixel.FlxObject;

class MainMenuState extends MusicBeatState 
{

    public static var psychEngineVersion:String = '0.6.3'; //This is also used for Discord RPC
    // Variables
    var storymode: FlxSprite;
    var freeplay: FlxSprite;
    var credits: FlxSprite;
    var options: FlxSprite;
    var menubg:FlxSprite;

    override public function create():Void {

        //Systemm Shit
        Paths.clearStoredMemory();
        Paths.clearUnusedMemory();

        FlxG.mouse.visible = true;

        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;

        // Visuals and Buttons;
      
        var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

        menubg = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/MainMENUHouse'));
		menubg.antialiasing = ClientPrefs.globalAntialiasing;
        menubg.screenCenter();
		add(menubg);

        // Position freeplay 50 pixels to the left of storymode
        freeplay = new FlxSprite(100, 300).loadGraphic(Paths.image('menus/mainmenu/MainMENUFreeplay'));
        freeplay.screenCenter(X); 
        add(freeplay);

        // Calculate the position of credits at the top left corner
        credits = new FlxSprite(0, 100).loadGraphic(Paths.image('menus/mainmenu/MainMENUCredits'));
        credits.screenCenter(X);  // Adjust the coordinates
        add(credits);        

        super.create();
        CustomFadeTransition.nextCamera = FlxG.cameras.list[FlxG.cameras.list.length - 1];     
    }

    override public function update(elapsed: Float):Void {
        super.update(elapsed);

        if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new TitleState());
        }
        if (FlxG.keys.pressed.O) {
            MusicBeatState.switchState(new options.OptionsState());
		    FlxG.sound.play(Paths.sound('confirmMenu'), 0.7); 
        }
        if (FlxG.mouse.overlaps(freeplay)) {
        }
        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(freeplay)) {
            FlxG.sound.play(Paths.sound('wtf'), 0.7);
            MusicBeatState.switchState(new FreeplayState());
        }
        if (FlxG.mouse.overlaps(credits)) {
        }
        if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(credits)) {
		    FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);                          
        }
        // ... rest of your code ...
    }
}