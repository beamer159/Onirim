extends Node

onready var card_res = preload("res://src/cards/Card.tscn")
onready var card_colored_res = preload("res://src/cards/CardColored.tscn")
onready var card_symboled_res = preload("res://src/cards/CardSymboled.tscn")

func _ready():
	var card: Card = card_res.instance()
	var card_colored: CardColored = card_colored_res.instance()
	var card_symboled: CardSymboled = card_symboled_res.instance()

	card.card_type = CardGlobals.CardType.LOCATION
	card_colored.card_color = CardGlobals.CardColor.RED
	card_symboled.card_symbol = CardGlobals.CardSymbol.MOON

	print(card.card_type)
	print(card_colored.card_color)
	print(card_symboled.card_symbol)
