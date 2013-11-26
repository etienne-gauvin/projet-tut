-- Charger le jeu
return function()

  -- Données du jeu
  game = {}
  
  -- Récupération de la configuration du fichier 
  local conf = {screen={}, modules={}}
  love.conf(conf)

  -- Paramétrage de la fenêtre
  screen = {}
  screen.w = lg.getWidth -- Taille réelle de l'écran
  screen.h = lg.getHeight
  screen.scale = function() return math.min(math.floor(screen.w() / screen.sw()), math.floor(screen.h() / screen.sh())) end -- Niveau de zoom
  screen.sw = function() return conf.screen.swidth end -- Taille de la zone de jeu
  screen.sh = function() return conf.screen.sheight end
  
  -- Taille de l'affichage en mode fenêtré
  screen.windowedWidth = lg.getWidth()
  screen.windowedHeight = lg.getHeight()
  
  -- Canvas d'affichage
  screen.canvas = lg.newCanvas(screen.sw(), screen.sh())
  screen.canvas:setFilter('nearest', 'nearest')
  
  -- Resources
  resources = core.loadResources()
  
  -- Police par défaut
  lg.setFont(resources.imagefonts.pixel)
  
  -- Caméra
  game.camera = core.camera(0, 0)
  
end