extends TextureRect

var IMAGE_X = 500
var IMAGE_Y = 500
var IMAGE_SIZE = Vector2i(IMAGE_X,IMAGE_Y)

func _generate():
	var Generated : Image = Image.create(IMAGE_X,IMAGE_Y,false,Image.FORMAT_RGBA8)
	Generated.fill(Color.WHITE)
	
	for X in range(IMAGE_X):
		for Y in range(IMAGE_Y):
			
			Generated.set_pixel(X,Y,getPixelColor(X,Y))
	
	return Generated

func getPixelColor(X : int ,Y : int) -> Color:
	var color := Color.WHITE
	
	if sin(X * 0.5) >= 0.5:
		color = Color.REBECCA_PURPLE
	elif sin(Y * 0.5) >= 0.5:
		color = Color.AQUA
	
	return color

func _process(delta):
	var img : Image =  _generate()
	texture = ImageTexture.create_from_image(img)
	
