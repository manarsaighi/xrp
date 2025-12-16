extends Node

var facts := [
	"Bees can recognize human faces!",
	"One bee can visit up to 5,000 flowers in a day.",
	"Pollination is essential for 1/3 of our food.",
	"Bees communicate by dancing.",
    "Flowers use color and scent to attract bees."
]

func get_random_fact() -> String:
	return facts[randi() % facts.size()]
