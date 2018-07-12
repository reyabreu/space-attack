extends Node

onready var hud = $HUD
onready var player = $Player 

func _ready():
	hud.set_maximum_health(player.health)
	hud.reset_health()
	hud.show_message("Space Attack!")

func _on_Player_player_hit():
	hud.set_health(player.health)

func _on_HUD_empty_health():
	hud.show_message("Game Over!")
