
fs = require 'fs'

block   = require './lib/block'
htmls   = require './lib/htmls'
layouts = require './lib/layouts'

args = process.argv.slice 2

getTemplateFileContent = (templateFileName) ->
  file = fs.readFileSync("#{process.cwd()}/templates/#{templateFileName}.html").toString()
  return file.split '\n'

getFileNameFromLine = (line) ->
  return line.split(':')[1].split(' ')[0]


if '-c' is args[0]
  # loop for every file in htmls dir
  if args[1]?
    files = [args[1]]
  else
    files = htmls.getFiles()
  for file in files
    console.log "File: #{file}"
    fileOut = []

    for line,i in htmls.getAllLinesFromFile file
      lineNo = "000000#{i}".slice -4
      console.log "process line no. #{lineNo}: #{line}"
      
      if 0 is line.trim().search(/^<!--\ decorate\:/)
        for layoutLine in layouts.getAllLinesFromFile getFileNameFromLine line
          console.log "layoutLine: #{layoutLine}"
          
          if      0 is layoutLine.trim().search(/^<!--\ block\:/)
            blockName = block.getBlockNameFromLine layoutLine
            console.log "block: #{blockName}"
            blockLines = htmls.getBlockLines file, blockName
            console.log "blockLines:"
            console.dir blockLines
            
            fileOut.push blockLine for blockLine in blockLines
            
          else if 0 is layoutLine.trim().search(/^<!--\ endblock\ -->/)
          else
            fileOut.push layoutLine
            
    fs.writeFileSync "#{process.cwd()}/outs/out.#{file}", fileOut.join '\n'

      
#       if 0 is line.trim().search(/^<!--\ include\:/)
#         console.log "line #{lineNo} have to process"
#         fileOut.push line
#         # calc offset
#         offset = ''
#         for l in line.split ''
#           if l is ' '
#             offset += ' '
#           if l is '<'
#             console.log "offset: #{offset.length}"
#             break
# 
#         templateLines = getTemplateFileContent getFileNameFromLine 13, line
#         
#         fileOut.push "#{offset}#{tempLine}" for tempLine in templateLines
#         fileOut.push line
#         
#       else
#         fileOut.push line
#     
#     
      
else if '-h' is args[0]
  console.log "help\n-h print this help\n-c compile htmls directory"