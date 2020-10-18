package frocessing.color;

/**
 * ...
 * @author Kaelan
 */
class AbstractColorUpdater implements IColor 
{

	var _r:Int;
	var _g:Int;
	var _b:Int;
	var _a:Float;
	var check_rgb_flg:Bool;
	
	public var a(get, set):Float;
	public var r(get, set):Int;
	public var g(get, set):Int;
	public var b(get, set):Int;
	
	public var value(get, set):Int;
	public var value32(get, set):Int;
	
	public function new() 
	{
		
	}
	
	function copyFrom(c:AbstractColorUpdater) {
		check_rgb_flg = c.check_rgb_flg;
		_r = c._r;
		_g = c._g;
		_b = c._b;
	}
	
	function get_value():Int 
	{
		if (check_rgb_flg) update_rgb();
		return _r << 16 | _g << 8 | _b;
	}
	
	function set_value(value:Int):Int 
	{
		_r = value >> 16 & 0xFF;
		_g = value >> 8 & 0xFF;
		_b = value & 0xFF;
		apply_rgb();
		return 0;
	}
	
	function get_value32():Int 
	{
		if (check_rgb_flg) update_rgb();
		return Math.round(_a * 0xFF) & 0xFF << 24 | _r << 16 | _g << 8 | _b;
	}
	
	function set_value32(value:Int):Int 
	{
		_r = value >> 16 & 0xFF;
		_g = value >> 8 & 0xFF;
		_b = value & 0xFF;
		_a = (value >>> 24) / 0xFF;
		return 0;
	}
	
	public function apply_rgb() 
	{
		
	}
	
	public function update_rgb() 
	{
		check_rgb_flg = false;
	}
	
	public function apply_greyscale() {
		
	}
	
	public function get_a():Float 
	{
		return _a;
	}
	
	public function set_a(value:Float):Float 
	{
		return _a = value;
	}
	
	public function get_r():Int 
	{
		if (check_rgb_flg) update_rgb();
		return _r;
	}
	
	public function set_r(value:Int):Int 
	{
		_r = value & 0xFF;
		apply_rgb();
		return _r;
	}
	
	public function get_g():Int 
	{
		if (check_rgb_flg) update_rgb();
		return _g;
	}
	
	public function set_g(value:Int):Int 
	{
		_g = value & 0xFF;
		apply_rgb();
		return _g;
	}
	
	public function get_b():Int 
	{
		if (check_rgb_flg) update_rgb();
		return _b;
	}
	
	public function set_b(value:Int):Int 
	{
		_b = value & 0xFF;
		apply_rgb();
		return _b;
	}
	
	public function rgb(r:Int, g:Int, b:Int)
	{
		_r = r & 0xFF;
		_g = g & 0xFF;
		_b = b & 0xFF;
		apply_rgb();
	}
}