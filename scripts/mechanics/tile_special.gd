extends Tile
class_name TileSpecial

@export var strategy : Script
var strategy_instance

func _ready() -> void:
	if strategy:
		strategy_instance = strategy.new()
		add_child(strategy_instance)
	else:
		print("No strategy assigned to this tile.")

func do(pawn : Pawn):
	if strategy_instance.has_method("do"):
		strategy_instance.do(pawn)
	else:
		print("The assigned strategy does not implement do()")
