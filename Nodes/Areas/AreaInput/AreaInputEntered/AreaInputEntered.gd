extends Area2D

class_name AreaInputEntered

export(PackedScene) var LoadSceane
export(String) var NameLocation

func _on_AreaInputEntered_mouse_entered():
	$NameLocation.set_global_position(get_global_mouse_position() + Vector2(0, -15))
	$NameLocation.text = NameLocation

func _on_AreaInputEntered_mouse_exited():
	$NameLocation.text = ""

func _on_AreaInputEntered_body_entered(body):
	get_tree().change_scene_to(LoadSceane)
