extends Label

func update_xp(level, xp, xp_to_level):
	text = "
				Level: " + str(level) + "
				xp: " + str(xp) + "
				Required Xp: " + str(xp_to_level)
