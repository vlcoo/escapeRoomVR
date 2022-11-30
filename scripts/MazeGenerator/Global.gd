extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum OPEN_PATHS {
	RIGHT 	= 1 << 0, #0001
	DOWN 	= 1 << 1, #0010
	LEFT	= 1 << 2, #0100
	UP		= 1 << 3  #1000
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
