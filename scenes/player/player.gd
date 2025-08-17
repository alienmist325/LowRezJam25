extends CharacterBody2D

const MULT = 1

var level: float = INITIAL_LEVEL
const INITIAL_LEVEL = 1
var exp: int = 0

const ACC = 20 * MULT
const DEC = 5 * MULT
const MAX_SPEED = 40 * MULT
const unitVec = Vector2(1,1)

@onready var animPlayer = $PlayerShape/AnimationPlayer
# @onready var idleSprite = $CollisionShape2D/Sprite2D2
# @onready var movingSprite = $CollisionShape2D/Sprite2D
@onready var attackArea = $Attack/CollisionShape2D
@onready var playerArea = $PlayerShape


var isAttacking = false
var isOverlappingBlock = false
var isMoving = false
var blockMovement = false
var hasStuckInBlockImmunity = false

func update_level():
	# level = 3
	level = int(exp / 20) + INITIAL_LEVEL # Should it be a float or an int change?
	# print(exp)
	# print(level)

func apply_level_changes():
	var growthFactor =  level / 3
	# print(growthFactor)
	# idleSprite.scale = growthFactor
	# movingSprite.scale = growthFactor
	
	# We ensure the attackArea >= 0.4 always so that even tiny amoeba can reach surrounding blocks and break them
	attackArea.scale = max(growthFactor, 0.4) * unitVec
	playerArea.scale = growthFactor * unitVec
	
func undo():
	exp = 0

	SignalBus.undo.emit()
	blockInputsTemporarily()
	
func blockInputsTemporarily():
	var timer = Timer.new()
	self.add_child(timer)
	
	blockMovement = true
	velocity = Vector2.ZERO
	
	timer.start(0.5)
	timer.timeout.connect(removeMovementBlock)
	
func removeMovementBlock():
	blockMovement = false
	
func isStuckInBlock():
	return !isMoving and isOverlappingBlock and !hasStuckInBlockImmunity

func _physics_process(delta: float) -> void:
	
	update_level()
	apply_level_changes()
	
	var jitterFixer = fix_jitter.JitterFixer.new()
	# var altJitterFixer = fix_jitter.AltJitterFixer.new(position)
	
	# animPlayer.play("moving")
	
	if velocity == Vector2.ZERO:
		isMoving = false
	else:
		isMoving = true
		
	if (isStuckInBlock()):
		print("It's time to die")
		SignalBus.death.emit()
	
	if blockMovement:
		velocity = Vector2.ZERO
		return
	
	if Input.is_action_just_pressed("undo"):
		undo()
	
	if Input.is_action_just_pressed("attack"):
		isAttacking = true
		animPlayer.play("attack")
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# altJitterFixer.before(position)
	
	if direction.x:
		velocity.x = move_toward(velocity.x, sign(direction.x) * MAX_SPEED, abs(direction.x * ACC))
	else:
		velocity.x = move_toward(velocity.x, 0, DEC)

	if direction.y:
		velocity.y = move_toward(velocity.y, sign(direction.y) * MAX_SPEED, abs(direction.y * ACC))
	else:
		velocity.y = move_toward(velocity.y, 0, DEC)
		

		
	move_and_slide()
		
	position = jitterFixer.fix_jitter(direction, position)
	# position = altJitterFixer.alt_fix_jitter(velocity, position)

func _ready():
	animPlayer.play("RESET")
	SignalBus.block_broken.connect(on_block_broken)
	SignalBus.no_blocks_player_is_inside.connect(on_no_blocks_player_is_inside_change)
	SignalBus.bullet_hits_player.connect(on_bullet_hits_player)
	
func on_block_broken(_exp: int):
	exp += _exp
	
func on_no_blocks_player_is_inside_change(number: int):
	if (number > 0):
		isOverlappingBlock = true
	else:
		isOverlappingBlock = false

func on_bullet_hits_player(dmg: float):
	hasStuckInBlockImmunity = true
	var timer = Timer.new()
	add_child(timer)
	timer.start(0.5)
	timer.timeout.connect(turnOffStuckInBlockImmunity)
	if dmg > level:
		SignalBus.death.emit()
		
func turnOffStuckInBlockImmunity():
	hasStuckInBlockImmunity = false
	

func _on_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Breakable"):
		area.start_taking_damage()		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animPlayer.play("RESET")

func _on_attack_body_entered(body: Node2D) -> void:
	# Not relevant
	pass


func _on_attack_area_exited(area: Area2D) -> void:
	if area.is_in_group("Breakable"):
		area.stop_taking_damage()
