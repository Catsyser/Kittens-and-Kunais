extends Node3D

#setting the objects in this node
@onready var yaw_node = $CameraYaw
@onready var pitch_node = $"CameraYaw/CameraPìtch"
@onready var camera = $"CameraYaw/CameraPìtch/Camera3D"

#------ variables to control the movement ------

#actualy values
var yaw : float = 0
var pitch : float = 0

#adjust better the speed
var yaw_sensitivity : float = 0.07
var pitch_sensitivity : float = 0.07

#smoother experience -- OPTIONAL
var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

#stablish limits to the camera movement
var pitch_max : float = 75
var pitch_min : float = -55
var yaw_max : float = 60
var yaw_min : float = -70

#in the instance
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#with the mouse input
func _input(event):
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity

func _physics_process(delta):
	pitch = clamp(pitch, pitch_min, pitch_max)
	yaw = clamp(yaw, yaw_min, yaw_max)
	
	#SMOOTH CAMERA
	#yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta)
	#pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta)
	
	#HARDER CAMERA (the option for now)
	yaw_node.rotation_degrees.y = yaw
	pitch_node.rotation_degrees.x = pitch
