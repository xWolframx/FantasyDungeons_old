extends Area2D

class_name AreaInputButton

export(PackedScene) var LoadSceane
export(String) var LoadSceane2
export(String) var NameLocation
onready var mouse_entered = false
onready var player_entered = false

func _ready():
	$Button.text += NameLocation

func _input(event):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(1) && !mouse_entered:
		$Button.disabled = true
		$Button.visible = false
	pass

func _on_AreaInputButton_mouse_entered():
	$NameLocation.set_global_position(get_global_mouse_position() + Vector2(0, -15))
	$NameLocation.text = NameLocation

func _on_AreaInputButton_mouse_exited():
	$NameLocation.text = ""
	
func _on_AreaInputButton_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && Input.is_mouse_button_pressed(2):
		$Button.set_global_position(get_global_mouse_position() + Vector2(0, -35))
		$Button.disabled = false
		$Button.visible = true

func enter_on_location():
	if player_entered:
		if LoadSceane != null:
			get_tree().change_scene_to(LoadSceane)
		else:
			get_tree().change_scene(LoadSceane2)

func _on_Button_mouse_entered():
	mouse_entered = true
	
func _on_Button_mouse_exited():
	mouse_entered = false


func _on_AreaInputButton_body_entered(body):
	if body.get_groups().find("Player"):
		player_entered = true
	pass # Replace with function body.


func _on_AreaInputButton_body_exited(body):
	if body.get_groups().find("Player"):
		player_entered = false
	pass # Replace with function body.
