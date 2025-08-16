extends breakable_block.BreakableBlock

const _MAX_HEALTH: float = 2
const _DAMAGE_INTERVAL: float = 0.1 # time between getting hit
const _EXP = 1
@onready var _PARENT_NODE = $Block/CollisionShape2D
@onready var _SPRITE = $Block/CollisionShape2D/Sprite2D

var playerSuffocator = opaque_block.PlayerSuffocator.new()

func _ready():
	super._setup(_MAX_HEALTH, _DAMAGE_INTERVAL, _PARENT_NODE, _SPRITE, _EXP)
	super()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playerSuffocator._process(self)


func block_broken():
	if (playerSuffocator.playerOverlapsBlock):
		SignalBus.player_overlaps_block.emit(false)
	super()
