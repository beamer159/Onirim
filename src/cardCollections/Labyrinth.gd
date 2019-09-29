extends Node2D

var _offset: int

func init(offset: int):
	_offset = offset

func add_card(card: Card):
	card.position = Vector2(get_child_count() * _offset, 0)
	add_child(card)
	card.show()
