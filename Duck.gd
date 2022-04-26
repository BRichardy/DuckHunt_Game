extends KinematicBody2D

var side = 1
var vel = Vector2()
var speed = 100
var fall = 1

func _ready():
	randomize()
	$moviment.wait_time = rand_range(0.6, 2)
	$anima.wait_time = rand_range(0.6, 1)

func _process(delta):
	# horizontal moviment
	position.x += speed*side*delta
	
	# vertical moviment
	position.y -= 140*fall*delta
	
	# animation mirroing
	if side < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	

func _on_moviment_timeout():
	side = side*(-1)


func _on_anima_timeout():
	if $AnimatedSprite.animation == "top":
		$AnimatedSprite.animation = "side"
	elif $AnimatedSprite.animation == "side":
		$AnimatedSprite.animation = "top"
		
func mata():
	$AnimatedSprite.animation = "scare"
	$death.start()
	



func _on_death_timeout():
	$AnimatedSprite.animation = "death"
	fall = -1
	side = 0
