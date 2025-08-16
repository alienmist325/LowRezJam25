extends Area2D

var SHOOTING_INTERVAL: float = 0.1 # time between getting hit
var DIRECTION = "LEFT"
var VELOCITY = 20
var BULLET_SCENE: PackedScene = load("res://scenes/bullets/bullet/bullet.tscn")

var timer: Timer

func setup(_SHOOTING_INTERVAL, _DIRECTION, _VELOCITY, _BULLET_SCENE):
	SHOOTING_INTERVAL = _SHOOTING_INTERVAL
	DIRECTION = _DIRECTION
	VELOCITY = _VELOCITY
	BULLET_SCENE = _BULLET_SCENE

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.start(SHOOTING_INTERVAL)
	timer.timeout.connect(shoot)
	
func shoot():
	var bullet = BULLET_SCENE.instantiate()
	add_child(bullet)
	var bulletBody = bullet.get_child(0)
	bulletBody.DIRECTION = DIRECTION
	bulletBody.VELOCITY = VELOCITY
	timer.start(SHOOTING_INTERVAL)

func _process(delta: float):
	pass
	
