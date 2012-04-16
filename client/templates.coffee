Template.board.players = ->
  board = Boards.findOne Session.get 'board'
  board.players if board

Template.player.events =
  'click button': ->
    Meteor.call 'roll', Session.get 'board'
    Meteor.call 'next_player', Session.get 'board'

Template.player.enabled_class = ->
  if Session.equals('player_id', @id) then 'enabled' else ''

Template.player.is_turn = ->
  Session.equals('player_id', @id) and @id is (Boards.findOne _id: Session.get('board')).turn

Template.sign_in.events =
  'submit': (e) ->
    handle = $(e.target).find('input[type=text]').val()
    if handle
      Session.set 'player_id', Players.insert(handle: handle)
      $(e.target).hide()

    e.preventDefault()
