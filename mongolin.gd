extends CharacterBody3D
#declarando variables
#velocidad minima del mongolin en metros por segundo
@export var min_speed = 10

#velocidad maxima del mongolin en metros por segundo
@export var max_speed = 10


func _physics_process(_delta):
	move_and_slide()

#esta funcion va a ser llamada desde la escena Main
func initialize(start_position, player_position):
	#posicionamos el mongolin poniendolo en la start_position
	#y lo rotamos hacia el jugador en player_position
	look_at_from_position(start_position,player_position,Vector3.UP)
	#rotamos el mongolin de manera aleatoria en un rango desde -45 a +45 grados
	#asi nose mueva directamente hacia el jugador
	rotate_y(randf_range(-PI/4, PI/4))
	
	#usamos la variable random_speed que es solo un int para multiplicar a
	#CharacterBody3D.velocity, luego de eso, rotamos al Vector 3 de
	#CharacterBody3D.velocity hacia el jugador
	
	#calculamos un numero random (int)
	var random_speed = randi_range(min_speed,max_speed)
	#calculamos una velocidad hacia adelante que represente la velocidad
	velocity = Vector3.FORWARD * random_speed
	#ahora rotamos el vector velocidad basandonos en la rotación Y del mongolín
	#esto va a hacer que salga hacia la dirección en la que mira el mongolin
	velocity = velocity.rotated(Vector3.UP, rotation.y)



#cuando sale de la pantalla RIP
func _on_visible_on_screen_notifier_3d_screen_exited():

	queue_free()

#se emite cuando el mongo salta sobre el mongolin
signal squashed 

func squash():
	squashed.emit()
	queue_free()
