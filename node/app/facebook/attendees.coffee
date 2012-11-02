common = require('../common')
mongo = require('mongojs')

privateRequestAttendees = (event_id) ->
  future = common.futures.future()

  attendees_base = "https://graph.facebook.com/#{event_id}/attending"
  attendees_url = attendees_base +
                  "?access_token=#{common.fb_access_token}"
  common.utils.getPage(attendees_url).when((body) ->
    future.deliver(body))
  future

exports.requestAttendees = (event_id) ->
  privateRequestAttendees(event_id)

privateAttendees = (event_id) ->
  future = common.futures.future()

  future_pRA = privateRequestAttendees(event_id)
  future_pRA.when((body) ->
#    console.log(body)
    attendees = JSON.parse(body).data
    for attendee in attendees
      attendee.event_id = event_id
    future.deliver(attendees))
  future

exports.attendees = (event_id) ->
  privateAttendees(event_id)

exports.saveAttendees = (event_id) ->
  future_read_back = common.futures.future()

  future_attendees =  privateAttendees(event_id)
  future_attendees.when((attendees) ->
    # open a mongodb
    db = mongo.connect(common.db_fb_name,['attendees'])
    # ensure a unique index
    db.attendees.ensureIndex({"event_id" : -1, "id" : -1}, {unique: true})
    # delete all the attendees in TEST
    if common.env == 'test'
      db.attendees.remove()
    # save the attendees
    for attendee in attendees
      db.attendees.save(attendee, {safe: true}, (err) ->
        if err
          console.log(err))
    # deliver a connection
    future_read_back.deliver(db))

  future_read_back
