extends Area2D

onready var Score = get_node("/root/Main/Score")
onready var coinScore = get_node("/root/Main/coinAmount")
onready var coinAmount = get_node("/root/Main/coinSpawn")

export var reward = 7
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_KillArea_body_entered(body):
	if body.is_in_group("coin"):
		body.queue_free()
		Score.score += reward
		coinScore.coins += reward
		coinAmount.coinAmount += reward
		print("deleted", body.name)
	pass # Replace with function body.
