extends KinematicBody2D

#player movement and sprite animation triggers

var velocity : Vector2 = Vector2()
var direction : Vector2 = Vector2()
export var speed : float

onready var animPlayer = $AnimationPlayer
var idle : String = "DownIdle"

func read_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
		direction = Vector2(0, -1)
		animPlayer.play("Up")
		idle = "UpIdle"
		
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed
		direction = Vector2(0, 1)
		animPlayer.play("Down")
		idle = "DownIdle"
	
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		direction = Vector2(-1, 0)
		animPlayer.play("Left")
		idle = "LeftIdle"
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x += speed
		direction = Vector2(1, 0)
		animPlayer.play("Right")
		idle = "RightIdle"
	else:
		animPlayer.play(idle);
		pass
		
	velocity = velocity.normalized()
	velocity = move_and_slide(velocity * 100)

func _physics_process(_delta):
	read_input()
