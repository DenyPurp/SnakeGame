extends Node

@export var food: PackedScene
@export var spawn_points: Array[Marker2D] = []
@export var max_food_on_scene: int = 10  # Максимальное количество яблок

func _ready():
	# Если точки не назначены вручную - найти автоматически
	if spawn_points.is_empty():
		find_spawn_points()
	
	validate_spawn_points()

func find_spawn_points():
	# Ищем Marker2D по группе
	var markers = get_tree().get_nodes_in_group("spawn_points")
	for marker in markers:
		if marker is Marker2D:
			spawn_points.append(marker)

func validate_spawn_points():
	spawn_points = spawn_points.filter(func(point): return point != null)
	

func _on_timer_timeout():
	# Проверяем количество яблок на сцене
	if get_food_count() >= max_food_on_scene:
		return
	
	if spawn_points.is_empty():
		return
	
	var food_spawn = food.instantiate()
	get_tree().current_scene.add_child(food_spawn)
	
	var random_point = spawn_points[randi() % spawn_points.size()]
	food_spawn.global_position = random_point.global_position

# Функция для подсчета яблок на сцене
func get_food_count() -> int:
	var food_count = 0
	var food_nodes = get_tree().get_nodes_in_group("food")  # Яблоки должны быть в группе "food"
	
	for node in food_nodes:
		if node != null and is_instance_valid(node):
			food_count += 1
	
	return food_count
