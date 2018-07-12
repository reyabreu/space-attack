extends Area2D

signal on_defeated

onready var shoot_timer = $ShootTimer
onready var collision_shape = $CollisionShape2D
onready var cannon_position = $CannonPosition
onready var audio = $Audio

export (AudioStreamSample) var shoot_audio
export (AudioStreamSample) var explosion_audio

export (int) var speed = 50
export (int) var health = 30 
export (PackedScene) var projectile

var is_dead = false
var can_shoot = true

func _ready():
	audio.stream = shoot_audio

func _process(delta):
	if can_shoot and !is_dead:
		_shoot()

func _shoot():
	var new_projectile = projectile.instance()
	new_projectile.position = get_global_transform() * cannon_position.position
	#get_tree().get_root().add_child(new_projectile)
	get_parent().get_parent().add_child(new_projectile)
	can_shoot = false
	shoot_timer.start()
	audio.play()

func _on_Timer_timeout():
	can_shoot = true

func add_damage(damage):
	health -= damage
	if health <= 0:
		is_dead = true
		audio.stream = explosion_audio
		collision_shape.queue_free()
		hide()
		audio.play()
		yield(audio, "finished")
		emit_signal("on_defeated")
