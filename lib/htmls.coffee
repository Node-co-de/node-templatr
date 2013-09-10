
fs = require 'fs'

module.exports.getFiles = ->
  files = []
  
  for file in fs.readdirSync "#{process.cwd()}/htmls"
    if -1 < file.search /\.html$/
      files.push file
  return files
  
module.exports.getAllLinesFromFile = (file) ->
  return fs.readFileSync("#{process.cwd()}/htmls/#{file}").toString().split '\n'

module.exports.getBlockLines = (fileName, blockName) ->
  console.log "file: #{fileName} block: #{blockName}"
  
  lines = @getAllLinesFromFile fileName
  blockName = "<!-- block:#{blockName} -->"
  
  linesReturn = []
  
  for line,i in lines
    if line.trim() is blockName
      console.log "found block #{blockName}"
      
      for line in lines.slice i+1
        if line.trim() is '<!-- endblock -->'
          break
        else
          linesReturn.push line
      break
  return linesReturn
      
    