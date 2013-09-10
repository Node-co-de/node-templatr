
fs = require 'fs'

module.exports.getAllLinesFromFile = (file) ->
  return fs.readFileSync("#{process.cwd()}/layouts/#{file}.html").toString().split '\n'