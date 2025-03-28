extends SpecialStrategyBase
class_name GambleSpecialStrategy

var menu : MenuGamble

func _enter_tree() -> void:
	var nodes = get_tree().get_nodes_in_group("UI")
	for node in nodes:
		if node is MenuGamble: menu = node

func do(pawn : Pawn):
	menu.set_enable(true)
