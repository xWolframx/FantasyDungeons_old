extends Node2D

class_name GlobalMapLocation

onready var player = $PlayerGlobalMap
onready var line2d = $Line2D
onready var navigation2d = $Navigation2D
onready var camera_location2d = $CameraLocation2D

func _ready():
	player.position = $Position2D.position
	camera_location2d.position = $Position2D.position
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var new_position = get_global_mouse_position()
			var path = navigation2d.get_simple_path(player.position, new_position)
			line2d.points = path
			player.path = path
	pass
