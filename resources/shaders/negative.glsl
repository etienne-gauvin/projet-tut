vec4 effect(vec4 mcolor, Image texture, vec2 texture_coords, vec2 pixel_coords)
{
  vec4 color = Texel(texture, texture_coords);
  
  return color;
}
