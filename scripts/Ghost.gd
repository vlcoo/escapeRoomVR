extends Spatial

var diag_ui
export var diag_timeline_name = "Test"


func _ready():
	$VRGUI/GUI_Mesh.set_transparent(true)


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Dialogic.next_event()


func start_diag():
	diag_ui = Dialogic.start(diag_timeline_name)
	$VRGUI/GUI.add_child(diag_ui, true)
	$VRGUI/GUI_Mesh.render_viewport()


func _on_AreaDialog_area_entered(area: Area):
	start_diag()


func _on_AreaDialog_area_exited(area: Area):
	for dialog in $VRGUI/GUI.get_children():
		dialog.queue_free();
