package;

import frocessing.color.AbstractColorUpdater;
import frocessing.color.ColorHSV;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.ui.Keyboard;
import openfl.events.KeyboardEvent;
import openfl.Lib;

/**
 * ...
 * @author Kaelan
 */
class Main extends Sprite 
{
	static var HEIGHT:Int;
	static var WIDTH:Int;
	
	var _canvas:BitmapData;
	var _blocks:Blocks;
	var _fallBlocks:Array<Particle>;
	var _balls:Array<Particle>;
	var _bar:Bitmap;

	public function new() 
	{
		super();
		
		WIDTH = Lib.current.stage.stageWidth;
		HEIGHT = Lib.current.stage.stageHeight;
		
		_canvas = new BitmapData(WIDTH, HEIGHT, false, 0);
		addChild(new Bitmap(_canvas));
		
		var b:BitmapData = new BitmapData(Std.int(50 * (width / 465)), 10, false, 0x00FF00);
		addChild(_bar = new Bitmap(b));
		
		_blocks = new Blocks(WIDTH, 175);
		
		_fallBlocks = new Array();
		_bar.y = HEIGHT - 50;
		var _ball:Particle = new Particle(WIDTH / 2, HEIGHT / 2);
		_ball.vx = Math.random() * 10;
		_ball.vy = Math.random() * 9 -1;
		_ball.color = 0xFFFFFF;
		
		_balls = new Array();
		_balls.push(_ball);
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
			switch (e.keyCode) {
				case Keyboard.SPACE :
					reset();
			}
		});
		
	}
	
	function reset() {
		
		_blocks = new Blocks(WIDTH, 175);
		
		_fallBlocks = new Array();
		_bar.y = HEIGHT - 50;
		var _ball:Particle = new Particle(WIDTH / 2, HEIGHT / 2);
		_ball.vx = Math.random() * 10;
		_ball.vy = Math.random() * 9 -1;
		_ball.color = 0xFFFFFF;
		
		_balls = new Array();
		_balls.push(_ball);
		
		if (!hasEventListener(Event.ENTER_FRAME)) {
			addEventListener(Event.ENTER_FRAME, update);
		}
		
	}
	
	function update(e:Event):Void 
	{
		_canvas.lock();
		_canvas.colorTransform(_canvas.rect, new ColorTransform(0.9, 0.5, 0.9));
		
		for (block in _blocks.values) {
			if (block != null) {
				_canvas.setPixel(Std.int(block.x), Std.int(block.y), Std.int(block.color));
			}
		}
		var removeBalls:Array<Particle> = new Array();
		for (ball in _balls) {
			var bvx:Float = ball.vx;
			var bvy:Float = ball.vy;
			var bspeed:Float = Math.sqrt(bvx * bvx + bvy * bvy);
			var bradius:Float = Math.atan2(bvx, bvy);
			for (spd in 0...Std.int(bspeed)) {
				
				ball.x += ball.vx / bspeed;
				ball.y += ball.vy / bspeed;
				
				var hitParticle:Particle = _blocks.getParticle(Std.int(ball.x), Std.int(ball.y));
				
				if (hitParticle != null) {
					
					var removedP:Particle = _blocks.removeParticle(Std.int(ball.x), Std.int(ball.y));
					removedP.vx = Math.cos(bradius + Math.PI * 2 / (30 * Math.random()) - 15) * 3;
					removedP.vy = 1;
					removedP.color = hitParticle.color;
					_fallBlocks.push(removedP);
					ball.vy = -ball.vy;
					
				}
				
				if ((ball.x < 0 && ball.vx < 0) || (ball.x > WIDTH && ball.vx > 0))
				{
					ball.vx = -ball.vx;
				}
				if (ball.y < 0 && ball.vy < 0) {
					ball.vy = -ball.vy;
				}
				if (ball.y > HEIGHT) {
					removeBalls.push(ball);
				}
				if (_bar.hitTestPoint(ball.x, ball.y)) {
					ball.vy = - Math.abs(ball.vy);
				}
				_canvas.setPixel(Std.int(ball.x), Std.int(ball.y), Std.int(ball.color));
			}
		}
		
		for (ball in removeBalls) {
			var index:Int = _balls.indexOf(ball);
			if (index != -1) {
				_balls.splice(index, 1);
			}
		}
		
		var removeFallBs:Array<Particle> = new Array();
		
		for (fallP in _fallBlocks) {
			fallP.vy += 0.1;
			fallP.x += fallP.vx;
			fallP.y += fallP.vy;
			_canvas.setPixel(Std.int(fallP.x), Std.int(fallP.y), fallP.color);
			
			if (_bar.hitTestPoint(fallP.x, fallP.y))
			{
				var newball:Particle = new Particle(fallP.x, fallP.y);
				newball.vx = Math.random() * 10;
				newball.vy = Math.random() * 9 + 1;
				newball.color = fallP.color;
				_balls.push(newball);
				removeFallBs.push(fallP);
			} else if (fallP.y > HEIGHT) {
				removeFallBs.push(fallP);
			}
		}
		
		for (particle in removeFallBs) {
			var index:Int = _fallBlocks.indexOf(particle);
			if (index != -1) {
				_fallBlocks.splice(index, 1);
			}
		}
		
		_bar.x = stage.mouseX - (_bar.width / 2);
		_canvas.unlock();
		
		if (_blocks.count == 0) {
			removeEventListener(Event.ENTER_FRAME, update);
			var clearTF:TextField = new TextField();
			clearTF.text = "CLEAR!\nおめでと";
			clearTF.textColor = 0xFFFFFF;
			clearTF.autoSize = TextFieldAutoSize.LEFT;
			_canvas.draw(clearTF,new Matrix(5,0,0,5,WIDTH/2-clearTF.width*5/2,HEIGHT/2-clearTF.height*5/2));
		}
	}

}
