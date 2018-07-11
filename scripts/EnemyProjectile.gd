extends Area2D

export (int) var speed = 450
export (int) var damage = 10

func _ready():
	z_index = -5
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	position.y += speed * delta	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_body_entered(body):
	if body.name == "Player":
		body.add_damage(damage)
		queue_free()