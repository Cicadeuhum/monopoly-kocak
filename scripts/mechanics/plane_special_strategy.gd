extends SpecialStrategyBase
class_name PlaneSpecialStrategy

var picked_tile: Tile
var mouse: Vector2

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	mouse = get_viewport().get_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var result = CameraMaster.get_object_from_view(mouse)
		print("RESULT: ", result)
		if result:
			print("RESULT GET SCRIPT: ", result.get_script())
		else:
			print("No collider found at this position")
		GameMaster.end_current_turn()
		set_process(false)

func do(pawn: Pawn) -> void:
	print("PICK A TILE")
	set_process(true)
