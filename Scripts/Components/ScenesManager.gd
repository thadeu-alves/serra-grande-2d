extends Node

var current_scene = null
var world

func change_scene(scene_path: String):
	#if current_scene:
		#current_scene.queue_free() # Descarrega a cena atual
	var new_scene = ResourceLoader.load(scene_path)
	
	if new_scene:
		current_scene = new_scene.instantiate() # Instanciar a nova cena
		get_tree().root.add_child(current_scene) # Adicionar a nova cena
		get_tree().current_scene = current_scene
	else:
		print("Falha ao carregar a cena: ", scene_path)
