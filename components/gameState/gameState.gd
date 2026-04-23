class_name GameState
extends Node

# this is essentially just a holder for all of the variables that have to stay consistent throughout a session

static var stageNumber: int = 0

# resets all of the variables
static func _reset():
	stageNumber = 0
