extends breakable_block.BreakableBlock

const _MAX_HEALTH: float = 10
const _DAMAGE_INTERVAL: float = 0.1 # time between getting hit
const _EXP = 100
@onready var _PARENT_NODE = $CollisionShape2D
@onready var _SPRITE = $CollisionShape2D/Sprite2D

func _ready():
	super._setup(_MAX_HEALTH, _DAMAGE_INTERVAL, _PARENT_NODE, _SPRITE, _EXP)
	super()
