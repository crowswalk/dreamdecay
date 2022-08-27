extends "res://assets/scripts/g_obj_interactive.gd"

export var normalSprite : Texture
export var pressedSprite : Texture
onready var lightregion = $Light2D/LightRegion/CollisionShape2D
var inBody = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if canIntr:
		$Sprite.texture = pressedSprite
		$Light2D.enabled = true
		lightregion.disabled = false
	else:
		$Sprite.texture = normalSprite
		$Light2D.enabled = false
		lightregion.disabled = true
		
#	pass

func _on_PressurePlate_area_entered(area):
	print(area.name)
	canIntr = true
	inBody += 1
	pass # Replace with function body.


func _on_PressurePlate_area_exited(area):
	inBody -= 1
	if inBody == 0:
		canIntr = false
	pass # Replace with function body.
