Players = new Meteor.Collection 'players'
Boards = new Meteor.Collection 'boards'

if Meteor.is_client
  window.Players = Players
  window.Boards = Boards

if Meteor.is_server
  global.Players = Players
  global.Boards = Boards
