extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var portal = get_child(0)
	portal.nextLevel = "test_1"
