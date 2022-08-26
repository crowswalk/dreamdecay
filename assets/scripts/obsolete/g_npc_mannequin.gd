 extends RigidBody2D

onready var sight = $RayCast2D
export var movspeed : float

var lastCollided = null
var paused = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if !paused:
		if sight.is_colliding():
			var colliding = sight.get_collider()
			#printCollision(colliding.name)
			if colliding.name == "PlayerVisible":
				moveMannequin(colliding.global_position)

func moveMannequin(pos):
	self.position = lerp(self.position, pos, movspeed)

func _on_InteractionArea_body_entered(body):
	if body.name == "Player" && !paused:
		GameCanvas.reset_level()

func _on_InteractionArea_area_entered(area):
	if area.name == "LightRegion":
		paused = true
		
func _on_InteractionArea_area_exited(area):
	if area.name == "LightRegion":
		paused = false

func printCollision(name):
	if name != lastCollided:
		lastCollided = name
		print(lastCollided)
