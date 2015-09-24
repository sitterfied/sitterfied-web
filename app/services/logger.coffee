`import Ember from 'ember'`
`import config from 'sitterfied-web/config/environment'`

# from https://gist.github.com/tomdale/804906f1ab2794baa77a
#
#  Example usage:
#
#  logger = require 'app/system/logger';
#  var LOG = logger.loggerFor('topic'');
#
#  LOG.log({
#    event: 'data received',
#    secondary: {
#      resource: 'photo',
#      requestId: '1234'
#    },
#    args: payload
#  });
#

DATE_FORMAT = 'MM/DD HH:mm:ss'
FONT_WEIGHT_NORMAL = 'font-weight: normal;'
FONT_WEIGHT_BOLD = 'font-weight: bold;'
COLOR_PURPLE = 'color: purple;'
COLOR_RED = 'color: red;'
COLOR_GREEN = 'color: green;'
COLOR_BLUE = 'color: blue;'

logFormatted = (name, type, message, additional) ->
  output = []
  style = []
  date = moment().format(DATE_FORMAT)

  # Timestamp
  output.push '%c[' + date + '] '
  if type is 'error'
    style.push FONT_WEIGHT_BOLD + COLOR_RED
  else
    style.push FONT_WEIGHT_NORMAL

  # Name
  output.push '%c' + name + ' '
  style.push FONT_WEIGHT_NORMAL + COLOR_PURPLE
  if typeof message is 'string'
    # Simple Message
    output.push '%c' + message
    style.push FONT_WEIGHT_NORMAL
  else
    # Structured Message

    # Event Name
    output.push '%c' + message.event
    style.push FONT_WEIGHT_NORMAL + COLOR_RED

    # Secondary Information
    secondary = normalizeSecondary(message.secondary)
    idx = 0

    while idx < secondary.length
      output.push ' %c' + secondary[idx]
      style.push FONT_WEIGHT_NORMAL + COLOR_GREEN
      output.push '%c='
      style.push FONT_WEIGHT_NORMAL
      output.push '%c' + secondary[idx + 1]
      style.push FONT_WEIGHT_NORMAL + COLOR_BLUE
      idx += 2

  output = [output.join('')].concat(style)
  args = message.args

  if args and args.length
    return unless 'apply' of console.groupCollapsed
    console.groupCollapsed.apply console, output
    console.log.apply console, args
    console.groupEnd()
  else
    return unless 'apply' of console.log
    console.log.apply console, output

  console.log additional  if additional

normalizeSecondary = (secondary) ->
  if Ember.typeOf(secondary) is 'array'
    Ember.assert(
      'Secondary arguments passed to the logger must have an even' +
      "number of items. For example, ['foo=', bar].",
      secondary.length % 2 is 0
    )
    return secondary
  array = []
  for key of secondary
    array.push key
    array.push secondary[key]
  array

Logger = Ember.Object.extend(
  history: null
  verbose: false
  sendReports: false
  name: 'default'

  loggerFor: (name) ->
    Logger.create
      parent: this
      name: name

  setup: ->
    @history = []
    @_log 'useragent', window.navigator.userAgent
    this

  log: (message) ->
    @_log 'info', message

  warn: (message) ->
    @_log 'warning', message

  error: (message) ->
    @_log 'error', message

  report: (error) ->
    return  unless @sendReports
    console.log 'Sending report to server.'  if @verbose
    try
      if Ember.typeOf(error) is 'error'
        Raven?.captureException(error)
      else
        Raven?.captureMessage(error)
    catch
      if @verbose
        message = 'Error sending report to server'
        Raven?.captureMessage(message)
        console.error(message, error)

  reportError: (error) ->
    @report(error)

  _log: (type, message, additional, name) ->
    parent = @get('parent')
    name = @get('name')  unless name
    if parent
      parent._log type, message, additional, name
      return
    date = new Date()
    item =
      name: name
      dateStr: date.toString()
      timestamp: date.getTime()
      type: type
      message: message

    if @sendReports and type is 'error' and message.event
      console.log 'Sending report to server.'  if @verbose
      try
        text = "#{name}: #{message.event}"
        Raven?.captureMessage(text,
          extra:
            args: message.args
            secondary: message.secondary
        )
      catch
        if @verbose
          message = 'Error sending report to server'
          Raven?.captureMessage(message)
          console.error(message, message.args, message.secondary)

    $.extend item, additional  if additional
    @history.push item
    logFormatted name, type, message, additional  if @verbose
)

# TODO: inject features into the logger
logger = Logger.create(
  verbose: !!config.featureFlags.enableVerboseLogging
  sendReports: !!config.featureFlags.sendErrorReports
).setup()

`export default logger`
