extends Area2D

var nextLevel: String = "test_1" # The default, but can be overriden

func _ready():
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		SignalBus.go_to_level.emit(nextLevel)
