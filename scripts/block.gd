extends breakable_block.BreakableBlock

const _MAX_HEALTH: float = 2
const _DAMAGE_INTERVAL: float = 0.1 # time between getting hit
const _EXP = 1
@onready var _PARENT_NODE = $StaticBody2D/CollisionShape2D
@onready var _SPRITE = $StaticBody2D/CollisionShape2D/Sprite2D

func _ready():
	super._setup(_MAX_HEALTH, _DAMAGE_INTERVAL, _PARENT_NODE, _SPRITE, _EXP)
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
