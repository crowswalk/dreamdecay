extends Node

#change current plane the player is on (dream or decay)

export (NodePath) onready var player = get_node(player)
onready var dream_layer = $Dream
onready var decay_layer = $Decay
onready var ground = $Ground
onready var walls = $Walls

export (TileSet) var dreamset 
export (TileSet) var decayset

#add enum

var dream = true

func _ready():
	call_deferred("removePlane", decay_layer)
	call_deferred("moveWalls", dream_layer)

func _physics_process(_delta):
	if Input.is_action_just_pressed("planeshift"):
		shift_plane()
		print("shifting")

#change TileMaps to specified TileSet
func shift_plane():
	if dream:
		dream = false
		ground.set_tileset(decayset)
		
		moveWalls(decay_layer)
		walls.set_tileset(decayset)
		
		movePlayer(decay_layer)
		
		removePlane(dream_layer)
		addPlane(decay_layer)
		

	else:
		dream = true
		ground.set_tileset(dreamset)
		
		moveWalls(dream_layer)
		walls.set_tileset(dreamset)
		
		movePlayer(dream_layer)
		
		removePlane(decay_layer)
		addPlane(dream_layer)
		
		
#add plane to scene root
func addPlane(thisplane):
	add_child(thisplane)
	
#remove plane from scene root
func removePlane(thisplane):
	self.remove_child(thisplane)

#move player to new parent	
func movePlayer(thisplane):
	player.get_parent().remove_child(player)
	thisplane.add_child(player)

#move NPC to new parent
func moveNPC(thisplane, thisNPC):
	thisNPC.get_parent().remove_child(thisNPC)
	thisplane.add_child(thisNPC)

#move wall to new parent
func moveWalls(thisplane):
	walls.get_parent().remove_child(walls)
	thisplane.add_child(walls)
