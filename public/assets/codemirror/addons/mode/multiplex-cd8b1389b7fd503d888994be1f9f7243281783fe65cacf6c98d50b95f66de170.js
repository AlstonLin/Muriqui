// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../../lib/codemirror")):"function"==typeof define&&define.amd?define(["../../lib/codemirror"],e):e(CodeMirror)}(function(e){"use strict";e.multiplexingMode=function(n){function t(e,n,t,r){if("string"==typeof n){var i=e.indexOf(n,t);return r&&i>-1?i+n.length:i}var o=n.exec(t?e.slice(t):e);return o?o.index+t+(r?o[0].length:0):-1}var r=Array.prototype.slice.call(arguments,1);return{startState:function(){return{outer:e.startState(n),innerActive:null,inner:null}},copyState:function(t){return{outer:e.copyState(n,t.outer),innerActive:t.innerActive,inner:t.innerActive&&e.copyState(t.innerActive.mode,t.inner)}},token:function(i,o){if(o.innerActive){var c=o.innerActive,l=i.string;if(!c.close&&i.sol())return o.innerActive=o.inner=null,this.token(i,o);var s=c.close?t(l,c.close,i.pos,c.parseDelimiters):-1;if(s==i.pos&&!c.parseDelimiters)return i.match(c.close),o.innerActive=o.inner=null,c.delimStyle;s>-1&&(i.string=l.slice(0,s));var u=c.mode.token(i,o.inner);return s>-1&&(i.string=l),s==i.pos&&c.parseDelimiters&&(o.innerActive=o.inner=null),c.innerStyle&&(u=u?u+" "+c.innerStyle:c.innerStyle),u}for(var a=1/0,l=i.string,v=0;v<r.length;++v){var d=r[v],s=t(l,d.open,i.pos);if(s==i.pos)return d.parseDelimiters||i.match(d.open),o.innerActive=d,o.inner=e.startState(d.mode,n.indent?n.indent(o.outer,""):0),d.delimStyle;-1!=s&&a>s&&(a=s)}a!=1/0&&(i.string=l.slice(0,a));var f=n.token(i,o.outer);return a!=1/0&&(i.string=l),f},indent:function(t,r){var i=t.innerActive?t.innerActive.mode:n;return i.indent?i.indent(t.innerActive?t.inner:t.outer,r):e.Pass},blankLine:function(t){var i=t.innerActive?t.innerActive.mode:n;if(i.blankLine&&i.blankLine(t.innerActive?t.inner:t.outer),t.innerActive)"\n"===t.innerActive.close&&(t.innerActive=t.inner=null);else for(var o=0;o<r.length;++o){var c=r[o];"\n"===c.open&&(t.innerActive=c,t.inner=e.startState(c.mode,i.indent?i.indent(t.outer,""):0))}},electricChars:n.electricChars,innerMode:function(e){return e.inner?{state:e.inner,mode:e.innerActive.mode}:{state:e.outer,mode:n}}}}});