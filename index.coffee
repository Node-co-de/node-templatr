
fs = require 'fs'

htmls = require './lib/htmls'

args = process.argv.slice 2

getTemplateFileContent = (templateFileName) ->
  file = fs.readFileSync("#{process.cwd()}/templates/#{templateFileName}.html").toString()
  return file.split '\n'


if '-c' is args[0]
  for file in htmls.getFiles()
    fileOut = []

    for line,i in fs.readFileSync("#{process.cwd()}/htmls/#{file}").toString().split '\n'
      lineNo = "000000#{i}".slice -4
      console.log "process line no. #{lineNo}: #{line}"
      
      if 0 is line.trim().search(/^<!--\ include\:/)
        console.log "line #{lineNo} have to process"
        fileOut.push line
        # calc offset
        offset = ''
        for l in line.split ''
          if l is ' '
            offset += ' '
          if l is '<'
            console.log "offset: #{offset.length}"
            break  
        
        templateFile  = line.trim()
        templateFile  = templateFile.slice 13, templateFile.indexOf ' -->'
        templateLines = getTemplateFileContent templateFile
        
        fileOut.push "#{offset}#{tempLine}" for tempLine in templateLines
        fileOut.push line
        
      else
        fileOut.push line
    
    fs.writeFileSync "#{process.cwd()}/outs/out.#{file}", fileOut.join '\n'
      
else if '-h' is args[0]
  console.log "help\n-h print this help\n-c compile htmls directory"