extends ARVRController

export(String, "RAYCAST", "AREA") var GRAB_MODE = "RAYCAST"

var input_map_L = {
	Global.INPUT_BUTTONS.TOUCHPAD: false,
	Global.INPUT_BUTTONS.TRIGGER: false,
	Global.INPUT_BUTTONS.SIDE: false,
	Global.INPUT_BUTTONS.MENU: false
}
var input_map_R = {
	Global.INPUT_BUTTONS.TOUCHPAD: false,
	Global.INPUT_BUTTONS.TRIGGER: false,
	Global.INPUT_BUTTONS.SIDE: false,
	Global.INPUT_BUTTONS.MENU: false
}

var controller_velocity = Vector3(0,0,0)
var prior_controller_position = Vector3(0,0,0)
var prior_controller_velocities = []

onready var hand_mesh
onready var hand_pickup_drop_sound = $AudioStreamPlayer3D

var is_teleporting = false
var teleport_pos = Vector3.ZERO
onready var teleport_mesh = get_tree().root.get_node("World/TeleportMesh")
onready var teleport_raycast = $RayCast

onready var grab_area = $Area
onready var grab_raycast = $GrabCast
onready var grab_pos_node = $GrabPos

var held_object = null
var held_object_data = {"mode":RigidBody.MODE_RIGID, "layer":1, "mask":1}


func _ready():
	if controller_id == 1:
		hand_mesh = load("res://Assets/Hand_Left.scn").instance()
	elif controller_id == 2:
		hand_mesh = load("res://Assets/Hand_Right.scn").instance()
	add_child(hand_mesh)
	
	teleport_mesh.visible = false
	teleport_raycast.visible = false
	
	grab_raycast.visible = false
	
	$SleepArea.connect("body_entered", self, "sleep_area_entered")
	$SleepArea.connect("body_exited", self, "sleep_area_exited")
	
	rumble = 1


func _process(delta):
	# TELEPORTATION
	if is_teleporting:
		teleport_raycast.force_raycast_update()
		if teleport_raycast.is_colliding() and \
		teleport_raycast.get_collider() is StaticBody and \
		teleport_raycast.get_collision_normal().y >= 0.85:
			teleport_pos = teleport_raycast.get_collision_point()
			teleport_mesh.global_transform.origin = teleport_pos
	
	if held_object != null:
		var held_scale = held_object.scale
		held_object.global_transform = grab_pos_node.global_transform
		held_object.scale = held_scale
	
	# HAND PHYSICS
	controller_velocity = Vector3.ZERO
	
	if prior_controller_velocities.size() > 0:
		for vel in prior_controller_velocities:
			controller_velocity += vel
		controller_velocity = controller_velocity / prior_controller_velocities.size()
	
	var relative_controller_position = (global_transform.origin - prior_controller_position)
	controller_velocity += relative_controller_position
	
	prior_controller_velocities.append(relative_controller_position)
	prior_controller_position = global_transform.origin
	
	controller_velocity /= delta;
	if prior_controller_velocities.size() > 30:
		prior_controller_velocities.remove(0)


func prepare_teleport():
	if held_object == null:
		if !teleport_mesh.visible:
			is_teleporting = true
			teleport_mesh.visible = true
			teleport_raycast.visible = true
	else:
		if held_object is VRInteractable:
			held_object.interact()


func teleport():
	if is_teleporting and teleport_pos != null and teleport_mesh.visible:
		var camera_offset = get_parent().get_node("PlayerCamera").global_transform.origin - get_parent().global_transform.origin
		camera_offset.y = 0
		get_parent().global_transform.origin = teleport_pos - camera_offset
		
	is_teleporting = false
	teleport_mesh.visible = false
	teleport_raycast.visible = false
	teleport_pos = null


func prepare_holding():
	if held_object == null:
		pickup_rigidbody()
	hand_pickup_drop_sound.play()


func pickup_rigidbody():
	var rigid_body = null
	
	if GRAB_MODE == "AREA":
		var bodies = grab_area.get_overlapping_bodies()
		if len(bodies) > 0:
			for body in bodies:
				if body is RigidBody and !("NO_PICKUP" in body):
						rigid_body = body
						break
	
	elif GRAB_MODE == "RAYCAST":
		grab_raycast.force_raycast_update()
		if (grab_raycast.is_colliding()):
			var body = grab_raycast.get_collider()
			if body is RigidBody and !("NO_PICKUP" in body):
				rigid_body = body
	
	if rigid_body != null:
		held_object = rigid_body
		
		held_object_data["mode"] = held_object.mode
		held_object_data["layer"] = held_object.collision_layer
		held_object_data["mask"] = held_object.collision_mask
		
		held_object.mode = RigidBody.MODE_STATIC
		held_object.collision_layer = 0
		held_object.collision_mask = 0
		
		hand_mesh.visible = false
		grab_raycast.visible = false
		
		if held_object is VRInteractable:
			held_object.controller = self
			held_object.picked_up()


func throw_rigidbody():
	if held_object == null:
		return
	
	held_object.mode = held_object_data["mode"]
	held_object.collision_layer = held_object_data["layer"]
	held_object.collision_mask = held_object_data["mask"]
	held_object.apply_impulse(Vector3(0, 0, 0), controller_velocity)
	
	if held_object is VRInteractable:
		held_object.dropped()
		held_object.controller = null
	
	held_object = null
	hand_mesh.visible = true
	
	if GRAB_MODE == "RAYCAST":
		grab_raycast.visible = true


func _on_LeftController_button_pressed(button):
	input_map_L[button] = true
	
	if button == Global.INPUT_BUTTONS.TRIGGER:
		prepare_teleport()


func _on_RightController_button_pressed(button):
	input_map_R[button] = true
	
	if button == Global.INPUT_BUTTONS.SIDE:
		prepare_holding()


func _on_LeftController_button_release(button):
	input_map_L[button] = false
	
	if button == Global.INPUT_BUTTONS.TRIGGER:
		teleport()


func _on_RightController_button_release(button):
	input_map_R[button] = false
	
	if button == Global.INPUT_BUTTONS.SIDE:
		throw_rigidbody()


func sleep_area_entered(body):
	if "can_sleep" in body:
		body.can_sleep = false
		body.sleeping = false


func sleep_area_exited(body):
	if "can_sleep" in body:
		body.can_sleep = true
