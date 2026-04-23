class_name Microgame
extends Node2D

#information about the microgame
@export var microgameName: String
@export var microgameDescription: String
@export var microgamePrompt: String
@export var microgameTimeLimit: int = 10

@onready var timer: Timer = $timer
@onready var promptLabel: RichTextLabel = $promptLabel

var isMicrogameWinConditionMet: bool
var isMicrogameBossStage: bool

func _ready() -> void:
	timer.wait_time = microgameTimeLimit
	promptLabel.text = "[shake]" + microgamePrompt + "[/shake]"

# called whenvever the microgame is won
func _win() -> void:
	pass

# called whenever the microgame is lost
func _loss() -> void:
	pass

func _onTimeout() -> void:
	if isMicrogameWinConditionMet:
		_win()
	else:
		_loss()
