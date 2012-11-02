fs = require('fs')
akl = '/home/peterv/b/om/data_core/tmp/meetup_api_key.data'

exports.readApiKey = () ->
  fs.readFileSync(akl, 'utf8').replace(/\n/, '')
