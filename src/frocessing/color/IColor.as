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
	 * 色オブジェクトのインターフェイスです.
	 * 
	 * @author nutsu
	 * @version 0.5
	 */
	public interface IColor 
	{
		/**
		 * 24bit Color (0xRRGGBB) を示します.
		 */
		function get value():uint;
		function set value( value_:uint ):void;
		
		/**
		 * 32bit Color (0xAARRGGBB) を示します.
		 */
		function get value32():uint;
		function set value32( value_:uint ):void;
		
		/**
		 * 色の 赤(Red) 値を示します.
		 */
		function get r():uint;
		function set r( value_:uint ):void;
		
		/**
		 * 色の 緑(Green) 値を示します.
		 */
		function get g():uint;
		function set g( value_:uint ):void;
		
		/**
		 * 色の 青(Blue) 値を示します.
		 */
		function get b():uint;
		function set b( value_:uint ):void;
		
		/**
		 * 色の 透明度(Alpha) 値を示します.
		 */
		function get a():Number;
		function set a( value_:Number ):void;
	}
	
}