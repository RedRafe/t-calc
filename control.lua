commands.add_command("tc-go", {"command-help.tc-go"}, function()
  local packs = {}
  local m = game.difficulty_settings.technology_price_multiplier

  for ___, t in pairs(game.forces.player.technologies) do
    
    --if t.enabled then goto continue end 
    if t.research_unit_count_formula then goto continue end

    local c = t.research_unit_count
    if not c then goto continue end

    t = t.prototype

    for ___, i in pairs(t.research_unit_ingredients or {}) do
      local _m = m
      if t.ignore_tech_cost_multiplier or false then _m = 1 end
      packs[i.name] = ((packs[i.name] or 0) + i.amount * c)
      log(t.name .. i.name .. tostring(i.amount * c))
    end
    ::continue::
  end

  game.print("Count finished")
  log(serpent.block(packs))
end)