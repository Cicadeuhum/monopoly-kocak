extends SpecialStrategyBase
class_name PrisonSpecialStrategy

func do(pawn : Pawn):
	GameMaster.prison_pawn(pawn.index)
	if GameMaster.current_turn == pawn.index:
		GameMaster.end_current_turn()
