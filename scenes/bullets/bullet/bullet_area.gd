extends CharacterBody2D

# Defaults, but generally the turret overrides this
var DIRECTION = "LEFT"
var VELOCITY = 10
var DAMAGE = 2

func _process(delta: float):
	if (DIRECTION == "UP"):
		velocity = Vector2(0, -VELOCITY)
	elif (DIRECTION == "DOWN"):
		velocity = Vector2(0, VELOCITY)
	elif (DIRECTION == "RIGHT"):
		velocity = Vector2(VELOCITY, 0)
	else:
		velocity = Vector2(-VELOCITY, 0)
		
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		SignalBus.bullet_hits_player.emit(DAMAGE)
		
	if (!body.is_in_group("BulletPassThrough")):
		queue_free()
