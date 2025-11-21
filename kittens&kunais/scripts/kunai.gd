extends Area3D

#--------------------DETAILS--------------------#
# A kunai is always instantiate at Layer 3,     #
# this layer is only for the PROJECTILES.       #
# Also, its ONLY interactions are with Layer 1  #
# (ambient) and Layer 2 (targets), therefore,   #
# this Layers are ONLY for its respective uses. #
#-----------------------------------------------#

@onready var kunai = $"."
@export var speed = 120

var score = 0

func _ready():
	pass

func _process(delta):
	#Notice how this is a transformation of the axis, so is relative to the world, not
	#the object itself
	$".".global_position += -global_transform.basis.z * speed * delta #bullet behavior

#Dealing with AREAS collisions (target case)
func _on_area_entered(area: Area3D) -> void:
	Global.add_points(1) #add 1 to the score
	area.queue_free()  # Destroy the target
	self.queue_free()  # Destroy itself
	score += 1

#Dealing with BODY collisions (ambient case, like walls, trees...) -> StaticBody, RigidBody...
func _on_body_entered(body: Node3D) -> void:
	self.queue_free()  # Destroy itself
	#Notice how in this case, we don't destroy the body, because we dont want to destroy the ambience.
	#Thats why we made two different functions. Other solutions would be like make an if case, to only
	#destroy the body if this a target. But in this case, we also would need to make the target a body,
	#not an area.
