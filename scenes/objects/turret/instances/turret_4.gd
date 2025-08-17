extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var turret = get_child(0)
	turret.SHOOTING_INTERVAL = 0.2
	turret.DAMAGE = 7
	turret.DIRECTION = "DOWN"
	turret.BULLET_SCENE = load("res://scenes/bullets/bullet/bullet.tscn")
