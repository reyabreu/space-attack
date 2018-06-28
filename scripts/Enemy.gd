extends Area2D

onready var timer = $Timer
onready var collision_shape = $CollisionShape2D

export var speed = 50
export var health = 30 

var is_dead = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Timer_timeout():
	pass # replace with function body

func add_damage(damage):
	health -= damage
	if health <= 0:
		is_dead = true
		collision_shape.queue_free()
		hide()