extends Control

onready var panel = $Panel
onready var scroll = $Panel/MarginContainer/ScrollContainer
onready var vbox = $Panel/MarginContainer/ScrollContainer/VBoxContainer
onready var player = $InkPlayer
var textEntry = preload("res://assets/ui/premade/pre_ui_dialoguebox_entry.tscn")
var choiceBox = preload("res://assets/ui/premade/pre_ui_dialoguebox_choicebox.tscn")
var button = preload("res://assets/ui/premade/pre_ui_dialoguebox_button.tscn")
export var talk : bool

func _ready():
	player.LoadStory()
	if talk:
		Gamevars.mode = "talk"
	delete_children(vbox)
	

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
	yield(get_tree(), "idle_frame")
	scroll.set_v_scroll(scroll.get_v_scrollbar().max_value)


func create_entry(text):
	var newEntry = textEntry.instance()
	vbox.add_child(newEntry)
	newEntry.text = text
	
func create_choicebox(choices):
	var newChoiceBox = choiceBox.instance()
	delete_children(newChoiceBox)
	for choice in choices:
		var newChoice = button.instance()
		newChoice.set_button_text(choice)
		newChoiceBox.add_child(newChoice)
	vbox.add_child(newChoiceBox)

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
