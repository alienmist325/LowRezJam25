extends CharacterBody2D

const MULT = 1

var level: float = INITIAL_LEVEL
const INITIAL_LEVEL = 1
var exp: int = 0

const ACC = 20 * MULT
const DEC = 5 * MULT
const MAX_SPEED = 40 * MULT
const unitVec = Vector2(1,1)

@onready var usualPlayer = $CollisionShape2D/UsualPlayer
@onready var animPlayer = $CollisionShape2D/AnimationPlayer
# @onready var idleSprite = $CollisionShape2D/Sprite2D2
# @onready var movingSprite = $CollisionShape2D/Sprite2D
@onready var attackArea = $Attack/CollisionShape2D
@onready var playerArea = $CollisionShape2D

var isAttacking = false
var counter = 0

func play_animation(anim_name: StringName) -> void:
	if !isAttacking:
		counter+=1
		#print(str(counter)+str(anim_name))
		animPlayer.play(anim_name)

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

func _physics_process(delta: float) -> void:
	
	update_level()
	apply_level_changes()
	
	var jitterFixer = fix_jitter.JitterFixer.new()
	# var altJitterFixer = fix_jitter.AltJitterFixer.new(position)
	
	# animPlayer.play("moving")
	
	if Input.is_action_just_pressed("attack"):
		animPlayer.play("attack")
	
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if Input.is_key_pressed(KEY_LEFT):
		usualPlayer.rotation_degrees = 0
		usualPlayer.flip_h = false
		play_animation("accelerate_H")
	if Input.is_key_pressed(KEY_RIGHT):
		usualPlayer.rotation_degrees = 0
		usualPlayer.flip_h = true
		play_animation("accelerate_H")
		
	if Input.is_key_pressed(KEY_LEFT) and Input.is_key_pressed(KEY_UP):
		usualPlayer.flip_h = false
		play_animation("accelerate_D")
	elif Input.is_key_pressed(KEY_RIGHT) and Input.is_key_pressed(KEY_UP):
		usualPlayer.flip_h = true
		play_animation("accelerate_D")
	elif Input.is_key_pressed(KEY_LEFT) and Input.is_key_pressed(KEY_DOWN):
		usualPlayer.flip_h = false
		usualPlayer.rotation_degrees = -90
		play_animation("accelerate_D")
	elif Input.is_key_pressed(KEY_RIGHT) and Input.is_key_pressed(KEY_DOWN):
		usualPlayer.flip_h = true
		usualPlayer.rotation_degrees = 90
		play_animation("accelerate_D")

	# altJitterFixer.before(position)
	if direction.x:
		velocity.x = move_toward(velocity.x, sign(direction.x) * MAX_SPEED, abs(direction.x * ACC))


		#animPlayer.play("accelerate_H")
		
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
	
func on_block_broken(_exp: int):
	exp += _exp

func _on_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Breakable"):
		area.start_taking_damage()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "attack"):
		isAttacking = false
		play_animation("accelerate_H")


func _on_attack_body_entered(body: Node2D) -> void:
	# Not relevant
	pass


func _on_attack_area_exited(area: Area2D) -> void:
	if area.is_in_group("Breakable"):
		area.stop_taking_damage()


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if (anim_name == "attack"):
		isAttacking = true
	if (anim_name == "accelerate_H"):
		print("yea-35")
	
	
