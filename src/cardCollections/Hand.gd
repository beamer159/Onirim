extends Node2D

var deck
var limbo

func init(deck_in, limbo_in):
	deck = deck_in
	limbo = limbo_in

func add_card(card: Card):
	add_child(card)
	card.show()
	_reorder()

func replenish():
	while get_child_count() < 5:
		var card: Card = deck.get_child(0)
		deck.remove_child(card)
		match card.card_type:
			CardGlobals.CardType.LOCATION:
				add_card(card)
			_:
				limbo.add_child(card)
	for card in limbo.get_children():
		limbo.remove_child(card)
		deck.add_child(card)
	deck.shuffle()

func _reorder():
	for i in get_child_count():
		var card: CardSymboled = get_child(i)
		card.position = Vector2(i * 140, 0)