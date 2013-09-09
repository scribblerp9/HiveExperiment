

-- Setup scenes
sceneManager = SceneManager.new({
    ["hiveScene"] = hiveScene,
    ["forestScene"] = forestScene
})
stage:addChild(sceneManager)

-- Start with the hive scene
--Arguments:
--start - provided key to reference scene
--1 - duration of transition in seconds
--SceneManager.flipWithFade - scene transition
--easing.outBack - easing
sceneManager:changeScene("hiveScene", 1, SceneManager.flipWithFade, easing.outBack)
