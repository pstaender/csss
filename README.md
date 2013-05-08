### CSSS
**c** offee **s** cripted **s**tyle **s** heets

… or “another css markup simplifier the world has been waiting for“  …

* stylus inspired markup
* transcompiles to coffeescript
* procduces clean css
* proof of concept

Currently early development state…

[You can see a partly working example here](http://zeitpulse.com/csss/example/editor.html)

### How it will be

Currently there are issues to solve... And there is no final compilation to css implemented, yet.
But later it should behave stylus-like (this is just for demonstration, not for making any sense ;) :

```coffeescript

  # you can use your own environment classes
  # and work dry (@import for *.csss files will follow) 
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
    "all and (max-width: #{@width}px and (min-width: #{@width*0.8}px), (min-width: 1151px)"

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

```

### LICENSE

**The MIT License (MIT)**

Copyright (c) 2013 Philipp Staender <philipp.staender@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
