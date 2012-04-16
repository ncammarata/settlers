get_player = (board, id) -> _.find board.players, (p) -> p.id is id

render_board = (board) ->
  ctx = $('canvas')[0].getContext '2d'
  rows = [
    [0, 1, 1, 1, 0]
     [1, 1, 1, 1, 0]
    [1, 1, 1, 1, 1]
     [1, 1, 1, 1, 0]
    [0, 1, 1, 1, 0]
  ]

  size = 50

  tile_to_color = (tile) ->
    (
      desert: 'brown'
      sheep: 'green'
      brick: 'red'
      wood: 'green'
      wheat: 'yellow'
      ore: 'silver'
    )[tile]

  index = 0
  for row, row_index in rows
    for col, col_index in row when rows[row_index][col_index] is 1
      ctx.fillStyle = tile_to_color board[index].tile
      x = col_index * size + (if row_index % 2 is 1 then size / 2 else 0)
      y = row_index * size
      ctx.fillRect x * 2, y * 2, size, size
      ctx.fillStyle = 'black'
      ctx.font = '20px Arial'
      ctx.fillText board[index].die, (x * 2) + size / 2, (y * 2) + size / 2
      index++

generate_board = ->
  repeat = (val, times) -> map [1..times], -> val

  dice = [2,3,3,4,4,5,5,6,6,8,8,9,9,10,10,11,11,12]
  tiles = [
    repeat 'sheep', 4
    repeat 'wood', 4
    repeat 'wheat', 4
    repeat 'brick', 3
    repeat 'ore', 3
  ]

  board = (map (zip dice), (shuffle flatten tiles)), (arr) -> { die: arr[0], tile: arr[1] })

  shuffle board.concat({ die: 0, tile: 'desert' })

Meteor.startup ->
  Session.set 'player_id', 1
  Session.set 'board', '1395adad-a77f-45b1-831e-27fa422246da'

  Boards.find(Session.get 'board').observe {
    changed: (doc, at_index, old_doc) ->
      return if doc.rolls.length is old_doc.rolls.length
      roll = _.last doc.rolls
      $('body').append "#{get_player(doc, roll.player_id).name} rolled a #{roll.dice.join ', '}<br/>"
  }

  board = generate_board()
  render_board(board)

