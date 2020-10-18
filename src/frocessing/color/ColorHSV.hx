package frocessing.color;

/**
 * ...
 * @author Kaelan
 */
class ColorHSV extends AbstractColorUpdater implements IColor 
{

	var _h:Float;
	var _s:Float;
	var _v:Float;
	
	public var h(get, set):Float;
	public var hr(get, set):Float;
	public var s(get, set):Float;
	public var v(get, set):Float;
	
	public function new(h:Float = 0, s:Float = 1.0, v:Float = 1.0, a:Float = 1.0 ) 
	{
		super();
		
		hsv(h, s, v);
		_a = a;
	}
	
	public function clone():ColorHSV
	{
		var c:ColorHSV = new ColorHSV(_h, _s, _v, _a);
		c.copyFrom(this);
		return c;
	}
	
	function get_h():Float 
	{
		return _h;
	}
	
	function set_h(value:Float):Float 
	{
		_h = value;
		check_rgb_flg = true;
		return _h;
	}
	
	function get_hr():Float 
	{
		return Math.PI * _h / 180;
	}
	
	function set_hr(value:Float):Float 
	{
		_h = 180 * value / Math.PI;
		return _h;
	}
	
	function get_s():Float 
	{
		return _s;
	}
	
	function set_s(value:Float):Float 
	{
		if (value > 1.0) {
			_s = 1;
		} else if (value < 0) {
			_s = 0;
		} else {
			_s = value;
		}
		check_rgb_flg = true;
		return _s;
	}
	
	function get_v():Float 
	{
		return _v;
	}
	
	function set_v(value:Float):Float 
	{
		if (value > 1.0) {
			_v = 1;
		} else if (value < 0) {
			_v = 0;
		} else {
			_v = value;
		}
		check_rgb_flg = true;
		return _v;
	}
	
	public function hsv(h:Float, s:Float, v:Float) 
	{
		_h = h;
		if (s > 1.0) {
			_s = 1;
		} else if (s < 0) {
			_s = 0;
		} else {
			_s = s;
		}
		if (v > 1.0) {
			_v = 1;
		} else if (v < 0) {
			_v = 0;
		} else {
			_v = v;
		}
		check_rgb_flg = true;
	}
	
	override public function update_rgb() 
	{
		if ( _s > 0 ){
			var h:Float = ((_h < 0) ? _h % 360 + 360 : _h % 360 ) / 60;
			if ( h < 1 ) {
				_r = Math.round( 255*_v );
				_g = Math.round( 255*_v * ( 1 - _s * (1 - h) ) );
				_b = Math.round( 255*_v * ( 1 - _s ) );
			}else if ( h < 2 ) {
				_r = Math.round( 255*_v * ( 1 - _s * (h - 1) ) );
				_g = Math.round( 255*_v );
				_b = Math.round( 255*_v * ( 1 - _s ) );
			}else if ( h < 3 ) {
				_r = Math.round( 255*_v * ( 1 - _s ) );
				_g = Math.round( 255*_v );
				_b = Math.round( 255*_v * ( 1 - _s * (3 - h) ) );
			}else if ( h < 4 ) {
				_r = Math.round( 255*_v * ( 1 - _s ) );
				_g = Math.round( 255*_v * ( 1 - _s * (h - 3) ) );
				_b = Math.round( 255*_v );
			}else if ( h < 5 ) {
				_r = Math.round( 255*_v * ( 1 - _s * (5 - h) ) );
				_g = Math.round( 255*_v * ( 1 - _s ) );
				_b = Math.round( 255*_v );
			}else{
				_r = Math.round( 255*_v );
				_g = Math.round( 255*_v * ( 1 - _s ) );
				_b = Math.round( 255*_v * ( 1 - _s * (h - 5) ) );
			}
		}else{
			_r = _g = _b = Math.round( 255 * _v);
		}
		check_rgb_flg = false;
	}
	
	override public function apply_rgb() 
	{
		if( _r!=_g || _r!=_b ){
				if ( _g > _b ) {
					if ( _r > _g ) { //r>g>b
						_v = _r/255;  
						_s = (_r - _b) / _r;
						_h = 60 * (_g - _b) / (_r - _b);
					}else if( _r < _b ){ //g>b>r
						_v = _g/255;
						_s = (_g - _r) / _g;
						_h = 60 * (_b - _r) / (_g - _r) + 120;
					}else { //g=>r=>b
						_v = _g/255;
						_s = (_g - _b)/_g;
						_h = 60 * (_b - _r) / (_g - _b) + 120;
					}
				}else{
					if ( _r > _b ) { // r>b=>g
						_v = _r/255;
						_s = (_r - _g) / _r;
						_h = 60 * (_g - _b) / (_r - _g);
						if ( _h < 0 ) _h += 360;
					}else if ( _r < _g ){ //b=>g>r
						_v = _b/255;
						_s = (_b - _r) / _b;
						_h = 60 * (_r - _g)/(_b - _r) + 240;
					}else { //b=>r=>g
						_v = _b/255;
						_s = (_b - _g) / _b;
						_h = 60 * (_r - _g)/(_b - _g) + 240;
					}
				}
			}else {
				_h = _s = 0;
				_v = _r/255;
			}
	}
	
	override public function apply_greyscale() 
	{
		_s = 0;
		_v = _r / 255;
	}
}