extends Sprite

func add_card(card: Card):
	add_child(card)
	texture = card.texture
