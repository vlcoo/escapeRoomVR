extends Control

onready var focuseable_holder = $GridContainer


func _process(delta):
	$Mask.visible = Global.clues_solved.size() >= 3


func _ready():
	$GridContainer/Heidi.grab_focus()


func reveal_solver():
	$Mask.visible = false


func _on_Nathan_button_up():
	Global.solve_mystery(false)
	 

func _on_Heidi_button_up():
	Global.solve_mystery(false)


func _on_Nicole_button_up():
	Global.solve_mystery(false)


func _on_Isaas_button_up():
	Global.solve_mystery(false)


func _on_Pedro_button_up():
	Global.solve_mystery(true)
