
forestScene = gideros.class(Sprite)
function forestScene:init()

	-- Display button for switching to Forest scene
	local hiveButton = Button.new(
		Bitmap.new(Texture.new("buttonClass/button_up.png")),
		Bitmap.new(Texture.new("buttonClass/button_down.png"))
	)	 
	hiveButton:setPosition(
		(((application:getDeviceWidth()-hiveButton:getWidth())/4)*3),
		((application:getDeviceHeight()-hiveButton:getHeight())-20)
	)
	self:addChild(hiveButton)
	 
	hiveButton:addEventListener("click",
		function() 
			print("Off to the Hive with you")
			sceneManager:changeScene("hiveScene", 1, SceneManager.flipWithFade, easing.outBack)
		end
	)

end