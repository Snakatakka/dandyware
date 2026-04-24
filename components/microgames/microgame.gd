@tool

# note to future self, everytime you create a new microgame, copy over the timerr; the promptLabel; and the camera
# if you don't do that, everything will break and you'll be very sad :(
class_name Microgame
extends Node2D

#information about the microgame
@export var microgameName : String
@export var microgameDescription : String
@export var microgamePrompt : String
@export var microgameTimeLimit : int = 10

@onready var timer : Timer = $timer
@onready var promptLabel : RichTextLabel = $promptLabel

var isMicrogameWinConditionMet : bool
var isMicrogameBossStage : bool

func _ready() -> void:
	timer.wait_time = microgameTimeLimit
	promptLabel.text = "[shake]" + microgamePrompt + "[/shake]"

# called whenvever the microgame is won
func _win() -> void:
	if GameState.stageNumber % 20 == 0 and GameState.stageNumber < 4:
		GameState.heartNumber += 1
	
	GameState.stageNumber += 1

# called whenever the microgame is lost
func _loss() -> void:
	GameState.heartNumber -= 1
	
	if GameState.stageNumber % 20 != 0:
		GameState.stageNumber += 1

func _onTimeout() -> void:
	if isMicrogameWinConditionMet:
		_win()
	else:
		_loss()
