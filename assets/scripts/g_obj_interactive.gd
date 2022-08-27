extends Area2D

#abstract for object you can interact with

var canIntr = false #whether you can interact

func _process(_delta):
	if canIntr:
		if Input.is_action_just_pressed("interact"):
			print("interacting")
			pass

func _on_InteractArea_body_entered(body):
	if body.name == "Player":
		canIntr = true
	pass

func _on_InteractArea_body_exited(body):
	if body.name == "Player":
		canIntr = false
	pass
