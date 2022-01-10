extends Camera2D

class_name CameraLocation2D

var dragging = false
var old_position = Vector2(0, 0)
var zoom_step = 1.03
var max_zoom_top = Vector2(1.7,  1.7)
var max_zoom_bottom = Vector2(0.7, 0.7)

func _ready():
	old_position = get_global_position()

func _process(delta):
	if zoom > max_zoom_top:
		zoom = max_zoom_top
	if zoom < max_zoom_bottom:
		zoom = max_zoom_bottom

func _unhandled_input(event):
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_at_point(zoom_step,mouse_position)
			elif event.button_index == BUTTON_WHEEL_DOWN:
				zoom_at_point(1/zoom_step,mouse_position)
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("click_middle_mouse"):
			dragging = true
			old_position = event.position
		else:
			dragging = false
	elif event is InputEventMouseMotion && dragging:
		get_tree().set_input_as_handled()
		position += (old_position - event.position)
		old_position = event.position

func zoom_at_point(zoom_change, point):
	var c0 = global_position # camera position
	var v0 = get_viewport().size # vieport size
	var c1 # next camera position
	var z0 = zoom # current zoom value
	var z1 = z0 * zoom_change # next zoom value

	c1 = c0 + (-0.5*v0 + point)*(z0 - z1)
	if zoom > max_zoom_top:
		zoom = max_zoom_top
	elif zoom < max_zoom_bottom:
		zoom = max_zoom_bottom
	else:
		zoom = z1
	global_position = c1
