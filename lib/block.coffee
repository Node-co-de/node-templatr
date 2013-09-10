
module.exports.getBlockNameFromLine = (line) ->
  return line.split(':')[1].split(' ')[0]
