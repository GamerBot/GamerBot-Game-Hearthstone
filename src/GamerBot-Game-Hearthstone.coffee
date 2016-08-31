# Description
#   Hearthstone API access for GamerBot
#
# Configuration:
#   HUBOT_MASHAPE_KEY
#
# Commands:
#   .hs search <card> - <what the hear trigger does>
#
# Notes:
#
# Author:
#   Shawn Sorichetti <ssoriche@gmail.com>

Game = require "gamerbot-game"

class Hearthstone extends Game
  lfg: ->
    return false

  events: ->
    return {}

  name: ->
    return "Hearthstone"

  platforms: ->
    return ['Battlenet']

module.exports = (robot) ->
  game = new Hearthstone robot, 'dtg'

  urlBase = 'https://omgvamp-hearthstone-v1.p.mashape.com'

  robot.hear /^[\.!]hs search\s+(.*)$/i, (msg) ->
    [ __, cardName ] = msg.match

    robot.http(urlBase + "/cards/search/" + encodeURI(cardName))
      .header('Accept', 'application/json')
      .header("X-Mashape-Key", process.env.HUBOT_MASHAPE_KEY)
      .get() (err, res, body) ->
        cards = JSON.parse body
        if Object.keys(cards).length == 1
          reply = cards[0].name + " " + cards[0].img
          msg.send reply
        else
          reply = ""
          for card in cards
            reply += card.name + " "

          msg.send '```' + reply + '```'
