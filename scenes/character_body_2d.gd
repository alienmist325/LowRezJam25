extends CharacterBody2D


const ACC = 3
const DEC = 10
const MAX_SPEED = 36
# const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# velocity.x = -100
	# MAX_SPEED = 30
	# direction.x = -1
	# ACC = 3
	
	print(move_toward(-100, 30, -1 * 3))
	
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, abs(direction.x * ACC))
		velocity.y = move_toward(velocity.y, direction.y * MAX_SPEED, abs(direction.y * ACC))
	else:
		velocity.x = move_toward(velocity.x, 0, DEC)
		velocity.y = move_toward(velocity.y, 0, DEC)
		
	print(direction)
	print(velocity)
	
		
	#var vert_direction := Input.get_axis("ui_up", "ui_down")
#
	#if vert_direction:
		#velocity.y = move_toward(velocity.y, MAX_SPEED, vert_direction * ACC)
	#else:
		#velocity.y = move_toward(velocity.y, 0, DEC)
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = move_toward(velocity.x, MAX_SPEED, direction * ACC)
	#else:
		#velocity.x = move_toward(velocity.x, 0, DEC)
		#
		#
	#print(velocity)
func _process(delta: float) -> void:
	move_and_slide()
