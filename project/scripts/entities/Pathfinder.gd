extends Node

var cur_target: Vector2
var target_override
var path = []
var path_index = 0
var deadzone = 20


func override_target(pos):
    target_override = pos


func clear_override():
    if target_override != null:
        target_override = null


func set_path(new_path):
    path = new_path
    cur_target = path[0]


func get_target(pos):
    if target_override != null:
        if (pos - target_override).length() < deadzone:
            target_override = null
            var closest_index
            var shortest_length
            for index in range(len(path)):
                var length = (pos - path[index]).length()
                if not shortest_length or length < shortest_length:
                    closest_index = index
                    shortest_length = length
                path_index = closest_index
        return target_override
    elif len(path) > 0:
        if (pos - cur_target).length() < deadzone:
            var path_index = path_index + 1
            if path_index >= len(path):
                path_index = 0
            cur_target = path[path_index]
        return cur_target
    else:
        return null
