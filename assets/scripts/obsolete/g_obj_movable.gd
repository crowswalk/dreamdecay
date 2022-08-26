extends "res://assets/scripts/g_obj_interactive.gd"


var distfromPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if canIntr:
		if Input.is_action_pressed("interact"):

			var playerPos = player.global_transform.origin
			var selfPos = self.get_parent().global_transform.origin

			var dist = selfPos - playerPos
			
			var newPos = playerPos + dist + player.speed * player.direction

			self.get_parent().set_global_position(newPos)


#	pass
