extends Node2D

class_name Location

onready var player = $YSort/PlayerLocation
onready var line2d = $YSort/Line2D
onready var navigation2d = $Navigation2D
onready var navigation_polygon_instance = $Navigation2D/NavigationPolygonInstance

func _ready():
	$CameraLocation2D.position = player.position
	
	navigation_polygon_instance.enabled = false
	navigation_polygon_instance.enabled = true
	pass
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var new_position = get_global_mouse_position()
			var path = navigation2d.get_simple_path(player.position, new_position)
			line2d.points = path
			player.path = path

func tile_remove_from_navigation(tilemap, id):
	var polygon = navigation_polygon_instance.get_navigation_polygon()
	var used_object_tiles = tilemap.get_used_cells_by_id(id)
	for tile in used_object_tiles:
		var new_polygon = PoolVector2Array()
		var polygon_offset = tilemap.map_to_world(tile) - Vector2(tilemap.get_cell_size()[0]/2, 0)
		var tile_region = tilemap.get_cell_autotile_coord(tile[0], tile[1])
		var tile_transform = tilemap.get_tileset().tile_get_shape_transform(id, tile_region[0])
		var polygon_bp = tilemap.get_tileset().tile_get_shape(id, tile_region[0]).get_points()
		for vertex in polygon_bp:
			vertex += polygon_offset
			new_polygon.append(tile_transform.xform(vertex))
		polygon.add_outline(new_polygon)
	polygon.make_polygons_from_outlines()
	navigation_polygon_instance.set_navigation_polygon(polygon)
