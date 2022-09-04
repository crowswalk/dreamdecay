extends Control

onready var panel = $Panel
onready var vbox = $Panel/MarginContainer/ScrollContainer/VBoxContainer
onready var player = $InkPlayer
var textEntry = preload("res://assets/ui/premade/pre_ui_dialoguebox_entry.tscn")

func _ready():
	Gamevars.mode = "talk"
	delete_children(vbox)
	_proceed()

func _process(_delta):
	if Gamevars.mode == "talk":
		panel.set_visible(true)
		if Input.is_action_just_pressed("interact"):
			_proceed()
	else:
		panel.set_visible(false)
		

func _proceed():
	
	if !player.get_HasChoices(): #normal text
		player.Continue()
		create_entry(player.get_CurrentText())
	else: #new choice node
		create_choicebox(player.get_CurrentChoices())


func create_entry(text):
	var newEntry = textEntry.instance()
	vbox.add_child(newEntry)
	newEntry.text = text
	
func create_choicebox(choices):
	for choice in choices:
		create_entry(choice)

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
