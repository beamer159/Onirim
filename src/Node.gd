extends Node

onready var card_res = preload("res://src/cards/Card.tscn")
onready var card_colored_res = preload("res://src/cards/CardColored.tscn")
onready var card_symboled_res = preload("res://src/cards/CardSymboled.tscn")

func _ready():
	var file: File = File.new()
	file.open("res://src/cards/Cards.json", File.READ)
	var json: String = file.get_as_text()
	file.close()
	var dic: Dictionary = parse_json(json)
	var folder: String = dic.folder
	var x: int = 200
	for c in dic.cards:
		var card: Card
		match int(c.type):
			CardGlobals.CardType.DOOR:
				card = card_colored_res.instance()
				card.card_color = int(c.color)
			CardGlobals.CardType.DREAM:
				card = card_res.instance()
			CardGlobals.CardType.LOCATION:
				card = card_symboled_res.instance()
				card.card_color = int(c.color)
				card.card_symbol = int(c.symbol)
		card.card_type = int(c.type)
		card.texture = load(str(folder, c.filename))
		card.position = Vector2(x, 300)
		x += 30
		add_child(card)
