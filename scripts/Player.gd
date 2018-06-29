extends KinematicBody2D

const SPEED = 500
const OFFSET = 10

export(PackedScene) var projectile

onready var sprite = $Sprite
onready var timer = $Timer

var screen_width
var player_deadband
var can_shoot = true

func _ready():
	screen_width = get_viewport_rect().size.x
	player_deadband = (sprite.texture.get_width() * scale.x) / 2 + OFFSET

func _process(delta):
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("player_right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("player_shoot") and can_shoot:
		var new_projectile = projectile.instance()
		get_parent().add_child(new_projectile)
		new_projectile.position = position 
		can_shoot = false;
		timer.start()
		
	position.x = clamp(position.x, player_deadband, screen_width - player_deadband)

func _on_Timer_timeout():
	can_shoot = true
	timer.stop()
	
func add_damage(damage):
	pass