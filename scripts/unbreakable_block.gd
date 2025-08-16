extends Area2D

var playerSuffocator = opaque_block.PlayerSuffocator.new()

func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerSuffocator._process(self)
