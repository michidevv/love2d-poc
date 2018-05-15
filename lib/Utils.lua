function GenerateQuads(atlas, number, params)
  local quads = {}

  for i = 1, number do
    quads[i] = love.graphics.newQuad(
      params.w * (i - 1),
      params.y,
      params.w,
      params.h,
      atlas:getDimensions())
  end

  return quads
end
