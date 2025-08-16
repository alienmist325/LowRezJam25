extends RigidBody2D

# Defaults, but generally the turret overrides this
var DIRECTION = "LEFT"
var VELOCITY = 10

func _process(delta: float):
	var velocity
	if (DIRECTION == "UP"):
		velocity = Vector2(0, -VELOCITY)
	elif (DIRECTION == "DOWN"):
		velocity = Vector2(0, VELOCITY)
	elif (DIRECTION == "RIGHT"):
		velocity = Vector2(VELOCITY, 0)
	else:
		velocity = Vector2(-VELOCITY, 0)
	
	get_node(".").set_linear_velocity(velocity)
