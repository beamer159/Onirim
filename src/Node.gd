extends Node

onready var card_res = preload("res://src/cards/Card.tscn")
onready var card_colored_res = preload("res://src/cards/CardColored.tscn")
onready var card_symboled_res = preload("res://src/cards/CardSymboled.tscn")

var keys: Dictionary = { KEY_1: 0, KEY_2: 1, KEY_3: 2, KEY_4: 3, KEY_5: 4 }

func _ready():
	randomize()
	$Doors.init(160)
	$Deck.init($Doors)
	$Labyrinth.init($Deck, 32)
	$Hand.init($Deck, $Limbo)
	var file: File = File.new()
	file.open("res://src/cards/Cards.json", File.READ)
	var json: String = file.get_as_text()
	file.close()
	var dic: Dictionary = parse_json(json)
	var folder: String = dic.folder
	$Deck.texture = load(str(folder + dic.cardback))
	for c in dic.cards:
		for i in c.count:
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
			$Deck.add_card(card)
	$Deck.shuffle()
	$Hand.replenish()

func _input(event):
	if event is InputEventKey and event.is_pressed():
		match event.scancode:
			KEY_ESCAPE:
				get_tree().quit()
			KEY_1, KEY_2, KEY_3, KEY_4, KEY_5:
				var card_index = keys[event.scancode]
				if $Hand.get_child_count() > card_index:
					var card: Card = $Hand.get_child(keys[event.scancode])
					if card.card_symbol != $Labyrinth.get_forbidden_symbol():
						$Hand.remove_child(card)
						$Labyrinth.add_card(card)
						$Hand.replenish()
			KEY_D:
				pass
			KEY_C:
				if $Deck.get_child_count() != 0:
					var card: Card = $Deck.get_child(0)
					$Deck.remove_child(card)
					match card.card_type:
						CardGlobals.CardType.DOOR:
							$Doors.add_card(card)
						CardGlobals.CardType.DREAM:
							$Discard.add_card(card)
						CardGlobals.CardType.LOCATION:
							$Labyrinth.add_card(card)
