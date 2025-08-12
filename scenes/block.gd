extends Area2D

var health
var counter = 0
var isTakingDamage = true
var timer
var sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 2
	timer = $StaticBody2D/CollisionShape2D/Timer
	sprite = $StaticBody2D/CollisionShape2D/Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_taking_damage() -> void:
	restart_timer()
	isTakingDamage = true
	
func stop_taking_damage() -> void:
	timer.stop()
	isTakingDamage = false

func take_damage() -> void:
	health -= 1
	sprite.self_modulate.a = 0.5 * health
	if (health <= 0):
		queue_free()
	
func restart_timer():
	timer.start(0.1)

func _on_timer_timeout() -> void:
	if (isTakingDamage):
		take_damage()
		restart_timer()
