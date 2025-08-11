extends CharacterBody2D

const MULT = 1

const ACC = 20 * MULT
const DEC = 5 * MULT
const MAX_SPEED = 40 * MULT

@onready var animPlayer = $CollisionShape2D/AnimationPlayer

var isAttacking = false

func _physics_process(delta: float) -> void:
	
	var jitterFixer = fix_jitter.JitterFixer.new()
	# var altJitterFixer = fix_jitter.AltJitterFixer.new(position)
	
	# animPlayer.play("moving")
	
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

func _on_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Breakable"):
		# print("should break")
		area.start_taking_damage()
		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animPlayer.play("RESET")


func _on_attack_body_entered(body: Node2D) -> void:
	# print("signal here1")
	# print(body.name)
	if body.is_in_group("hurtbox"):
		pass
		# print("signal here2")
		# area.take_damage()


func _on_attack_area_exited(area: Area2D) -> void:
	# print("no longer attacking")
	if area.is_in_group("Breakable"):
		area.stop_taking_damage()
