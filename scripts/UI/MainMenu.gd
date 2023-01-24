extends Control


func _ready():
	$Button.grab_focus() 


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		Global.load_world_area("res://scripts/MazeGenerator/Maze3D.tscn")
