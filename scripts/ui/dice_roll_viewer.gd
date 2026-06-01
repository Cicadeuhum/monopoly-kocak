extends Node

@export var debug : bool

@onready var menu_player: Panel = $".."
@onready var roll_label: Label = $"Roll Label"

func _ready() -> void:
	if (debug):
		print("Initializing roll viewer")
	menu_player.on_roll_complete.connect(handle_roll_complete)

func handle_roll_complete(roll) -> void:
	roll_label.text = str(roll)
	if (debug):
		print("roll viewer harusnya nunjukin: " + str(roll))
