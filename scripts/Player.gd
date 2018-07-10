extends KinematicBody2D

const SPEED = 500
const OFFSET = 10

export(PackedScene) var projectile
export (int) var health = 100

onready var sprite = $Sprite
onready var shoot_timer = $ShootTimer
onready var cannon_position = $CannonPosition
onready var collision_shape = $CollisionShape2D
onready var restart_timer = $RestartTimer

var screen_width
var player_deadband
var can_shoot = true

func _ready():
	screen_width = get_viewport_rect().size.x
	player_deadband = (sprite.texture.get_width() * scale.x) / 2 + OFFSET

func _process(delta):
	if not is_visible_in_tree():
		return
	if Input.is_action_pressed("player_left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("player_right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("player_shoot") and can_shoot:
		var new_projectile = projectile.instance()
		var local_pos = cannon_position.position
		new_projectile.position = get_global_transform() * local_pos
		get_parent().add_child(new_projectile)
		can_shoot = false;
		shoot_timer.start()
		print("projectile [%d] at pos: %s" % [new_projectile.get_instance_id(), new_projectile.position])
		
	position.x = clamp(position.x, player_deadband, screen_width - player_deadband)

func _on_Timer_timeout():
	can_shoot = true
	shoot_timer.stop()
	
func add_damage(damage):
	health -= damage
	if health <= 0:
		collision_shape.disabled = true
		hide()
		restart_timer.start()

func _on_RestartTimer_timeout():
	health = 20
	show()
	collision_shape.disabled = false