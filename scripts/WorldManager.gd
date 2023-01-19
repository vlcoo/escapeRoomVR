extends Spatial

onready var viewport = $ViewportContainer/Viewport

var current_area


func _ready():
	var VR = ARVRServer.find_interface("OpenVR");
	if VR and VR.initialize():
		viewport.arvr = true
		viewport.hdr = false
		VisualServer.viewport_attach_camera(
			viewport.get_viewport_rid(),
			viewport.get_node("ARVROrigin/PlayerCamera").get_camera_rid()
		)
		OS.vsync_enabled = false
		Engine.iterations_per_second = 90
	
	load_area("res://Scenes/Areas/MainMenu.tscn")


func load_area(which):
	var new_area = load(which).instance()
	add_child(new_area)
	$ViewportContainer/Viewport/ARVROrigin.translation = new_area.get_node("PlayerSpawn").translation
	remove_child(current_area)
	current_area = new_area
