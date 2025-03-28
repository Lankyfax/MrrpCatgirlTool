package;

class Paths
{
	public static function file(file:String, format:String):String
	{
		return 'assets/$file.$format';
	}

	public static function image(image:String):String
	{
		return file(image, 'png');
	}

	public static function sound(sound:String):String
	{
		return file(sound, 'ogg');
	}

	public static function font(font:String):String
	{
		return file(font, 'ttf');
	}
}
