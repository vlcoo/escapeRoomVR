extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("locks");
	$AnimationPlayer.play("idle")
	pass # Replace with function body.

func unlock() -> void:
	$AnimationPlayer.play("open");
	yield(get_tree().create_timer(5),"timeout")
	queue_free()
	
func unlock_animation_finished() -> void:
	pass


func activate_gravity() -> void:
	can_fall = true

var can_fall: bool = false
var velocity: float = 0
export(float) var grav_scale: float = 9.8
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("ui_right")):
		unlock()
	if(can_fall):
		translation.y -= velocity*delta
		velocity += grav_scale*delta
	pass
