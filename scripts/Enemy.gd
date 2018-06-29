extends Area2D

onready var timer = $Timer
onready var collision_shape = $CollisionShape2D

export (int) var speed = 50
export (int) var health = 30 
export (PackedScene) var projectile

var is_dead = false
var can_shoot = true

func _ready():
	pass

func _process(delta):
	if can_shoot:
		shoot()

func _on_Timer_timeout():
	pass # replace with function body

func add_damage(damage):
	health -= damage
	if health <= 0:
		is_dead = true
		collision_shape.queue_free()
		hide()