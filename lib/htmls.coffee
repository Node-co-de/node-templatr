
fs = require 'fs'

module.exports.getFiles = ->
  files = []
  
  for file in fs.readdirSync "#{process.cwd()}/htmls"
    if -1 < file.search /\.html$/
      files.push file
  return files