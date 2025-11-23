extends Area3D

#--------------------DETAILS--------------------#
# Again, the Layers and masks should be set     #
# Layer: 4, only for ZONES                      #
# Mask: 2, only detect TARGETS                  #
#-----------------------------------------------#

const MAX_STRIKES : int = 3
@onready var defeat_UI = $defeat

func _ready():
	pass

func _on_area_entered(area):
	# Notice how we dont need an if case, because since we determinate the mask as 2
	# we can only detect targets!
	area.queue_free() #destroy the target
	Global.add_strike(1)
	# A simple defeat system
	if Global.strike >= MAX_STRIKES:
		game_over()

func game_over():
	print("GAME OVER")
	defeat_UI.visible = true
	# pause
	get_tree().paused = true
	#get_tree().reload_current_scene()
