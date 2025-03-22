extends Tile
class_name TileSpecial

@export var strategy : Script

func do(pawn : Pawn):
	if strategy:
		var strategy_instance = strategy.new()
		if strategy_instance.has_method("do"):
			strategy_instance.do(GameMaster.get_pawn(GameMaster.current_turn))
		else:
			print("The assigned strategy does not implement do()")
	else:
		print("No strategy assigned to this tile.")
