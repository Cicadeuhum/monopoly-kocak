extends SpecialStrategyBase
class_name PlaneSpecialStrategy

var picked_tile: Tile
var mouse: Vector2

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	mouse = get_viewport().get_mouse_position()
	if Input.is_action_just_released("select_tile"):
		var result = CameraMaster.get_object_from_view(mouse)
		print("RESULT: ", result)
		if result is Tile:
			if result.index != GameMaster.get_pawn(GameMaster.current_turn).index:
				set_process(false)
				GameMaster.get_pawn(GameMaster.current_turn).move_to_specified_tile(result.index)
			else:
				print("PICK ANOTHER TILE")
		else:
			print("No collider found at this position, PICK ANOTHER TILE")

func do(pawn: Pawn) -> void:
	print("PICK A TILE")
	set_process(true)
