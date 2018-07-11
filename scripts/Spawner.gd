extends Node

const SPAWN_OFFSET = 100

export (PackedScene) var formation

var screen_centre

func _ready():
	randomize()
	screen_centre = get_viewport().get_visible_rect().size.x / 2
	_spawn_formation()

func _spawn_formation():
	var position_x = rand_range(screen_centre - SPAWN_OFFSET, screen_centre + SPAWN_OFFSET)
	var position_y = -150
	var new_formation = formation.instance()
	new_formation.position = Vector2(position_x, position_y)
	new_formation.connect("on_defeated", self, "_on_formation_defeated")
	add_child(new_formation)
	
func _on_formation_defeated():
	_spawn_formation()
