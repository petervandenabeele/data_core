attendees = require('../../app/facebook/attendees')
common = require('../../app/common')

tweetmeetLeuven = "307515752658040"
peter_id = "661912843" # Peter Vandenabeele (myself, with permission ;-)

test_attendees = (attendees,test) ->
  test.ok(typeof(attendees) == "object", "attendees is not a string")
  test.ok(attendees.length > 0, "at least 1 attendee")
  peter_attendee = null
  for attendee in attendees
    if attendee.id == peter_id
      peter_attendee = attendee
  test.ok(peter_attendee != null, "found peter in the attendee list")
  test.ok(peter_attendee.event_id == tweetmeetLeuven, "event_id in attendee")
  test.done()

exports.test_requestAttendees = (test) ->
  future = attendees.requestAttendees(tweetmeetLeuven)

  future.when((body) ->
    test.ok(/data/.test(body), "the body has a data field")
    test.done())

exports.test_attendees = (test) ->
  future = attendees.attendees(tweetmeetLeuven)

  future.when((attendees) ->
    test_attendees(attendees,test))

exports.test_saveAttendees = (test) ->
  future = attendees.saveAttendees(tweetmeetLeuven)

  future.when((mongo_connection) ->
    mongo_connection.attendees.find((err,attendees) ->
      mongo_connection.close()
      test_attendees(attendees,test)))
