fs = require('fs')
atl = '/home/peterv/b/om/data_core/tmp/access_token.data'

exports.readAccessToken = () ->
  fs.readFileSync(atl, 'utf8')

exports.setAccessToken = (access_token) ->
  fs.writeFileSync(atl, access_token)
