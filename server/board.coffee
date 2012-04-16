#objectify = (keys, values) ->
  #obj = {}
  #obj[key] = value for key, index in keys when value = values[index]
  #return obj

#roll = -> map [null, null], -> Math.floor Math.random() * 6

#roll_to_resources = (board, roll) ->
  #return if roll is 7

  #resources = each board.players, (p) -> compact flatten map p.settlements, (s) ->
    #map [1..(if s.is_city then 2 else 1)], -> if s.die is roll then board.resources[s.coordinate]

  #objectify (pluck board.players, '_id'), resources

