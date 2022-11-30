extends Spatial

var current_area


func _ready():
	current_area = $Terrain


func load_area(which):
	var new_area = load(which)
	add_child(new_area)
	$ARVROrigin.translation = new_area.get_node("PlayerSpawn").translation
	current_area = new_area
	remove_child(current_area)
