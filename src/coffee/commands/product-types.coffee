ClientUtils = require('../utils/client')

class ProductTypesCommand

  constructor: ->
    ###*
     * Expose `Command` object in order to spy on it
    ###
    @program = require('commander')

  ###*
   * `sphere-products` entry point
   * @param {Object} argv Parsed command line options
  ###
  run: (argv)->

    @program
      .option('-J, --json-raw', 'output in raw JSON (default)')
      .option('-j, --json-pretty', 'output in pretty-printed JSON')

    @program
      .command('list')
      .description('List product types')
      .action => @_list
        jsonPretty: @program.jsonPretty

    @program
      .command('create')
      .description('Create a new product type')
      .action => @_create {}

    @program.parse(argv)
    @program.help() unless @program.args.length


  _list: (opts = {})-> ClientUtils.fetch 'productTypes', opts

  _create: (opts = {})-> ClientUtils.create()


module.exports = ProductTypesCommand
