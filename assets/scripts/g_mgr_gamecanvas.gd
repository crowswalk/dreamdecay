extends Node2D

#intialize game variables
onready var viewport_container = $ViewportContainer
onready var viewport = $ViewportContainer/Viewport
onready var current_level = $ViewportContainer/Viewport/Level
onready var camera = $ViewportContainer/Viewport/Level/Camera2D

func _process(delta):
	var cam_pos = Vector2(clamp(camera.following.global_position.x, camera.cam_min.x, camera.cam_max.x), clamp(camera.following.global_position.y, camera.cam_min.y, camera.cam_max.y))
	
	camera.actual_cam_pos = lerp(camera.actual_cam_pos, cam_pos, camera.lerpSpeed * delta)

	var cam_subpixel_pos = camera.actual_cam_pos.round() - camera.actual_cam_pos

	viewport_container.material.set_shader_param("cam_offset", cam_subpixel_pos)

	camera.global_position = camera.actual_cam_pos.round()
	
	if Input.is_action_just_pressed("reset"):
		reset_level()

func reset_level():
	current_level.get_tree().change_scene(current_level.get_tree().current_scene.filename)


