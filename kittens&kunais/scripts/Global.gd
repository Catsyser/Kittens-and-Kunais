extends Node

# Define a signal to warning the UI the score changed
signal score_changed(new_value)
signal strike_changed(new_strike)
signal victory(new_value)

var score : int = 0
var strike : int = 0

func add_points(amount : int):
	score += amount
	# Emit the created signal
	emit_signal("score_changed", score)
	if score == 25:
		emit_signal("victory", score)

func add_strike(amount : int):
	strike += 1
	# Emit the created signal
	emit_signal("strike_changed", score)
