extends SpecialStrategyBase
class_name PlaneSpecialStrategy

var picked_tile: Tile
var mouse: Vector2

func _ready() -> void:
	set_process(false) # set process biar kalo lagi ga di special tile, ga makan performa

func _process(delta: float) -> void:
	mouse = get_viewport().get_mouse_position()
	if Input.is_action_just_released("select_tile"):
		var result = CameraMaster.get_object_from_view(mouse)
		var tile = result as Tile
		print("RESULT: ", tile)
		if tile:
			if tile.index != GameMaster.get_pawn(GameMaster.current_turn).index:
				set_process(false)
				GameMaster.get_pawn(GameMaster.current_turn).move_to_specified_tile(tile.index)
			else:
				print("TILE YANG DIPILIH SAMA! PICK ANOTHER TILE")
		else:
			print("No collider found at this position, PICK ANOTHER TILE")

func do(pawn: Pawn) -> void:
	print("PICK A TILE")
	set_process(true)
