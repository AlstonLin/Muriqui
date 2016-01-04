// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../../lib/codemirror"),require("../htmlmixed/htmlmixed"),require("../../addon/mode/overlay")):"function"==typeof define&&define.amd?define(["../../lib/codemirror","../htmlmixed/htmlmixed","../../addon/mode/overlay"],e):e(CodeMirror)}(function(e){"use strict";e.defineMode("django:inner",function(){function e(e,t){if(e.match("{{"))return t.tokenize=r,"tag";if(e.match("{%"))return t.tokenize=i,"tag";if(e.match("{#"))return t.tokenize=n,"comment";for(;null!=e.next()&&!e.match("{{",!1)&&!e.match("{%",!1););return null}function t(e,t){return function(r,i){if(!i.escapeNext&&r.eat(e))i.tokenize=t;else{i.escapeNext&&(i.escapeNext=!1);var n=r.next();"\\"==n&&(i.escapeNext=!0)}return"string"}}function r(r,i){if(i.waitDot){if(i.waitDot=!1,"."!=r.peek())return"null";if(r.match(/\.\W+/))return"error";if(r.eat("."))return i.waitProperty=!0,"null";throw Error("Unexpected error while waiting for property.")}if(i.waitPipe){if(i.waitPipe=!1,"|"!=r.peek())return"null";if(r.match(/\.\W+/))return"error";if(r.eat("|"))return i.waitFilter=!0,"null";throw Error("Unexpected error while waiting for filter.")}return i.waitProperty&&(i.waitProperty=!1,r.match(/\b(\w+)\b/))?(i.waitDot=!0,i.waitPipe=!0,"property"):i.waitFilter&&(i.waitFilter=!1,r.match(l))?"variable-2":r.eatSpace()?(i.waitProperty=!1,"null"):r.match(/\b\d+(\.\d+)?\b/)?"number":r.match("'")?(i.tokenize=t("'",i.tokenize),"string"):r.match('"')?(i.tokenize=t('"',i.tokenize),"string"):r.match(/\b(\w+)\b/)&&!i.foundVariable?(i.waitDot=!0,i.waitPipe=!0,"variable"):r.match("}}")?(i.waitProperty=null,i.waitFilter=null,i.waitDot=null,i.waitPipe=null,i.tokenize=e,"tag"):(r.next(),"null")}function i(r,i){if(i.waitDot){if(i.waitDot=!1,"."!=r.peek())return"null";if(r.match(/\.\W+/))return"error";if(r.eat("."))return i.waitProperty=!0,"null";throw Error("Unexpected error while waiting for property.")}if(i.waitPipe){if(i.waitPipe=!1,"|"!=r.peek())return"null";if(r.match(/\.\W+/))return"error";if(r.eat("|"))return i.waitFilter=!0,"null";throw Error("Unexpected error while waiting for filter.")}if(i.waitProperty&&(i.waitProperty=!1,r.match(/\b(\w+)\b/)))return i.waitDot=!0,i.waitPipe=!0,"property";if(i.waitFilter&&(i.waitFilter=!1,r.match(l)))return"variable-2";if(r.eatSpace())return i.waitProperty=!1,"null";if(r.match(/\b\d+(\.\d+)?\b/))return"number";if(r.match("'"))return i.tokenize=t("'",i.tokenize),"string";if(r.match('"'))return i.tokenize=t('"',i.tokenize),"string";if(r.match(u))return"operator";var n=r.match(a);return n?("comment"==n[0]&&(i.blockCommentTag=!0),"keyword"):r.match(/\b(\w+)\b/)?(i.waitDot=!0,i.waitPipe=!0,"variable"):r.match("%}")?(i.waitProperty=null,i.waitFilter=null,i.waitDot=null,i.waitPipe=null,i.blockCommentTag?(i.blockCommentTag=!1,i.tokenize=o):i.tokenize=e,"tag"):(r.next(),"null")}function n(t,r){return t.match("#}")&&(r.tokenize=e),"comment"}function o(e,t){return e.match(/\{%\s*endcomment\s*%\}/,!1)?(t.tokenize=i,e.match("{%"),"tag"):(e.next(),"comment")}var a=["block","endblock","for","endfor","true","false","loop","none","self","super","if","endif","as","else","import","with","endwith","without","context","ifequal","endifequal","ifnotequal","endifnotequal","extends","include","load","comment","endcomment","empty","url","static","trans","blocktrans","now","regroup","lorem","ifchanged","endifchanged","firstof","debug","cycle","csrf_token","autoescape","endautoescape","spaceless","ssi","templatetag","verbatim","endverbatim","widthratio"],l=["add","addslashes","capfirst","center","cut","date","default","default_if_none","dictsort","dictsortreversed","divisibleby","escape","escapejs","filesizeformat","first","floatformat","force_escape","get_digit","iriencode","join","last","length","length_is","linebreaks","linebreaksbr","linenumbers","ljust","lower","make_list","phone2numeric","pluralize","pprint","random","removetags","rjust","safe","safeseq","slice","slugify","stringformat","striptags","time","timesince","timeuntil","title","truncatechars","truncatechars_html","truncatewords","truncatewords_html","unordered_list","upper","urlencode","urlize","urlizetrunc","wordcount","wordwrap","yesno"],u=["==","!=","<",">","<=",">=","in","not","or","and"];return a=new RegExp("^\\b("+a.join("|")+")\\b"),l=new RegExp("^\\b("+l.join("|")+")\\b"),u=new RegExp("^\\b("+u.join("|")+")\\b"),{startState:function(){return{tokenize:e}},token:function(e,t){return t.tokenize(e,t)},blockCommentStart:"{% comment %}",blockCommentEnd:"{% endcomment %}"}}),e.defineMode("django",function(t){var r=e.getMode(t,"text/html"),i=e.getMode(t,"django:inner");return e.overlayMode(r,i)}),e.defineMIME("text/x-django","django")});