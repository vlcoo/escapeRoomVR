extends VRGUI


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_activated:
		return
	
	if Input.is_action_just_pressed("ui_up"):
		control_node.focus_neighbour_top()
	elif Input.is_action_just_pressed("ui_down"):
		control_node.focus_neighbour_bottom()
	elif Input.is_action_just_pressed("ui_left"):
		control_node.focus_neighbour_left()
	elif Input.is_action_just_pressed("ui_right"):
		control_node.focus_neighbour_right()
