extends Node2D

signal on_defeated

const OFFSET = 100

export (int) var speed = 100

var attack_position_y
var left_bound
var right_bound
var is_in_position = false
var direction = 1
var formation_size

func _ready():
	attack_position_y = rand_range(200, get_viewport_rect().size.y / 2)
	left_bound = position.x - OFFSET
	right_bound = position.x + OFFSET
	direction = 1 if rand_range(0, 100) > 50 else -1
	formation_size = get_children().size()

func _process(delta):
	_move_to_attack_position(delta)
	position.x += speed * direction * delta
	if position.x < left_bound:
		direction = 1
	elif position.x > right_bound:
		direction = -1 
	
func _move_to_attack_position(delta):
	if is_in_position:
		return
	# moves downward until it reaches attack position and halts  
	position.y += speed * delta
	if position.y >= attack_position_y:
		position.y = attack_position_y
		is_in_position = true

func _formation_defeated():
	emit_signal("on_defeated")
	queue_free()

func _on_Enemy_on_defeated():
	formation_size -= 1
	if formation_size <= 0:
		_formation_defeated()