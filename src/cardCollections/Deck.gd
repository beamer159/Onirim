extends Sprite
class_name Deck

var _doors

func init(doors):
	_doors = doors

func add_card(card: Card):
	add_child(card)
	card.hide()

func shuffle():
	var cards_left: int = get_child_count()
	while cards_left > 1:
		var card: Card = get_child(randi() % cards_left)
		move_child(card, cards_left - 1)
		cards_left -= 1

func extract_door(card_color: int):
	for card in get_children():
		if card.card_type == CardGlobals.CardType.DOOR and card.card_color == card_color:
			remove_child(card)
			_doors.add_card(card)
			break