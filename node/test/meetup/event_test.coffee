event_module = require('../../app/meetup/event')
#common = require('../../app/common')

bigdatabe7 = "63139992"
peter_id = "5385162" # Peter Vandenabeele (myself, with permission ;-)

test_event = (event,test) ->
  test.ok(typeof(event) == "object", "event is not a string")
  test.ok(typeof(event["results"]) == "object", "has a results key")
  test.done()

exports.test_getEvent = (test) ->
  future = event_module.getEvent(bigdatabe7)

  future.when((event) ->
    test_event(event,test))

#exports.test_requestAttendees = (test) ->
#  future = attendees.requestAttendees(tweetmeetLeuven)
#
#  future.when((body) ->
#    test.ok(/data/.test(body), "the body has a data field")
#    test.done())
#
#exports.test_attendees = (test) ->
#  future = attendees.attendees(tweetmeetLeuven)
#
#  future.when((attendees) ->
#    test_attendees(attendees,test))
#
#exports.test_saveAttendees = (test) ->
#  future = attendees.saveAttendees(tweetmeetLeuven)
#
#  future.when((mongo_connection) ->
#    mongo_connection.attendees.find((err,attendees) ->
#      mongo_connection.close()
#      test_attendees(attendees,test)))
