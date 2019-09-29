extends Node2D

var _offset: int
var _deck: Deck

func init(deck: Deck, offset: int):
	_deck = deck
	_offset = offset

func add_card(card: Card):
	card.position = Vector2(get_child_count() * _offset, 0)
	add_child(card)
	card.show()
	if _three_same_color():
		_deck.extract_door(card.card_color)

func get_forbidden_symbol() -> int:
	if get_child_count() == 0:
		return -1
	else:
		var card: CardSymboled = get_child(get_child_count() - 1)
		return card.card_symbol

func _three_same_color() -> bool:
	var same_color_count: int = 1
	var cards: Array = get_children()
	var last_card = cards.pop_back()
	cards.invert()
	for card in cards:
		if card.card_color != last_card.card_color:
			break
		same_color_count += 1
	return same_color_count % 3 == 0