extends Spatial


func _ready():
	$VRGUI/GUI.add_child(load("res://Scenes/UI/MainMenu.tscn").instance())
