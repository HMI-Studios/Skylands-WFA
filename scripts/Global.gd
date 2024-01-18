extends Node

var gravity_vector : Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
var gravity_magnitude : int = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = gravity_vector * gravity_magnitude

var can_wall_jump = true
