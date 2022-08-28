tool
extends Node2D

export(StreamTexture) var dreamsheet
export(StreamTexture) var decaysheet

onready var dreampos = self.get_global_position()
onready var decaypos
export var decayX: int
export var decayY: int

export var inDream : bool = true
export var inDecay : bool = true

func _ready():
	decaypos = dreampos + Vector2(decayX, decayY)

func _process(_delta):
	if Engine.editor_hint:
		$Hint.visible = true
		$Hint.set_position(Vector2(decayX, decayY))
		$Hint.set_texture(decaysheet)

func set_sheet(sheetId):
	$Sprite.set_texture(sheetId)
	
func set_pos(posId):
	self.set_global_position(posId)
	pass
