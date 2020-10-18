package;

import frocessing.color.ColorHSV;
import haxe.ds.Vector;

/**
 * ...
 * @author Kaelan
 */
class Blocks 
{
	public var count:Int;
	public var width:Int;
	public var height:Int;
	public var values:Array<Particle>;
	
	public function new(_width:Int, _height:Int) 
	{
		width = _width;
		height = _height;
		count = width * height;
		values = new Array();
		
		var c:ColorHSV = new ColorHSV();
		
		for (x in 0...width) {
			c.h = 360 * x / width;
			for (y in 0...height) {
				var p:Particle = new Particle(x, y);
				p.color = c.value;
				values[x + y * width] = p;
			}
		}
	}
	
	public function getParticle(_x:Int, _y:Int):Particle 
	{
		var index:Int = _x + _y * width;
		if (index >= values.length || index < 0) return null;
		return values[index];
	}
	
	public function removeParticle(_x:Int, _y:Int):Particle
	{
		var p:Particle = values[_x + _y * width];
		if (p != null) {
			count--;
			values[_x + _y * width] = null;
		}
		return p;
	}
	
}