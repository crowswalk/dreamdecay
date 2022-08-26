extends Light2D

onready var player = self.get_parent()
onready var lightregion = $LightRegion/CollisionShape2D
onready var pickupregion = $PickupRegion/CollisionShape2D
var holding = true
var holdable = false
export var holdingpos : Vector2

func _ready():
	lightregion.disabled = true
	pickupregion.disabled = true
	pass # Replace with function body.

func _process(delta):
	if self.holding:
		rotate_light(player.direction)
	if Input.is_action_just_pressed("use_item"):
		toggle_flashlight(self.enabled)
	elif Input.is_action_just_pressed("switch_item"):
		toggle_using()

#for now, this gives the illusion of "switching items"
func toggle_using():
	if holding:
		holding = false
		$Sprite.visible = false
	else:
		holding = true
		$Sprite.visible = true

func toggle_flashlight(enabled): #turning the flashlight on/off
	if self.holding:
		if enabled:
			self.enabled = false
			lightregion.disabled = true
		else:
			self.enabled = true
			lightregion.disabled = false

func rotate_light(dir):
	if dir == Vector2(0, -1): #up
		rotation_degrees = 180
	elif dir == Vector2(1, 0): #right
		rotation_degrees = 270
	elif dir == Vector2(-1, 0): #left
		rotation_degrees = 90
	else: #down
		rotation_degrees = 0

func _on_PickupRegion_area_entered(area):
	if area.name == "PlayerVisible":
		holdable = true

func _on_PickupRegion_area_exited(area):
	if area.name == "PlayerVisible":
		holdable = false

func toggle_held(holding): #obsolete; negated the ability to pick up/put down items
	var dest = self.global_position
	if holding:
		player.remove_child(self)
		player.get_parent().add_child(self)
		self.global_position = dest
		self.holding = false
		pickupregion.disabled = false
	elif holdable:
		self.get_parent().remove_child(self)
		player.add_child(self)
		self.position = holdingpos
		self.holding = true
		pickupregion.disabled = true
