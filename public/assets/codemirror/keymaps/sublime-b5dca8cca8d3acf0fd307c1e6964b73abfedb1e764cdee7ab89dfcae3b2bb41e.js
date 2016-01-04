// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../lib/codemirror"),require("../addon/search/searchcursor"),require("../addon/edit/matchbrackets")):"function"==typeof define&&define.amd?define(["../lib/codemirror","../addon/search/searchcursor","../addon/edit/matchbrackets"],e):e(CodeMirror)}(function(e){"use strict";function t(t,n,o){if(0>o&&0==n.ch)return t.clipPos(h(n.line-1));var r=t.getLine(n.line);if(o>0&&n.ch>=r.length)return t.clipPos(h(n.line+1,0));for(var i,a="start",l=n.ch,s=0>o?0:r.length,c=0;l!=s;l+=o,c++){var f=r.charAt(0>o?l-1:l),u="_"!=f&&e.isWordChar(f)?"w":"o";if("w"==u&&f.toUpperCase()==f&&(u="W"),"start"==a)"o"!=u&&(a="in",i=u);else if("in"==a&&i!=u){if("w"==i&&"W"==u&&0>o&&l--,"W"==i&&"w"==u&&o>0){i="w";continue}break}}return h(n.line,l)}function n(e,n){e.extendSelectionsBy(function(o){return e.display.shift||e.doc.extend||o.empty()?t(e.doc,o.head,n):0>n?o.from():o.to()})}function o(e,t){e.operation(function(){for(var n=e.listSelections().length,o=[],r=-1,i=0;n>i;i++){var a=e.listSelections()[i].head;if(!(a.line<=r)){var l=h(a.line+(t?0:1),0);e.replaceRange("\n",l,null,"+insertLine"),e.indentLine(l.line,null,!0),o.push({head:l,anchor:l}),r=a.line+1}}e.setSelections(o)})}function r(t,n){for(var o=n.ch,r=o,i=t.getLine(n.line);o&&e.isWordChar(i.charAt(o-1));)--o;for(;r<i.length&&e.isWordChar(i.charAt(r));)++r;return{from:h(n.line,o),to:h(n.line,r),word:i.slice(o,r)}}function i(e){var t=e.getCursor(),n=e.scanForBracket(t,-1);if(n)for(;;){var o=e.scanForBracket(t,1);if(!o)return;if(o.ch==g.charAt(g.indexOf(n.ch)+1))return e.setSelection(h(n.pos.line,n.pos.ch+1),o.pos,!1),!0;t=h(o.pos.line,o.pos.ch+1)}}function a(e,t){for(var n,o=e.listSelections(),r=[],i=0;i<o.length;i++){var a=o[i];if(!a.empty()){for(var l=a.from().line,s=a.to().line;i<o.length-1&&o[i+1].from().line==s;)s=a[++i].to().line;r.push(l,s)}}r.length?n=!0:r.push(e.firstLine(),e.lastLine()),e.operation(function(){for(var o=[],i=0;i<r.length;i+=2){var a=r[i],l=r[i+1],s=h(a,0),c=h(l),f=e.getRange(s,c,!1);t?f.sort():f.sort(function(e,t){var n=e.toUpperCase(),o=t.toUpperCase();return n!=o&&(e=n,t=o),t>e?-1:e==t?0:1}),e.replaceRange(f,s,c),n&&o.push({anchor:s,head:c})}n&&e.setSelections(o,0)})}function l(t,n){t.operation(function(){for(var o=t.listSelections(),i=[],a=[],l=0;l<o.length;l++){var s=o[l];s.empty()?(i.push(l),a.push("")):a.push(n(t.getRange(s.from(),s.to())))}t.replaceSelections(a,"around","case");for(var c,l=i.length-1;l>=0;l--){var s=o[i[l]];if(!(c&&e.cmpPos(s.head,c)>0)){var f=r(t,s.head);c=f.from,t.replaceRange(n(f.word),f.from,f.to)}}})}function s(t){var n=t.getCursor("from"),o=t.getCursor("to");if(0==e.cmpPos(n,o)){var i=r(t,n);if(!i.word)return;n=i.from,o=i.to}return{from:n,to:o,query:t.getRange(n,o),word:i}}function c(e,t){var n=s(e);if(n){var o=n.query,r=e.getSearchCursor(o,t?n.to:n.from);(t?r.findNext():r.findPrevious())?e.setSelection(r.from(),r.to()):(r=e.getSearchCursor(o,t?h(e.firstLine(),0):e.clipPos(h(e.lastLine()))),(t?r.findNext():r.findPrevious())?e.setSelection(r.from(),r.to()):n.word&&e.setSelection(n.from,n.to))}}var f=e.keyMap.sublime={fallthrough:"default"},u=e.commands,h=e.Pos,d=e.keyMap["default"]==e.keyMap.macDefault,p=d?"Cmd-":"Ctrl-";u[f["Alt-Left"]="goSubwordLeft"]=function(e){n(e,-1)},u[f["Alt-Right"]="goSubwordRight"]=function(e){n(e,1)};var m=d?"Ctrl-Alt-":"Ctrl-";u[f[m+"Up"]="scrollLineUp"]=function(e){var t=e.getScrollInfo();if(!e.somethingSelected()){var n=e.lineAtHeight(t.top+t.clientHeight,"local");e.getCursor().line>=n&&e.execCommand("goLineUp")}e.scrollTo(null,t.top-e.defaultTextHeight())},u[f[m+"Down"]="scrollLineDown"]=function(e){var t=e.getScrollInfo();if(!e.somethingSelected()){var n=e.lineAtHeight(t.top,"local")+1;e.getCursor().line<=n&&e.execCommand("goLineDown")}e.scrollTo(null,t.top+e.defaultTextHeight())},u[f["Shift-"+p+"L"]="splitSelectionByLine"]=function(e){for(var t=e.listSelections(),n=[],o=0;o<t.length;o++)for(var r=t[o].from(),i=t[o].to(),a=r.line;a<=i.line;++a)i.line>r.line&&a==i.line&&0==i.ch||n.push({anchor:a==r.line?r:h(a,0),head:a==i.line?i:h(a)});e.setSelections(n,0)},f["Shift-Tab"]="indentLess",u[f.Esc="singleSelectionTop"]=function(e){var t=e.listSelections()[0];e.setSelection(t.anchor,t.head,{scroll:!1})},u[f[p+"L"]="selectLine"]=function(e){for(var t=e.listSelections(),n=[],o=0;o<t.length;o++){var r=t[o];n.push({anchor:h(r.from().line,0),head:h(r.to().line+1,0)})}e.setSelections(n)},f["Shift-"+p+"K"]="deleteLine",u[f[p+"Enter"]="insertLineAfter"]=function(e){o(e,!1)},u[f["Shift-"+p+"Enter"]="insertLineBefore"]=function(e){o(e,!0)},u[f[p+"D"]="selectNextOccurrence"]=function(t){var n=t.getCursor("from"),o=t.getCursor("to"),i=t.state.sublimeFindFullWord==t.doc.sel;if(0==e.cmpPos(n,o)){var a=r(t,n);if(!a.word)return;t.setSelection(a.from,a.to),i=!0}else{var l=t.getRange(n,o),s=i?new RegExp("\\b"+l+"\\b"):l,c=t.getSearchCursor(s,o);c.findNext()?t.addSelection(c.from(),c.to()):(c=t.getSearchCursor(s,h(t.firstLine(),0)),c.findNext()&&t.addSelection(c.from(),c.to()))}i&&(t.state.sublimeFindFullWord=t.doc.sel)};var g="(){}[]";u[f["Shift-"+p+"Space"]="selectScope"]=function(e){i(e)||e.execCommand("selectAll")},u[f["Shift-"+p+"M"]="selectBetweenBrackets"]=function(t){return i(t)?void 0:e.Pass},u[f[p+"M"]="goToBracket"]=function(t){t.extendSelectionsBy(function(n){var o=t.scanForBracket(n.head,1);if(o&&0!=e.cmpPos(o.pos,n.head))return o.pos;var r=t.scanForBracket(n.head,-1);return r&&h(r.pos.line,r.pos.ch+1)||n.head})};var v=d?"Cmd-Ctrl-":"Shift-Ctrl-";u[f[v+"Up"]="swapLineUp"]=function(e){for(var t=e.listSelections(),n=[],o=e.firstLine()-1,r=[],i=0;i<t.length;i++){var a=t[i],l=a.from().line-1,s=a.to().line;r.push({anchor:h(a.anchor.line-1,a.anchor.ch),head:h(a.head.line-1,a.head.ch)}),0!=a.to().ch||a.empty()||--s,l>o?n.push(l,s):n.length&&(n[n.length-1]=s),o=s}e.operation(function(){for(var t=0;t<n.length;t+=2){var o=n[t],i=n[t+1],a=e.getLine(o);e.replaceRange("",h(o,0),h(o+1,0),"+swapLine"),i>e.lastLine()?e.replaceRange("\n"+a,h(e.lastLine()),null,"+swapLine"):e.replaceRange(a+"\n",h(i,0),null,"+swapLine")}e.setSelections(r),e.scrollIntoView()})},u[f[v+"Down"]="swapLineDown"]=function(e){for(var t=e.listSelections(),n=[],o=e.lastLine()+1,r=t.length-1;r>=0;r--){var i=t[r],a=i.to().line+1,l=i.from().line;0!=i.to().ch||i.empty()||a--,o>a?n.push(a,l):n.length&&(n[n.length-1]=l),o=l}e.operation(function(){for(var t=n.length-2;t>=0;t-=2){var o=n[t],r=n[t+1],i=e.getLine(o);o==e.lastLine()?e.replaceRange("",h(o-1),h(o),"+swapLine"):e.replaceRange("",h(o,0),h(o+1,0),"+swapLine"),e.replaceRange(i+"\n",h(r,0),null,"+swapLine")}e.scrollIntoView()})},f[p+"/"]="toggleComment",u[f[p+"J"]="joinLines"]=function(e){for(var t=e.listSelections(),n=[],o=0;o<t.length;o++){for(var r=t[o],i=r.from(),a=i.line,l=r.to().line;o<t.length-1&&t[o+1].from().line==l;)l=t[++o].to().line;n.push({start:a,end:l,anchor:!r.empty()&&i})}e.operation(function(){for(var t=0,o=[],r=0;r<n.length;r++){for(var i,a=n[r],l=a.anchor&&h(a.anchor.line-t,a.anchor.ch),s=a.start;s<=a.end;s++){var c=s-t;s==a.end&&(i=h(c,e.getLine(c).length+1)),c<e.lastLine()&&(e.replaceRange(" ",h(c),h(c+1,/^\s*/.exec(e.getLine(c+1))[0].length)),++t)}o.push({anchor:l||i,head:i})}e.setSelections(o,0)})},u[f["Shift-"+p+"D"]="duplicateLine"]=function(e){e.operation(function(){for(var t=e.listSelections().length,n=0;t>n;n++){var o=e.listSelections()[n];o.empty()?e.replaceRange(e.getLine(o.head.line)+"\n",h(o.head.line,0)):e.replaceRange(e.getRange(o.from(),o.to()),o.from())}e.scrollIntoView()})},f[p+"T"]="transposeChars",u[f.F9="sortLines"]=function(e){a(e,!0)},u[f[p+"F9"]="sortLinesInsensitive"]=function(e){a(e,!1)},u[f.F2="nextBookmark"]=function(e){var t=e.state.sublimeBookmarks;if(t)for(;t.length;){var n=t.shift(),o=n.find();if(o)return t.push(n),e.setSelection(o.from,o.to)}},u[f["Shift-F2"]="prevBookmark"]=function(e){var t=e.state.sublimeBookmarks;if(t)for(;t.length;){t.unshift(t.pop());var n=t[t.length-1].find();if(n)return e.setSelection(n.from,n.to);t.pop()}},u[f[p+"F2"]="toggleBookmark"]=function(e){for(var t=e.listSelections(),n=e.state.sublimeBookmarks||(e.state.sublimeBookmarks=[]),o=0;o<t.length;o++){for(var r=t[o].from(),i=t[o].to(),a=e.findMarks(r,i),l=0;l<a.length;l++)if(a[l].sublimeBookmark){a[l].clear();for(var s=0;s<n.length;s++)n[s]==a[l]&&n.splice(s--,1);break}l==a.length&&n.push(e.markText(r,i,{sublimeBookmark:!0,clearWhenEmpty:!1}))}},u[f["Shift-"+p+"F2"]="clearBookmarks"]=function(e){var t=e.state.sublimeBookmarks;if(t)for(var n=0;n<t.length;n++)t[n].clear();t.length=0},u[f["Alt-F2"]="selectBookmarks"]=function(e){var t=e.state.sublimeBookmarks,n=[];if(t)for(var o=0;o<t.length;o++){var r=t[o].find();r?n.push({anchor:r.from,head:r.to}):t.splice(o--,0)}n.length&&e.setSelections(n,0)},f["Alt-Q"]="wrapLines";var S=p+"K ";f[S+p+"Backspace"]="delLineLeft",u[f.Backspace="smartBackspace"]=function(t){if(t.somethingSelected())return e.Pass;var n=t.getCursor(),o=t.getRange({line:n.line,ch:0},n),r=e.countColumn(o,null,t.getOption("tabSize"));return o&&!/\S/.test(o)&&r%t.getOption("indentUnit")==0?t.indentSelection("subtract"):e.Pass},u[f[S+p+"K"]="delLineRight"]=function(e){e.operation(function(){for(var t=e.listSelections(),n=t.length-1;n>=0;n--)e.replaceRange("",t[n].anchor,h(t[n].to().line),"+delete");e.scrollIntoView()})},u[f[S+p+"U"]="upcaseAtCursor"]=function(e){l(e,function(e){return e.toUpperCase()})},u[f[S+p+"L"]="downcaseAtCursor"]=function(e){l(e,function(e){return e.toLowerCase()})},u[f[S+p+"Space"]="setSublimeMark"]=function(e){e.state.sublimeMark&&e.state.sublimeMark.clear(),e.state.sublimeMark=e.setBookmark(e.getCursor())},u[f[S+p+"A"]="selectToSublimeMark"]=function(e){var t=e.state.sublimeMark&&e.state.sublimeMark.find();t&&e.setSelection(e.getCursor(),t)},u[f[S+p+"W"]="deleteToSublimeMark"]=function(t){var n=t.state.sublimeMark&&t.state.sublimeMark.find();if(n){var o=t.getCursor(),r=n;if(e.cmpPos(o,r)>0){var i=r;r=o,o=i}t.state.sublimeKilled=t.getRange(o,r),t.replaceRange("",o,r)}},u[f[S+p+"X"]="swapWithSublimeMark"]=function(e){var t=e.state.sublimeMark&&e.state.sublimeMark.find();t&&(e.state.sublimeMark.clear(),e.state.sublimeMark=e.setBookmark(e.getCursor()),e.setCursor(t))},u[f[S+p+"Y"]="sublimeYank"]=function(e){null!=e.state.sublimeKilled&&e.replaceSelection(e.state.sublimeKilled,null,"paste")},f[S+p+"G"]="clearBookmarks",u[f[S+p+"C"]="showInCenter"]=function(e){var t=e.cursorCoords(null,"local");e.scrollTo(null,(t.top+t.bottom)/2-e.getScrollInfo().clientHeight/2)},u[f["Shift-Alt-Up"]="selectLinesUpward"]=function(e){e.operation(function(){for(var t=e.listSelections(),n=0;n<t.length;n++){var o=t[n];o.head.line>e.firstLine()&&e.addSelection(h(o.head.line-1,o.head.ch))}})},u[f["Shift-Alt-Down"]="selectLinesDownward"]=function(e){e.operation(function(){for(var t=e.listSelections(),n=0;n<t.length;n++){var o=t[n];o.head.line<e.lastLine()&&e.addSelection(h(o.head.line+1,o.head.ch))}})},u[f[p+"F3"]="findUnder"]=function(e){c(e,!0)},u[f["Shift-"+p+"F3"]="findUnderPrevious"]=function(e){c(e,!1)},u[f["Alt-F3"]="findAllUnder"]=function(e){var t=s(e);if(t){for(var n=e.getSearchCursor(t.query),o=[],r=-1;n.findNext();)o.push({anchor:n.from(),head:n.to()}),n.from().line<=t.from.line&&n.from().ch<=t.from.ch&&r++;e.setSelections(o,r)}},f["Shift-"+p+"["]="fold",f["Shift-"+p+"]"]="unfold",f[S+p+"0"]=f[S+p+"j"]="unfoldAll",f[p+"I"]="findIncremental",f["Shift-"+p+"I"]="findIncrementalReverse",f[p+"H"]="replace",f.F3="findNext",f["Shift-F3"]="findPrev",e.normalizeKeyMap(f)});