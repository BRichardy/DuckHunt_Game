extends Node2D

var patosnatela
var pato = preload("res://Duck.tscn")
var flyaway = 0
var capturados = 0

func _ready():
	$gerapato.start()

func _process(delta):
	
	$HUD/Label.text = str(capturados)
	$Alvo.position.x = get_local_mouse_position().x
	$Alvo.position.y = get_local_mouse_position().y

func _nasce():
	var novopato = pato.instance()
	add_child(novopato)
	novopato.position.x = rand_range(50,700)
	novopato.position.y = 700

func _on_gerapato_timeout():
	patosnatela = int(rand_range(1,5))
	for n in patosnatela:
		_nasce()


func _on_espera_timeout():
	$Duck/quack.stop()
	$novo_turno.play()
	$gerapato.start()
	


func _on_topo_body_entered(body):
	$flyaway.play()
	flyaway = 1
	patosnatela -= 1
	_atualizaturno()
	


func _on_chao_body_entered(body):
	$colidiu.play()
	capturados += 1
	patosnatela -= 1
	_atualizaturno()
	

func _atualizaturno():
	print(patosnatela)
	if patosnatela == 0:
		$espera.start()
		if flyaway == 1:
			$cao.play("rindo")
			$cao_rindo.play()
			flyaway = 0
			capturados = 0
		else:
			$cao.play("captura")
			$cao_captura.play()
