// --------------------------------------------------------------------------
// Project Frocessing
// ActionScript 3.0 drawing library like Processing.
// --------------------------------------------------------------------------
//
// This library is based on Processing.(http://processing.org)
// Copyright (c) 2004-08 Ben Fry and Casey Reas
// Copyright (c) 2001-04 Massachusetts Institute of Technology
// 
// Frocessing drawing library
// Copyright (C) 2008-10  TAKANAWA Tomoaki (http://nutsu.com) and
//					   	  Spark project (www.libspark.org)
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//
// contact : face(at)nutsu.com
//

package frocessing.color {
	
	/**
	 * 色相（Hue） 彩度(Saturation) 明度(Value・Brightness) で色を定義するクラスです.
	 * 
	 * @author nutsu
	 * @version 0.5.8
	 */
	public class ColorHSV extends AbstractColorUpdater implements IColor{
		
		private var _h:Number;	//Hue
		private var _s:Number;	//Saturation
		private var _v:Number;	//Value | Brightness
		
		/**
		 * 新しい ColorHSV クラスのインスタンスを生成します.
		 * 
		 * @param	h_	Hue (degree 360)
		 * @param	s_	Saturation [0.0,1.0]
		 * @param	v_	Brightness [0.0,1.0]
		 * @param	a	Alpha [0.0,1.0]
		 */
		public function ColorHSV( h:Number=0.0, s:Number = 1.0, v:Number = 1.0, a:Number = 1.0  ) 
		{
			hsv( h, s, v );
			_a = a;
		}
		
		/**
		 * インスタンスのクローンを生成します.
		 */
		public function clone():ColorHSV
		{
			var c:ColorHSV = new ColorHSV( _h, _s, _v, _a );
			c.copyFrom( this );
			return c;
		}
		
		//------------------------------------------------------------------------------------------------------------------- HSV
		
		/**
		 * 色の 色相(Hue) 値を、色相環上の角度( 0～360 )で示します.<br/>
		 * 0 度が赤、120 度が緑、240 度が青になります. 
		 */
		public function get h():Number { return _h; }
		public function set h( value:Number ):void
		{
			_h = value;
			check_rgb_flg = true;
		}
		/**
		 * 色の 色相(Hue) 値を、色相環上のラジアン( 0～2PI )で示します.<br/>
		 * 0 が赤、2PI/3 が緑、4PI/3 が青になります. 
		 */
		public function get hr():Number { return Math.PI*_h / 180; }
		public function set hr( value:Number ):void
		{
			_h = 180*value/Math.PI;
			check_rgb_flg = true;
		}
		
		/**
		 * 色の 彩度(Saturation) 値を示します.<br/>
		 * 有効な値は 0.0 ～ 1.0 です.デフォルト値は 1 です.
		 */
		public function get s():Number { return _s; }
		public function set s( value:Number ):void
		{
			if ( value > 1.0 ) { _s = 1.0; } else if ( value < 0.0 ) { _s = 0.0; } else { _s = value; }
			check_rgb_flg = true;
		}
		
		/**
		 * 色の 明度(Value・Brightness) 値を示します.<br/>
		 * 有効な値は 0.0 ～ 1.0 です.デフォルト値は 1 です.
		 */
		public function get v():Number { return _v; }
		public function set v( value:Number ):void
		{
			if ( value > 1.0 ) { _v = 1.0; } else if ( value < 0.0 ) { _v = 0.0; } else { _v = value; }
			check_rgb_flg = true;
		}
		
		//------------------------------------------------------------------------------------------------------------------- SET
		
		/**
		 * HSV値で色を指定します.
		 * @param	h	Hue (degree 360)
		 * @param	s	Saturation [0.0,1.0]
		 * @param	v	Brightness [0.0,1.0]
		 */
		public function hsv( h:Number, s:Number = 1.0, v:Number = 1.0 ):void
		{
			_h = h;
			if ( s > 1.0 ) { _s = 1.0; } else if ( s < 0.0 ) { _s = 0.0; } else { _s = s; }
			if ( v > 1.0 ) { _v = 1.0; } else if ( v < 0.0 ) { _v = 0.0; } else { _v = v; }
			check_rgb_flg = true;
		}
		
		//------------------------------------------------------------------------------------------------------------------- update
		
		/**
		 * HSV to RGB
		 * @private
		 */
		override protected function update_rgb():void 
		{
			if ( _s > 0 ){
				var h:Number = ((_h < 0) ? _h % 360 + 360 : _h % 360 ) / 60;
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
				_r = _g = _b = Math.round( 255*_v );
			}
			check_rgb_flg = false;
		}
		
		/**
		 * RGB to HSV
		 * @private
		 */
		override protected function apply_rgb():void 
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
			//check_rgb_flg = false;
		}
		
		/**
		 * GrayScale to HSV
		 * @private
		 */
		override protected function apply_grayscale():void 
		{
			//_h = 0;
			_s = 0;
			_v = _r/255;
		}
		
		//------------------------------------------------------------------------------------------------------------------- STRING
		
		public function toString():String 
		{
			return "[HSV(" + _h.toFixed(2) + "," + _s.toFixed(2) + "," + _v.toFixed(2) + ")A("+ _a.toFixed(2)+")]";
		}
	}
	
}