extends Sprite2D

func _ready():
    get_viewport().connect("size_changed", self._on_viewport_size_changed)
    _resize_background()

func _resize_background():
    var viewport_size = get_viewport().size
    var texture_size = self.texture.get_size()

    var scale_x = viewport_size.x / texture_size.x
    var scale_y = viewport_size.y / texture_size.y
    
    var s = min(scale_x, scale_y)
    var scale_vec = Vector2(s, s)
    var diff = (Vector2(scale_x, scale_y) - scale_vec) * texture_size
    position = diff / 2

    self.scale = scale_vec

func _on_viewport_size_changed():
    _resize_background()
