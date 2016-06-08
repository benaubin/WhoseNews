yaml = require 'js-yaml'
fs = require 'fs'
jsontoxml = require 'jsontoxml'

console.log "Building data from yaml..."

data = yaml.safeLoad fs.readFileSync './src/data.yaml', 'utf8'

fs.writeFile './build/data.json', JSON.stringify data
fs.writeFile './build/data.pretty.json', JSON.stringify data, null, 2
fs.writeFile('./build/data.yaml', """
#
# This is a read only copy - see ./src/data.yaml for the source of this file
#
#{yaml.safeDump data}
""")

console.log "Done."
