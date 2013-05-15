(function(root, $) {

  var loadJS = function (url, loaded) {
    var scr = document.createElement('script');
    scr.type = 'text/javascript';
    scr.src = url;
    if (navigator.userAgent.indexOf('MSIE') > -1) {
      scr.onload = scr.onreadystatechange = function () {
        if (self.readyState == "loaded" || self.readyState == "complete") {
          if (loaded) { loaded(); }
        }
        scr.onload = scr.onreadystatechange = null;
      };
    } else {
      scr.onload = loaded;
    }
    document.getElementsByTagName('head')[0].appendChild(scr);
  };

  $(document).ready(function(){

    var embedEditor = function() {
      var c = new csssEditor({ selector: $('body'), stash: true }, function(){
        var data = stash.get('csss_editor_input');
        if (data) {
          $('#csssEditor_input').text(data);
          c.applyCSSSToDocument(data);
        }
      });
      c.done = function(e,source){
        $error = $('#csssEditor_error');
        if (e) {
          if (e.location) {
            // console.error(e);
            $error.text(e.message+" on line "+e.location.first_line);
          } else {
            // console.error(e.message);
            $error.text(e.message);
          }
        } else {
          $error.text('');
        }
      }
    }

    loadJS('http://raw.github.com/pstaender/csss/master/other/cssseditor.js', embedEditor);
  });

})(window, jQuery);