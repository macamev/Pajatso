extends Node2D

const coinPath = preload("res://Scenes/coin.tscn")
onready var coinScore = get_node("/root/Main/coinAmount")
var coinAmount = 5
var timeLeft = 10

var rng = RandomNumberGenerator.new()
var randSpeedX
var randSpeedY

var barIsFull = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shoot") && coinAmount > 0:
		spawn()
	if coinAmount < 0:
		coinAmount = 0
	getProgressVelocity()
	checkTime(delta)


func spawn():
	var coin = coinPath.instance()
	randSpeedX = rng.randi_range(50,750)
	randSpeedY = rng.randi_range(-200, -450)
	get_parent().add_child(coin)
	coin.position = $Position2D.global_position
	coin.linear_velocity.x += getProgressVelocity()
	#coin.linear_velocity.y += randSpeedY
	coinAmount -= 1
	coinScore.coins -= 1
	
func _randomNumber():
	var newNumber
	newNumber = rng.randi_range(0,1)
	return newNumber
	
func getProgressVelocity():
	var barValue = $ProgressBar
	if (barValue.value <= barValue.max_value) and barIsFull == false:
		barValue.value += 50
	if barValue.value == barValue.max_value:
		barIsFull = true
	if (barIsFull == true):
		barValue.value -= 50
	if barValue.value == barValue.min_value:
		barIsFull = false
	return barValue.value


func _on_getCoins_pressed():
	if (timeLeft <= 0):
		coinAmount += 5
		coinScore.coins += 5
		timeLeft = 10

func checkTime(delta):
	if timeLeft > 0:
		timeLeft -= delta
		$getCoins.text = str(int(round(timeLeft)))
	if timeLeft <= 0:
		$getCoins.text = 'GET COINS'
