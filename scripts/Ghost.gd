extends Spatial

var diag_ui


func _ready():
	$VRGUI/GUI_Mesh.set_transparent(true)
	diag_ui = Dialogic.start('Test')
	$VRGUI/GUI.add_child(diag_ui, true)
	$VRGUI/GUI_Mesh.render_viewport()
