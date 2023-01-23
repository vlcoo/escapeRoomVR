extends Spatial


func _ready():
	$VRGUI/GUI.add_child(load("res://Scenes/UI/MainMenu.tscn").instance())
	$VRGUI.render_viewport()
	$VRGUI/GUI/MainMenu/Button.grab_focus()
