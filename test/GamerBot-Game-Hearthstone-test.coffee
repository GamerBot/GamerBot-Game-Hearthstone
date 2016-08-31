Helper = require('hubot-test-helper')
expect = require('chai').expect
nock = require('nock')

helper = new Helper('../src/GamerBot-Game-Hearthstone.coffee')

describe 'GamerBot-Game-Hearthstone', ->
  beforeEach ->
    @room = helper.createRoom()
    nock( 'https://omgvamp-hearthstone-v1.p.mashape.com')
      .get('/cards/search/leeroy')
      .reply 200, [
          {
            "cardId": "EX1_116",
            "name": "Leeroy Jenkins",
            "cardSet": "Classic",
            "type": "Minion",
            "faction": "Alliance",
            "rarity": "Legendary",
            "cost": 5,
            "attack": 6,
            "health": 2,
            "text": "<b>Charge</b>. <b>Battlecry:</b> Summon two 1/1 Whelps for your opponent.",
            "flavor": "At least he has Angry Chicken.",
            "artist": "Gabe from Penny Arcade",
            "collectible": true,
            "elite": true,
            "img": "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_116.png",
            "imgGold": "http://wow.zamimg.com/images/hearthstone/cards/enus/animated/EX1_116_premium.gif",
            "locale": "enUS",
            "mechanics": [
              {
                "name": "Charge"
              },
              {
                "name": "Battlecry"
              }
            ]
          }
      ]
      .get('/cards/search/squire')
      .reply 200, [
        {
          "cardId": "EX1_008",
          "name": "Argent Squire",
          "cardSet": "Classic",
          "type": "Minion",
          "faction": "Alliance",
          "rarity": "Common",
          "cost": 1,
          "attack": 1,
          "health": 1,
          "text": "<b>Divine Shield</b>",
          "flavor": "\"I solemnly swear to uphold the Light, purge the world of darkness, and to eat only burritos.\" - The Argent Dawn Oath",
          "artist": "Zoltan & Gabor",
          "collectible": true,
          "img": "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_008.png",
          "imgGold": "http://wow.zamimg.com/images/hearthstone/cards/enus/animated/EX1_008_premium.gif",
          "locale": "enUS",
          "mechanics": [
            {
              "name": "Divine Shield"
            }
          ]
        },
        {
          "cardId": "AT_082",
          "name": "Lowly Squire",
          "cardSet": "The Grand Tournament",
          "type": "Minion",
          "rarity": "Common",
          "cost": 1,
          "attack": 1,
          "health": 2,
          "text": "<b>Inspire:</b> Gain +1 Attack.",
          "flavor": "But not the lowliest!",
          "artist": "Ron Spears",
          "collectible": true,
          "img": "http://wow.zamimg.com/images/hearthstone/cards/enus/original/AT_082.png",
          "imgGold": "http://wow.zamimg.com/images/hearthstone/cards/enus/animated/AT_082_premium.gif",
          "locale": "enUS",
          "mechanics": [
            {
              "name": "Inspire"
            }
          ]
        },
        {
          "cardId": "CS2_152",
          "name": "Squire",
          "cardSet": "Classic",
          "type": "Minion",
          "faction": "Alliance",
          "rarity": "Common",
          "cost": 1,
          "attack": 2,
          "health": 2,
          "img": "http://wow.zamimg.com/images/hearthstone/cards/enus/original/CS2_152.png",
          "imgGold": "http://wow.zamimg.com/images/hearthstone/cards/enus/animated/CS2_152_premium.gif",
          "locale": "enUS"
        }
      ]

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  it 'responds with one card', ->
    @room.user.say('bob', '.hs search leeroy').then =>
      expect(@room.messages).to.eql [
        ['bob', '.hs search leeroy']
        ['hubot',
            "Leeroy Jenkins http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_116.png"
        ]
      ]

  it 'responds with multiple cards', ->
    @room.user.say('alice', '.hs search squire').then =>
      expect(@room.messages).to.eql [
        ['alice', '.hs search squire']
        ['hubot',
          "```Argent Squire Lowly Squire Squire ```"
        ]
      ]
