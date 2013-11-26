return {
  
  { restypename = 'images',
    
    coin = 'coin-small.png'
  },
  
  -- Polices de caractère
  { restypename = 'imagefonts',
    
    -- Normale
    pixel = {
      image = 'pixel-font.png',
      chars = [=[
 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;'"?/\[](){}<>1234567890!@#$%^&*_-+=~`|]=]
    },
    
    -- Avec une ombre
    pixelShadowed = {
      image = 'pixel-font-shadowed.png',
      chars = [=[
 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;'"?/\[](){}<>1234567890!@#$%^&*_-+=~`|]=]
    },
  },
  
  -- Grilles
  { restypename = 'grids',
    
    -- Grille d'animation d'une pièce
    coin = {
      frameW = 7, frameH = 7,
      imageW = 49, imageH = 7
    }
  },
  
  -- Animations
  -- x_ pour que les animations soient chargées après le reste (les grilles)
  { restypename = 'anims',
    
    -- Animation d'une pièce
    coin = {
      gridName = 'coin',
      gridFramesX = '1-7', gridFramesY = 1,
      durations = 0.07
    }
  },
  
  -- Maps
  { restypename = 'maps',
    
  },
  
  -- Shaders
  { restypename = 'shaders',
    
    negative = 'negative.glsl'
  },
  
  -- Définition d'un objet
  { restypename = 'objects',
    
  },
  
}