extends Control


func _ready():
	$Button.grab_focus()


func _on_Button_pressed():
	Global.load_world_area("res://scripts/MazeGenerator/Maze3D.tscn")
