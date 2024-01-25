extends CharacterBody3D

#que tan rapido el mongo se mueve en metros x segundo

@export var speed = 14

#la aceleración hacia abajo en el aire, en metros x segundo (al cuadrado?)

@export var fall_acceleration = 75

#impulso vertical aplicado al mongo al saltar en metros por segundo

@export var jump_impulse = 20

#impulso vertical del mongo cuando rebota en un mongolin

@export var bounce_impulse = 16 
 

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	# creamos una variable local para guardar los datos de entrada
	var direction = Vector3.ZERO
	
	# Checkeamos por cada input de entrada y actualizamos la dirección
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	# In 3D, the XZ plane is the ground plane.
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	
	#Velocidad horizontal
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#Velocidad vertical
	if not is_on_floor(): # Si está en el aire, cae al piso, gravedad digamos
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	#Moviendo el MOngo
	velocity = target_velocity
	move_and_slide()
	
	#Saltar
	if is_on_floor() and Input.is_action_pressed("jump"):
		target_velocity.y = jump_impulse
		
	#un for donde checkeamos si el mongo cae sobre un mongolin
	#de ser así, muere el mongolin
	print(get_slide_collision_count())
	#iteramos por todas las colisiones que ocurrieron en este frame
	for index in range(get_slide_collision_count()):
		#una de las colisiones del mongo
		var collision = get_slide_collision(index)
		print(collision.get_collider())
		#si la colisión es con el piso 
		if collision.get_collider() == null:
			print("XDNT")
			continue
		
		#si la colisión es con un mongolin 
		if collision.get_collider().is_in_group("mongolin"):
		#.is_in_group("mongolin"):
			print("XD")
			var mongolin = collision.get_collider()
			#checkeamos si la colisión es  desde arriba
			if Vector3.UP.dot(collision.get_normal())  > 0.1:
				#en el caso de que sí. aplastamos al mongolin
				mongolin.squash()
				target_velocity.y=bounce_impulse
				#prevenimos que no se llame de nuevo
				break
				
