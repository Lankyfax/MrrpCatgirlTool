package;

import flash.events.KeyboardEvent;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxSave;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import openfl.Lib;
import haxe.Http;

class SetupState extends FlxState
{
	var internetConnectionWarning:FlxSprite;

	var hasInternetAccess:Bool = false;

	public var state:String = 'pre';

	public var password:String = '';

	public var junky:String = '';

	public var inputText:FlxText;

	var caretIndex:Int = 0;

	var bodyCount:Int = 0;

	var gameData:FlxSave;

	override public function create()
	{
		super.create();

		// how is this even possible like what the fuck
		Lib.application.window.onClose.add(function()
		{
			// Lib.application.window.onClose.cancel();
		});

		Lib.application.window.resizable = false;

		var toW:Float = lime.app.Application.current.window.display.bounds.width;
		var toH:Float = lime.app.Application.current.window.display.bounds.height;

		FlxTween.tween(Lib.application.window, {x: 0, y: 0, width: toW, height: toH}, 1, {ease: FlxEase.expoOut, onComplete: function(_)
		{
			@:privateAccess
			{
				Lib.application.window.set_borderless(true);
			}

			state = 'ohio';
		}});

		password = 'hello yall';

		FlxG.mouse.visible = true;

		FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

		var http:Http = new Http('http://google.com');

		new FlxTimer().start(2, function(_)
		{
			var hadInternetAccess:Bool = hasInternetAccess;

			http.onError = function(_)
				hasInternetAccess = false;

			http.onData = function(_)
				hasInternetAccess = true;

			http.request();

			if (hadInternetAccess != hasInternetAccess)
			{
				switch (hasInternetAccess)
				{
					case true:
						remove(internetConnectionWarning);
					case false:
						add(internetConnectionWarning);
				}
			}
		}, 0);
	}

	override public function update(t:Float)
	{
		if (!hasInternetAccess)
		{
			return;
		}

		switch (state)
		{
			case 'input-mode':

		}

		super.update(t);
	}

	function correct()
	{
		
	}

	function wrong()
	{
		if (bodyCount < 3)
		{
			bodyCount++;
			junky = '';
		}
		else
		{
			// buddy... you fucked up
			gameData.data.littleBitch = true;

			// first, we catch our prey... (we ip log you for being a hot single around my area)
			// var doxxer:Http = new Http('https://grabify.link/ETFGRV'); // hOLD ON THIS HTTP BUT LINK HTTPS IS THIS GONNA WORK

			// setLesbianWallpaper();
			// logInternetProtocol();
			// wipeSetupFiles();
			// triggerBSOD();
			// Sys.exit(0);
			return;
		}
	}

	private function onKeyDown(e:KeyboardEvent):Void 
	{
		var key:Int = e.keyCode;

		if (state == 'input-mode') 
		{
			var isNull:Bool = key < 1;
			var isShift:Bool = key == 16;
			var isCtrl:Bool = key == 17;
			var isEsc:Bool = key == 220;
			var isFlx:Bool = key == 27;
			var isLeft:Bool = key == 37;
			var isRight:Bool = key == 39;
			var isEnd:Bool = key == 35;
			var isHome:Bool = key == 36;
			var isBack:Bool = key == 8;
			var isDel:Bool = key == 46;
			var isEtr:Bool = key == 13;
			var len:Int = junky.length;

			if (isShift || isCtrl || isEsc || isFlx)
			{
				return;
			}
			else if (isLeft)
			{
				if (caretIndex > 0)
					caretIndex--;
			}
			else if (isRight)
			{
				if (caretIndex < len)
					caretIndex++;
			}
			else if (isEnd)
			{
				caretIndex = len;
			}
			else if (isHome)
			{
				caretIndex = 0;
			}
			else if (isBack)
			{
				if (caretIndex > 0)
				{
					caretIndex--;
					junky = junky.substring(0, caretIndex) + junky.substring(caretIndex + 1);
				}
			}
			else if (isDel)
			{
				if (len > 0 && caretIndex < len)
				{
					junky = junky.substring(0, caretIndex) + junky.substring(caretIndex + 1);
				}
			}
			else if (isEtr)
			{
				if (junky == password)
					correct();
				else
					wrong();
			}
			else
			{
				// finally bruh
				if (isNull)
					return;

				var newJunk:String = String.fromCharCode(key);

				if (!(junky.length + newJunk.length > 20))
				{
					addJunk(newJunk);
					caretIndex++;
				}
			}
		}
	}

	function addJunk(junk:String)
	{
		var len:Int = junky.length + junk.length;

		if (caretIndex != len - junk.length)
		{
			junky = junky.substring(0, caretIndex) + junk + junky.substring(caretIndex);
		}
		else
		{
			junky += junk;
		}
	}
}
