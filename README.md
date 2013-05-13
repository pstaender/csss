### .…: csss :….
**c** offee **s** cripted **s**tyle **s** heets

#### Examples

* [here you can see csss in action](http://pstaender.github.io/csss/)
* [or try the editor](http://pstaender.github.io/csss/editor.html)

#### Why?

* stylus + sass inspired markup
* transcompiles to coffeescript and can be used with coffeescript
* produces css as output
* proof of concept (using cs as middleware)

#### Embed / test on your site

```html
<html>
<head>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
  <script src="//rezitech.github.com/stash/stash.min.js"></script>
  <script src="//raw.github.com/pstaender/csss/master/other/cssseditor.js"></script>
  <script type="text/javascript">
    $(document).ready(function(){
      var c = new csssEditor({ selector: $('body'), stash: true }, function(){
        // do some stuff after editor is loaded and ready to use
      });
    });
  </script>
</head>
<body>
<!-- … -->
</body>
</html>

```

Comments, improvements, thoughts and issues are always welcome :)

