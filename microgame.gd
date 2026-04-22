class_name Microgame
extends Node2D

#information about the microgame
@export var microgameName: String
@export var  microgameDescription: String
@export var  microgamePrompt: String
@export var  microgameTimeLimit: int

var isMicrogameWinConditionMet: bool

@onready var timer: Timer = $timer
@onready var promptLabel: RichTextLabel = $promptLabel

func _ready() -> void:
	timer.wait_time = microgameTimeLimit
	promptLabel.text = microgamePrompt

func _process(delta: float) -> void:
	pass

func onTimeout() -> void:
	if isMicrogameWinConditionMet:
		pass
	else:
		pass
