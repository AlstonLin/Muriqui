// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../../lib/codemirror")):"function"==typeof define&&define.amd?define(["../../lib/codemirror"],e):e(CodeMirror)}(function(e){function t(e,t){return"pairs"==t&&"string"==typeof e?e:"object"==typeof e&&null!=e[t]?e[t]:f[t]}function r(e){return function(t){return o(t,e)}}function n(e){var t=e.state.closeBrackets;if(!t)return null;var r=e.getModeAt(e.getCursor());return r.closeBrackets||t}function i(r){var i=n(r);if(!i||r.getOption("disableInput"))return e.Pass;for(var a=t(i,"pairs"),o=r.listSelections(),s=0;s<o.length;s++){if(!o[s].empty())return e.Pass;var c=l(r,o[s].head);if(!c||a.indexOf(c)%2!=0)return e.Pass}for(var s=o.length-1;s>=0;s--){var f=o[s].head;r.replaceRange("",u(f.line,f.ch-1),u(f.line,f.ch+1))}}function a(r){var i=n(r),a=i&&t(i,"explode");if(!a||r.getOption("disableInput"))return e.Pass;for(var o=r.listSelections(),s=0;s<o.length;s++){if(!o[s].empty())return e.Pass;var c=l(r,o[s].head);if(!c||a.indexOf(c)%2!=0)return e.Pass}r.operation(function(){r.replaceSelection("\n\n",null),r.execCommand("goCharLeft"),o=r.listSelections();for(var e=0;e<o.length;e++){var t=o[e].head.line;r.indentLine(t,null,!0),r.indentLine(t+1,null,!0)}})}function o(r,i){var a=n(r);if(!a||r.getOption("disableInput"))return e.Pass;var o=t(a,"pairs"),l=o.indexOf(i);if(-1==l)return e.Pass;for(var f,h,d=t(a,"triples"),g=o.charAt(l+1)==i,p=r.listSelections(),v=l%2==0,m=0;m<p.length;m++){var b,x=p[m],C=x.head,h=r.getRange(C,u(C.line,C.ch+1));if(v&&!x.empty())b="surround";else if(!g&&v||h!=i)if(g&&C.ch>1&&d.indexOf(i)>=0&&r.getRange(u(C.line,C.ch-2),C)==i+i&&(C.ch<=2||r.getRange(u(C.line,C.ch-3),u(C.line,C.ch-2))!=i))b="addFour";else if(g){if(e.isWordChar(h)||!c(r,C,i))return e.Pass;b="both"}else{if(!v||r.getLine(C.line).length!=C.ch&&!s(h,o)&&!/\s/.test(h))return e.Pass;b="both"}else b=d.indexOf(i)>=0&&r.getRange(C,u(C.line,C.ch+3))==i+i+i?"skipThree":"skip";if(f){if(f!=b)return e.Pass}else f=b}var k=l%2?o.charAt(l-1):i,P=l%2?i:o.charAt(l+1);r.operation(function(){if("skip"==f)r.execCommand("goCharRight");else if("skipThree"==f)for(var e=0;3>e;e++)r.execCommand("goCharRight");else if("surround"==f){for(var t=r.getSelections(),e=0;e<t.length;e++)t[e]=k+t[e]+P;r.replaceSelections(t,"around")}else"both"==f?(r.replaceSelection(k+P,null),r.triggerElectric(k+P),r.execCommand("goCharLeft")):"addFour"==f&&(r.replaceSelection(k+k+k+k,"before"),r.execCommand("goCharRight"))})}function s(e,t){var r=t.lastIndexOf(e);return r>-1&&r%2==1}function l(e,t){var r=e.getRange(u(t.line,t.ch-1),u(t.line,t.ch+1));return 2==r.length?r:null}function c(t,r,n){var i=t.getLine(r.line),a=t.getTokenAt(r);if(/\bstring2?\b/.test(a.type))return!1;var o=new e.StringStream(i.slice(0,r.ch)+n+i.slice(r.ch),4);for(o.pos=o.start=a.start;;){var s=t.getMode().token(o,a.state);if(o.pos>=r.ch+1)return/\bstring2?\b/.test(s);o.start=o.pos}}var f={pairs:"()[]{}''\"\"",triples:"",explode:"[]{}"},u=e.Pos;e.defineOption("autoCloseBrackets",!1,function(t,r,n){n&&n!=e.Init&&(t.removeKeyMap(d),t.state.closeBrackets=null),r&&(t.state.closeBrackets=r,t.addKeyMap(d))});for(var h=f.pairs+"`",d={Backspace:i,Enter:a},g=0;g<h.length;g++)d["'"+h.charAt(g)+"'"]=r(h.charAt(g))});