extends Area2D

#for interactive objects
export (NodePath) onready var player = get_node(player)

var canIntr = false #whether you can interact

func _on_InteractArea_body_entered(body):
	#print("collided")
	canIntr = true
	pass

func _on_InteractArea_body_exited(body):
	#print("exited")
	canIntr = false
	pass
