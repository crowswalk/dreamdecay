extends Control

onready var panel = $Panel

func _process(_delta):
	if Gamevars.mode == "talk":
		panel.set_visible(true)
	else:
		panel.set_visible(false)
