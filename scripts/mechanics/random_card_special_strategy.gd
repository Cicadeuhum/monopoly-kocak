extends SpecialStrategyBase
class_name RandomCardSpecialStrategy

var chosen : int

static var player_cards : Array[Array]

var cards : Array[String] = [
	# path buat bikin script specialnya
	
]

func _enter_tree() -> void:
	player_cards.resize(GameMaster.pawns.size())
	for i in range(player_cards.size()):
		printt("PLAYER CARD", i, player_cards[i])

func do(pawn : Pawn):
	chosen = randi_range(0, 3)
	print("CHOSEN CARD: ", chosen)
	player_cards[pawn.index].append(chosen)
	for i in range(player_cards.size()):
		printt("PLAYER CARD", i, player_cards[i])
	GameMaster.end_current_turn()
