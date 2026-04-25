@tool

## Basic class that holds all the logic for the microgames
class_name Microgame
extends Node2D

# note to future self, everytime you create a new microgame, copy over the timerr; the promptLabel; and the camera
# if you don't do that, everything will break and you'll be very sad :(

#information about the microgame
@export var microgameName : String
@export var microgameDescription : String
@export var microgamePrompt : String
@export var microgameTimeLimit : int = 10

@onready var timer: Timer = $microgameDependencies/timer
@onready var promptLabel: RichTextLabel = $microgameDependencies/promptLabel
@onready var textTimer: Timer = $microgameDependencies/promptLabel/textTimer

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

func onTextTimerTimeout() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(promptLabel, "self_modulate:a", 0, 0.25)
	tween.parallel().tween_property(promptLabel, "scale", Vector2(2, 2), 0.25)
	tween.tween_callback(promptLabel.queue_free)
	#print("timed out!")
	#promptLabel.visible = false
