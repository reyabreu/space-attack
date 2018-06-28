extends Area2D

const OFFSET = 300
export var speed = 200
export var damage = 10

var screen_out_of_bounds 

func _ready():
	screen_out_of_bounds = -abs(get_viewport_rect().size.y + OFFSET)
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	position.y -= speed * delta
	if position.y <= screen_out_of_bounds:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.add_damage(damage)
		queue_free()