extends TileMapLayer
var initalState: PackedByteArray = PackedByteArray()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initalState = self.tile_map_data
	pass # Replace with function body.

func undo():
	self.tile_map_data = initalState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("undo"):
		undo()
