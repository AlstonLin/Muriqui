// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../../lib/codemirror"),require("../../mode/css/css")):"function"==typeof define&&define.amd?define(["../../lib/codemirror","../../mode/css/css"],e):e(CodeMirror)}(function(e){"use strict";var r={link:1,visited:1,active:1,hover:1,focus:1,"first-letter":1,"first-line":1,"first-child":1,before:1,after:1,lang:1};e.registerHelper("hint","css",function(t){function o(e){for(var r in e)c&&0!=r.lastIndexOf(c,0)||l.push(r)}var s=t.getCursor(),i=t.getTokenAt(s),n=e.innerMode(t.getMode(),i.state);if("css"==n.mode.name){if("keyword"==i.type&&0=="!important".indexOf(i.string))return{list:["!important"],from:e.Pos(s.line,i.start),to:e.Pos(s.line,i.end)};var a=i.start,d=s.ch,c=i.string.slice(0,d-a);/[^\w$_-]/.test(c)&&(c="",a=d=s.ch);var f=e.resolveMode("text/css"),l=[],p=n.state.state;return"pseudo"==p||"variable-3"==i.type?o(r):"block"==p||"maybeprop"==p?o(f.propertyKeywords):"prop"==p||"parens"==p||"at"==p||"params"==p?(o(f.valueKeywords),o(f.colorKeywords)):("media"==p||"media_parens"==p)&&(o(f.mediaTypes),o(f.mediaFeatures)),l.length?{list:l,from:e.Pos(s.line,a),to:e.Pos(s.line,d)}:void 0}})});