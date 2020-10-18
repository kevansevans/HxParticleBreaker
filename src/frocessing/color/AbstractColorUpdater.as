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

package frocessing.color 
{
	
	/**
	 * 任意の色空間をRGB値へ変換する抽象クラス.
	 * 
	 * @author nutsu
	 * @version 0.5.8
	 */
	public class AbstractColorUpdater implements IColor
	{
		/** @private */
		protected var _r:uint;
		/** @private */
		protected var _g:uint;
		/** @private */
		protected var _b:uint;
		/** @private */
		protected var _a:Number;
		/** @private */
		protected var check_rgb_flg:Boolean;
		
		/**
		 * 
		 */
		public function AbstractColorUpdater() 
		{
			;
		}
		
		/** @private */
		protected function copyFrom( c:AbstractColorUpdater ):void {
			check_rgb_flg = c.check_rgb_flg;
			_r = c._r;
			_g = c._g;
			_b = c._b;
		}
		
		//------------------------------------------------------------------------------------------------------------------- Value
		
		/**
		 * 24bit Color (0xRRGGBB) を示します.
		 */
		public function get value():uint { 
			if ( check_rgb_flg ) update_rgb();
			return _r << 16 | _g << 8 | _b;
		}
		public function set value( colorValue:uint ):void{
			_r = colorValue >> 16 & 0xff;
			_g = colorValue >> 8 & 0xff;
			_b = colorValue & 0xff;
			apply_rgb();
		}
		
		/**
		 * 32bit Color (0xAARRGGBB) を示します.
		 */
		public function get value32():uint {
			if ( check_rgb_flg ) update_rgb();
			return (Math.round( _a * 0xff ) & 0xff) << 24 | _r << 16 | _g << 8 | _b ;
		}
		public function set value32( colorValue:uint ):void{
			_r = colorValue >> 16 & 0xff;
			_g = colorValue >> 8 & 0xff;
			_b = colorValue & 0xff;
			_a = ( colorValue >>> 24 ) / 0xff;
			apply_rgb();
		}
		
		//------------------------------------------------------------------------------------------------------------------- RGBA
		
		/**
		 * 色の 透明度(Alpha) 値を示します.<br/>
		 * 有効な値は 0.0　～　1.0　です.デフォルト値は　1.0　です.
		 */
		public function get a():Number { return _a; }
		public function set a( value:Number):void
		{
			_a = value;
		}
		
		/**
		 * 色の 赤(Red) 値を示します.<br/>
		 * 有効な値は 0 ～ 255 です.デフォルト値は 0 です.
		 */
		public function get r():uint {
			if ( check_rgb_flg ) update_rgb();
			return _r;
		}
		public function set r( value:uint ):void{
			_r = value & 0xff;
			apply_rgb();
		}
		
		/**
		 * 色の 緑(Green) 値を示します.<br/>
		 * 有効な値は 0 ～ 255 です.デフォルト値は 0 です.
		 */
		public function get g():uint { 
			if ( check_rgb_flg ) update_rgb();
			return _g;
		}
		public function set g( value:uint ):void{
			_g = value & 0xff;
			apply_rgb();
		}
		
		/**
		 * 色の 青(Blue) 値を示します.<br/>
		 * 有効な値は 0 ～ 255 です.デフォルト値は 0 です.
		 */
		public function get b():uint {
			if ( check_rgb_flg ) update_rgb();
			return _b;
		}
		public function set b( value:uint ):void{
			_b = value & 0xff;
			apply_rgb();
		}
		
		//------------------------------------------------------------------------------------------------------------------- SET
		
		/**
		 * RGB値で色を指定します.
		 * @param	r	Red [0,255]
		 * @param	g	Green [0,255]
		 * @param	b	Blue [0,255]
		 */
		public function rgb( r:uint, g:uint, b:uint ):void
		{
			_r = r & 0xff;
			_g = g & 0xff;
			_b = b & 0xff;
			apply_rgb();
		}
		
		/**
		 * グレイ値で色を指定します.
		 * @param	gray	Gray [0,255]
		 */
		public function gray( gray_:uint ):void
		{
			_r = _g = _b = gray_ & 0xff;
			apply_grayscale();
		}
		
		//------------------------------------------------------------------------------------------------------------------- CONVERT
		
		/**
		 * ColorRGB クラスのインスタンスを生成します.
		 */
		public function toRGB():ColorRGB
		{
			if ( check_rgb_flg ) update_rgb();
			return new ColorRGB( _r, _g, _b, _a );
		}
		
		//------------------------------------------------------------------------------------------------------------------- UPDATE
		
		/** @private */
		protected function update_rgb():void {
			check_rgb_flg = false;
		}
		
		/** @private */
		protected function apply_rgb():void {
			;
		}
		
		/** @private */
		protected function apply_grayscale():void {
			;
		}
		
		//-------------------------------------------------------------------------------------------------------------------
		
		/**
		 * @return 0xRRBBGG
		 */
		public function valueOf():uint {
			return value;
		}
	}
	
}