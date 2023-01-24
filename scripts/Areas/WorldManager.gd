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
	
	load_area("res://Escape_Room_Scenes/MainMenu.tscn")


func load_area(which, also_remove_current: bool = true):
	var scene_trs = load(which)
	var scene = scene_trs.instance()
	add_child(scene)
	
	$ViewportContainer/Viewport/ARVROrigin.global_translation = scene.get_node("PlayerSpawn").global_translation
	$ViewportContainer/Viewport/ARVROrigin.world_scale = 1 if "MainMenu" in which else 0.5
	
	if also_remove_current:
		remove_child(current_area)
	current_area = scene
