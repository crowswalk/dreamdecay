extends Node2D

export(StreamTexture) var dreamsheet
export(StreamTexture) var decaysheet

onready var dreampos = self.get_global_position()
onready var decaypos
export var decayposition : Vector2

export var inDream : bool = true
export var inDecay : bool = true

func _ready():
	decaypos = dreampos.move_toward(decayposition, 1)

func set_sheet(sheetId):
	$Sprite.set_texture(sheetId)
	
func set_pos(posId):
	self.set_global_position(posId)
	pass
