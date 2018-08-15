var codemirrors = [];
var indentUnits = {
  'text/x-java': 4,
  'text/x-yaml': 2
}

function prepareEditor() {
  $("pre").each(function() {
    var codeNode = this;
    if ($(codeNode).data('lang') === 'plain'
        || $(codeNode).data('lang') === 'text'
        || $(codeNode).hasClass('example')
        || $(codeNode).hasClass('examples'))
    {
        return; // do nothing
    }
    var body = codeNode.innerText || codeNode.textContent;
    if (body != null) { body = body.replace(/(\r?\n|\r)\s*$/, ''); }
    CodeMirror(function(newEditor) {
      $(codeNode).replaceWith(newEditor);
    }, {
      value: body,
      theme: 'aptana',
      mode: $(codeNode).data('lang') || 'text/x-java',
      readOnly: true,
      autofocus: false,
      lineNumbers: $(codeNode).hasClass('lineNumbers') || !$(codeNode).hasClass('noLineNumbers')
    });
  });

  $("textarea.code").each(function() {
  	var codeNode = this;
    var lang = $(codeNode).data('lang') || 'text/x-java';
    var indentUnit = indentUnits[lang];
  	var codemirror = CodeMirror.fromTextArea(codeNode, {
      theme: 'aptana',
      mode: lang,
      indentUnit: indentUnit,
      tabSize: indentUnit,
      autoClearEmptyLines: true,
      fixedGutter: true,
      matchBrackets: true,
      /* autofocus: true, */
      autofocus: false,
      lineNumbers: true,
      viewportMargin: 150,
      lineWrapping: true
  	});
  	/* For some reason, CodeMirror's focus() doesn't seem to work
  	 * correctly, so need to leave it turned off until we can fix it.
  	 * Once fixed, remove the comment for autofocus above.
  	 */
     var cmObj = { editor: codemirror, starterCode: $(codeNode).data('starter-code') }
     codemirrors.push(cmObj)
  });
}

$(document).ready(function() {
  prepareEditor();

  $('.btn-reset').on('click', function() {
    $('#confirm-reset').modal('toggle');
    codemirrors.forEach(function(cmObj, index, array) {
      cmObj.editor.setValue(cmObj.starterCode);
    });
  });
});
