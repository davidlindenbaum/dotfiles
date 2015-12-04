" Vim filetype plugin
" Language:	Vim
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2013 Jun 26

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setl fo< isk< com< tw< commentstring<"
	\ . "| unlet! b:match_ignorecase b:match_words b:match_skip"

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" To allow tag lookup via CTRL-] for autoload functions, '#' must be a
" keyword character.  E.g., for netrw#Nread().
setlocal isk+=#

" Set 'comments' to format dashed lists in comments
setlocal com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"

" Format comments to be up to 78 characters long
if &tw == 0
  setlocal tw=78
endif

" Comments start with a double quote
setlocal commentstring=\"%s

" Let the matchit plugin know what items can be matched.
if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words =
	\ '\<fu\%[nction]\>:\<retu\%[rn]\>:\<endf\%[unction]\>,' .
 	\ '\<\(wh\%[ile]\|for\)\>:\<brea\%[k]\>:\<con\%[tinue]\>:\<end\(w\%[hile]\|fo\%[r]\)\>,' .
	\ '\<if\>:\<el\%[seif]\>:\<en\%[dif]\>,' .
	\ '\<try\>:\<cat\%[ch]\>:\<fina\%[lly]\>:\<endt\%[ry]\>,' .
	\ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,' .
	\ '(:)'
  " Ignore ":syntax region" commands, the 'end' argument clobbers if-endif
  let b:match_skip = 'getline(".") =~ "^\\s*sy\\%[ntax]\\s\\+region" ||
	\ synIDattr(synID(line("."),col("."),1),"name") =~? "comment\\|string"'
endif

let &cpo = s:cpo_save
unlet s:cpo_save
