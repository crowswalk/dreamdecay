extends Control

onready var panel = $Panel
onready var scroll = $Panel/MarginContainer/ScrollContainer
onready var vbox = $Panel/MarginContainer/ScrollContainer/VBoxContainer
onready var player = $InkPlayer

var textEntry = preload("res://assets/premade/pre_ui_dialoguebox_entry.tscn")
var choiceBox = preload("res://assets/premade/pre_ui_dialoguebox_choicebox.tscn")
var choice = preload("res://assets/premade/pre_ui_dialoguebox_choice.tscn")

export var talk : bool #for isolated testing purposes; default to false for full game

var choiceArray #array of strings representing current choices
var displayingChoices #whether we're in choice mode
var currentChoice = 0 #index of selected choice in choice array
var currentChoicebox #currently displaying node of choice buttons
var currentChoiceboxEntries #current choice buttons

func _ready():
	delete_children(vbox)
	panel.set_visible(false)
	player.LoadStory()
	if talk:
		Gamevars.mode = "talk"

func _process(_delta):
	if Gamevars.mode == "talk":
		if displayingChoices:
			if Input.is_action_just_released("choice_select_down"): #scrolling through choices
				#this is for highlighting the selected choice
				currentChoiceboxEntries[currentChoice].set_highlighted(false)
				currentChoice += 1
				if currentChoice >= choiceArray.size():
					currentChoice = 0
				currentChoiceboxEntries[currentChoice].set_highlighted(true)
			
			if Input.is_action_just_pressed("interact"): #choice is submitted
				vbox.remove_child(currentChoicebox)
				create_entry(choiceArray[currentChoice])
				
				if currentChoice < 0:
					currentChoice = 0
				player.ChooseChoiceIndex(currentChoice)
				
				_proceed()
		
		elif Input.is_action_just_pressed("interact"):
			_proceed()

#progress the ink player
func _proceed():
	if !player.get_CanContinue() && !player.get_HasChoices(): #end of conversation
		clear_and_reset()
	elif !player.get_HasChoices(): #create normal text entry
		player.Continue()
		create_entry(player.get_CurrentText())
		
	elif !displayingChoices: #create entry with choices
		choiceArray = player.get_CurrentChoices()
		create_choicebox(choiceArray)
		displayingChoices = true
		currentChoice = -1
		
	#scroll to bottom when new message appears (make this tween later)
	yield(get_tree(), "idle_frame")
	scroll.set_v_scroll(scroll.get_v_scrollbar().max_value)

#create normal text entry
func create_entry(text):
	var newEntry = textEntry.instance()
	vbox.add_child(newEntry)
	newEntry.text = text
	displayingChoices = false

#create entry with choices
func create_choicebox(choices):
	var newChoiceBox = choiceBox.instance()
	delete_children(newChoiceBox)
	
	for option in choices:
		var newChoice = choice.instance()
		newChoice.set_choice_text(option)
		newChoiceBox.add_child(newChoice)
		
	vbox.add_child(newChoiceBox)
	currentChoicebox = newChoiceBox
	currentChoiceboxEntries = newChoiceBox.get_children()

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func clear_and_reset(): #for when the conversation has ended; reset everything
	panel.set_visible(false)
	player.Reset()
	player.LoadStory()
	delete_children(vbox)
	Gamevars.mode = "walk"
