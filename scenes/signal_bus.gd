extends Node

var noBlocksPlayerIsInside = 0

signal block_broken(exp: int)
signal player_overlaps_block(value: bool)
signal no_blocks_player_is_inside(number: int)
signal death()
signal undo()
signal bullet_hits_player(dmg: int)
signal go_to_level(level: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.player_overlaps_block.connect(on_player_overlaps_block_change)
	SignalBus.death.connect(reset_level)
	SignalBus.undo.connect(on_undo)
	SignalBus.go_to_level.connect(on_go_to_level)
	
func reset_global_variables():
	noBlocksPlayerIsInside = 0

func on_undo():
	reset_global_variables()

func reset_level():
	reset_global_variables()
	get_tree().reload_current_scene()
	
func on_go_to_level(level: String):
	reset_global_variables()
	get_tree().change_scene_to_file("res://scenes/levels/level_" + level + ".tscn")
	
	
func on_player_overlaps_block_change(value: bool):
	# Indeed, each time a block emits this signal, it tells us that the player is inside one more or one fewer block
	if (value):
		noBlocksPlayerIsInside += 1
	else:
		noBlocksPlayerIsInside -= 1
		
	no_blocks_player_is_inside.emit(noBlocksPlayerIsInside)
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
