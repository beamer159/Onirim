extends Node2D

var deck
var limbo

func init(deck_in, limbo_in):
	deck = deck_in
	limbo = limbo_in

func add_card(card: Card):
	card.position = Vector2(get_child_count() * 140, 0)
	add_child(card)
	card.show()

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
