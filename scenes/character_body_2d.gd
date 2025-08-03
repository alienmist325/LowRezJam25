extends CharacterBody2D

const MULT = 1

const ACC = 20 * MULT
const DEC = 5 * MULT
const MAX_SPEED = 40 * MULT

func _physics_process(delta: float) -> void:
	var jitterFixer = fix_jitter.JitterFixer.new()
	# var altJitterFixer = fix_jitter.AltJitterFixer.new(position)
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# altJitterFixer.before(position)
	
	if direction.x:
		velocity.x = move_toward(velocity.x, sign(direction.x) * MAX_SPEED, abs(direction.x * ACC))
	else:
		velocity.x = move_toward(velocity.x, 0, DEC)

	if direction.y:
		velocity.y = move_toward(velocity.y, sign(direction.y) * MAX_SPEED, abs(direction.y * ACC))
	else:
		velocity.y = move_toward(velocity.y, 0, DEC)
		
	move_and_slide()
	position = jitterFixer.fix_jitter(direction, position)
	# position = altJitterFixer.alt_fix_jitter(velocity, position)
