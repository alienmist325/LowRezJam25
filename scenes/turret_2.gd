extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var turret = get_child(0)
	turret.DIRECTION = "LEFT"
	turret.BULLET_SCENE = load("res://scenes/seeking_bullet.tscn")
