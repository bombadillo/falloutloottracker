size = (obj) ->
  size = 0
  for key of obj
    if obj.hasOwnProperty(key) then size++
  return size

cleanEmptyValues = (data) ->
  for i of data
    if data[i] == '' || data[i] == null
      delete data[i]
  return data

exports = this
exports.size = size
exports.cleanEmptyValues = cleanEmptyValues
