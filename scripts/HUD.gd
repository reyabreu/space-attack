extends CanvasLayer

onready var health_bar = $HealthBar
onready var message_label = $MessageLabel
onready var message_timer = $MessageTimer

signal empty_health
signal message_shown

func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()

func _on_MessageTimer_timeout():
	message_label.hide()
	emit_signal("message_shown")

func reset_health():
	health_bar.value = health_bar.max_value
	
func set_maximum_health(maximum_health):
	health_bar.max_value = maximum_health
	
func set_health(health):
	health_bar.value = health
	if health_bar.value <= health_bar.min_value:
		emit_signal("empty_health")