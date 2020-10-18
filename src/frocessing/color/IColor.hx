package frocessing.color;

/**
 * @author Kaelan
 */
interface IColor 
{
	//24bit color RGB
	public var value(get, set):Int;
	/*public function set_value(_v:Int) {
		return value = _v;
	}*/
	
	//32bit ARGB
	public var value32(get, set):Int;
	
	//Red
	public var r(get, set):Int;
	
	//Green
	public var g(get, set):Int;
	
	//Blue
	public var b(get, set):Int;
	
	//Alpha
	public var a(get, set):Float;
}