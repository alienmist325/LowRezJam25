class_name breakable_block

class BreakableBlock:
	extends Area2D

	var MAX_HEALTH: float 
	var DAMAGE_INTERVAL: float # time between getting hit
	var PARENT_NODE 
	var SPRITE
	var EXP: int

	var health: float
	var isTakingDamage = false
	

	var timer = Timer.new()
	
	func _setup(_MAX_HEALTH, _DAMAGE_INTERVAL, _PARENT_NODE, _SPRITE, _EXP):
		MAX_HEALTH = _MAX_HEALTH
		DAMAGE_INTERVAL = _DAMAGE_INTERVAL
		PARENT_NODE = _PARENT_NODE
		SPRITE = _SPRITE
		EXP = _EXP

	# Called when the node enters the scene tree for the first time.
	func _ready() -> void:
		health = MAX_HEALTH
		add_child(timer)
		timer.timeout.connect(_on_timer_timeout)
		PARENT_NODE.add_child(timer)
		
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	func _process(delta: float) -> void:
		pass

	func start_taking_damage() -> void:
		restart_timer()
		isTakingDamage = true
		
	func stop_taking_damage() -> void:
		timer.stop()
		isTakingDamage = false
		
	func block_broken() -> void:
		SignalBus.block_broken.emit(EXP)
		queue_free()
		
	func take_damage() -> void:
		health -= 1
		SPRITE.self_modulate.a = health/ MAX_HEALTH
		if (health <= 0):
			block_broken()
		
	func restart_timer():
		timer.start(DAMAGE_INTERVAL)
		

	func _on_timer_timeout() -> void:
		if (isTakingDamage):
			take_damage()
			restart_timer()
