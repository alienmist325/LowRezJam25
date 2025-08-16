class_name fix_jitter

extends Node

class JitterFixer:
	var old_vector = Vector2()
		
	## Fixes jittering. Also speeds up movement, acceleration and deceleration by about a 1.5 multiplier
	## Call this after calling `move_and_slide`. Accepts the current position, and returns the fixed position
	func fix_jitter(input_vector: Vector2, position: Vector2):
		if old_vector != input_vector:
			old_vector = input_vector
		if input_vector != Vector2.ZERO:
			position.x = round(position.x)
			position.y = round(position.y)
			
		return position

class AltJitterFixer:
	var _position = Vector2()
	var x: float
	var y: float
	var oldx: float
	var oldy: float
	
	func _init(position) -> void:
		x = position.x
		y = position.y
		oldx = position.x
		oldy = position.y
		
	## Call this before `move_and_slide` and preferably at the start of the `physics_process`
	func beforeMove(position):
		oldx = position.x
		oldy = position.y
		

	## Fixes jittering but with no speed-up, unlike `fix_jitter`. Accepts the current velocity and position
	## And returns the fixed position
	func afterMove(velocity: Vector2, position: Vector2):
		if velocity:
			if abs(oldx - position.x) > abs(oldy - position.y): 
				x = round(position.x)
				y = round(position.y + (x - position.x) * velocity.y / velocity.x)
				position.y = y
			elif abs(oldx - position.x) <= abs(oldy - position.y):
				y = round(position.y)
				x = round(position.x + (y - position.y) * velocity.x / velocity.y)
				position.x = x
		
		return position
	
