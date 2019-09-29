extends Sprite

func add_card(card: Card):
	add_child(card)
	card.hide()

func shuffle():
	var cards_left: int = get_child_count()
	while cards_left > 1:
		var card: Card = get_child(randi() % cards_left)
		move_child(card, cards_left - 1)
		cards_left -= 1
