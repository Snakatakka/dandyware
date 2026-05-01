@tool

## Basic class that holds all the logic for the microgames
class_name Microgame
extends Node2D

# note to future self, everytime you create a new microgame, copy over the microgameTimerr; the promptLabel; and the camera
# if you don't do that, everything will break and you'll be very sad :(

# note to past self, you were a dumbass who didn't know how to create nodes in GDscript.
# lmao

#information about the microgame
@export var microgameName : String
@export var microgameDescription : String
@export var microgamePrompt : String
@export var microgameTimeLimit : int = 10

@onready var promptLabel : RichTextLabel = $promptLabel
@onready var microgameTimer : Timer = Timer.new()
@onready var textTimer : Timer = Timer.new()
@onready var camera : Camera2D = Camera2D.new()

var isMicrogameWinConditionMet : bool
var isMicrogameBossStage : bool

func _ready() -> void:
	# creates the camera, microgame timer, and the prompt timer
	add_child(microgameTimer)
	add_child(textTimer)
	add_child(camera)
	
	# sets up camera
	camera.anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	
	# sets up both timers
	textTimer.timeout.connect(onTextTimerTimeout)
	microgameTimer.timeout.connect(onTimeout)
	textTimer.wait_time = 1.0
	microgameTimer.wait_time = microgameTimeLimit
	
	# displays the prompt and starts both timers.
	promptLabel.text = "[shake]" + microgamePrompt + "[/shake]"
	textTimer.start()
	microgameTimer.start()

# called whenvever the microgame is won
func win() -> void:
	if GameState.stageNumber % 20 == 0 and GameState.stageNumber < 4:
		GameState.heartNumber += 1
	
	GameState.stageNumber += 1

# called whenever the microgame is lost
func loss() -> void:
	GameState.heartNumber -= 1
	
	if GameState.stageNumber % 20 != 0:
		GameState.stageNumber += 1

func onTimeout() -> void:
	if isMicrogameWinConditionMet:
		win()
	else:
		loss()

func onTextTimerTimeout() -> void:
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	
	tween.tween_property(promptLabel, "self_modulate:a", 0, 0.25)
	tween.parallel().tween_property(promptLabel, "scale", Vector2(5, 5), 0.25)
