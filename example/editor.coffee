example = """
@use 'MyEnvironment'

# coffeescript comments can be used
# but with a leading #[space] to avoid ambiguity with `#selector`

# you can define methods
@padding  = (pixels) -> pixels * 2
# variables with all kind of css units
@smallerFontSize = 12em / 2
@width    = 1200px * 0.8
# color values
@grey     = rgba(60,60,60,0.4)
@errorRed = #ffa1a1
# compute (like in coffeescript)
@height = ->
  pi = Math.PI
  120% / ( 5 * pi )
@bold = (s) ->
  if s is 'bolder' then 600 else 400

# keep it dry with objects used as mixins
@borderRadius = (@r) ->
  -webkit-border-radius @r[px]
  -moz-border-radius @r - 1px
  -o-border-radius @r * 4px
  border-radius @r[px]

# define strings to save redundancy
@mobileDevices = ->
  @width = 700
  "all and (max-width: \#{@width}px and (min-width: \#{@width*0.8}px), (min-width: 1151px)"

@filter = (val) -> val * 20%

# optional, but recommend
# start your stylesheet definition with a @begin
# (not needed if you don't define methods/vars

@begin

@media @mobileDevices()

a 
  color #fff
  background @test
  # mixin example
  @borderRadius(2)

  &:hover
    opacity @filter(0.2)
    border 1px 20px solid

tr.even
  background-color red
    .a
      padding: @padding(2px) + 12px # `:` are optional
      font-weight @bold('bolder') - 100
"""


$(document).ready ->

  $in     = $('#in')
  $css    = $('#out')
  $coffee = $('#coffeescript')
  $trans  = $('#transscript')
  $error  = $('#error')

  timestamp = -> Math.round( new Date().getTime() / 1000 )


  csss = new CSSS()

  lastUse = stash.get 'lastUse'
  lastUse ?= timestamp()

  if ( timestamp() - lastUse ) > 3600
    # use default code
    exampleCode = example
  else
    # load stashed input
    exampleCode = if stash.get('input') then stash.get('input') else example

  $in.text(exampleCode)


  applyCssToDocument = (css) ->
    $('<style type="text/css"></style>').html(css).appendTo('head')

  displayError = (error) ->
    if error
      text = (String) error?.message || error
      if text?.trim()
        $error.text(text)
        return $error.removeClass('hidden')
    $error.addClass('hidden')

  parse = (force = false) ->
    lastUse = timestamp()
    return if force isnt true and stash.get('input')?.trim() is $in.val()?.trim() 
    error = []
    csss.error('')
    try
      csss.parse $in.val()
    catch e
      error.push(new Error('Parsing Error'))
      console.error e
      error.push(e)

    $coffee.text csss.coffeescript
    $trans.text csss.source

    try
      csss.eval()
      $coffee.text csss.coffeescript || css.declarationPart + css.source
      $css.text csss.css()
    catch e
      error.push(new Error('Evaluating Error'))
      console.error e
      error.push(e)

    $css.text csss.css()
    # store input
    stash.set('input', $in.val())
    if csss.error()
      error.push(csss.error())
      console.error(csss.error())
    displayError(error)

  parse(true)

  # applyCssToDocument('body { background: #fff; }')

  $collapsableContainer = $('textarea, #options')

  $collapsableContainer.each ->
    if stash.get $(this).attr('id')+'.collapsed'
      $(this).addClass('collapsed')
    else
      $(this).removeClass('collapsed')

  $collapsableContainer.on 'dblclick', ->
    $(this).toggleClass('collapsed')
    stash.set $(this).attr('id')+'.collapsed', (Boolean) $(this).hasClass('collapsed')

  $in.on 'keyup', parse

  # console.log css

  # $("head").append css


