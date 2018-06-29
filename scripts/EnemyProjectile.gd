extends Area2D

export (int) var speed = 450
export (int) var damage = 10

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_area_entered(area):
	if area.name == "Player":
		area.add_damage(damage)