extends Area2D

export var speed = 200
export var damage = 10

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	position.y -= speed * delta

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.add_damage(damage)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()