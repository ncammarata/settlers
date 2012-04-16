Meteor.startup ->
  Meteor.methods {
    roll: (board_id) ->
      board = Boards.findOne board_id
      roll =
        dice: (_.map [null, null], -> (Math.floor Math.random() * 6) + 1)
        player_id: board.turn

      Boards.update board_id, $push: { rolls: roll }

    next_player: (board_id) ->
      board = Boards.findOne board_id
      index = (_.pluck board.players, 'id').indexOf board.turn
      new_player = board.players[(index + 1) % (board.players.length)]
      Boards.update board_id, $set: { turn: new_player.id }
  }
