" File: shebang.vim
" Author: Vital Kudzelka
" Description: Filetype detection by shebang at file.


fun! shebang#default(name, default) " {{{ set default value if not set
  if !exists(a:name)
    let {a:name} = a:default
  endif
  return {a:name}
endf " }}}
fun! shebang#error(message) " {{{ show error message
  echohl ErrorMsg
  echomsg a:message
  echohl None
endf " }}}
fun! shebang#test(fn, expected, ...) " {{{ call function with passed params and
  " compare expected value with returned result
  if a:0 < 1
    call shebang#error('Test: Expected one more additional param')
    return 1
  endif

  let cmd = "let result = function(a:fn)(a:1"
  let idx = 2
  while idx <= a:0
    let cmd .= ", a:" . string(idx)
    let idx += 1
  endwhile
  let cmd .= ")"
  exe cmd

  if empty(result) || result !=# a:expected
    call shebang#error('TEST FAILED! on ' . string(a:fn))
    echomsg 'Returned=' . string(result)
    echomsg 'Expected=' . string(a:expected)
  endif
endf " }}}
fun! shebang#detect_filetype(line, patterns) " {{{ try to detect current filetype
  for pattern in keys(a:patterns)
    if a:line =~# pattern
      return a:patterns[pattern]
    endif
  endfor
endf " }}}
fun! s:detect_filetype_test(line, patterns, expected) " {{{ test
  call shebang#test("shebang#detect_filetype", a:expected, a:line, a:patterns)
endf " }}}
fun! shebang#unittest() " {{{ all tests
  let patterns = {
        \ '^#!.*\s\+osascript\>'                            : 'applescript',
        \ '^#!.*[s]\?bin/osascript'                         : 'applescript',
        \ '^#!.*\s\+escript\>'                              : 'erlang',
        \ '^#!.*[s]\?bin/escript'                           : 'erlang',
        \ '^#!.*\s\+fish\>'                                 : 'fish',
        \ '^#!.*[s]\?bin/fish'                              : 'fish',
        \ '^#!.*\s\+ion\>'                                  : 'ion',
        \ '^#!.*[s]\?bin/ion'                               : 'ion',
        \ '^#!.*\s\+node\>'                                 : 'javascript',
        \ '^#!.*\s\+lua\>'                                  : 'lua',
        \ '^#!.*[s]\?bin/lua'                               : 'lua',
        \ '^#!.*\s\+perl\>'                                 : 'perl',
        \ '^#!.*[s]\?bin/perl'                              : 'perl',
        \ '^#!.*\s\+php\>'                                  : 'php',
        \ '^#!.*[s]\?bin/php'                               : 'php',
        \ '^#!.*\s\+python\>'                               : 'python',
        \ '^#!.*[s]\?bin/python'                            : 'python',
        \ '^#!.*\s\+jython\>'                               : 'python',
        \ '^#!.*[s]\?bin/jython'                            : 'python',
        \ '^#!.*\s\+pypy\>'                                 : 'python',
        \ '^#!.*[s]\?bin/pypy'                              : 'python',
        \ '^#!.*\s\+ruby\>'                                 : 'ruby',
        \ '^#!.*[s]\?bin/ruby'                              : 'ruby',
        \ '^#!.*[s]\?bin/sh\>'                              : 'sh',
        \ '^#!.*[s]\?bin/bash\>'                            : 'sh',
        \ '^#!.*\s\+\(ba\|c\|a\|da\|k\|pdk\|mk\|tc\)\?sh\>' : 'sh',
        \ '^#!.*\s\+zsh\>'                                  : 'zsh',
        \ }
  " applescript
  call s:detect_filetype_test('#!/usr/bin/env osascript' , patterns , 'applescript')
  call s:detect_filetype_test('#!/usr/sbin/osascript'    , patterns , 'applescript')
  call s:detect_filetype_test('#!/usr/bin/osascript'     , patterns , 'applescript')
  call s:detect_filetype_test('#!/sbin/osascript'        , patterns , 'applescript')
  call s:detect_filetype_test('#!/bin/osascript'         , patterns , 'applescript')
  " escript
  call s:detect_filetype_test('#!/usr/bin/env escript'   , patterns , 'erlang')
  call s:detect_filetype_test('#!/usr/sbin/escript'      , patterns , 'erlang')
  call s:detect_filetype_test('#!/usr/bin/escript'       , patterns , 'erlang')
  call s:detect_filetype_test('#!/sbin/escript'          , patterns , 'erlang')
  call s:detect_filetype_test('#!/bin/escript'           , patterns , 'erlang')
  " fish
  call s:detect_filetype_test('#!/usr/bin/env fish'      , patterns , 'fish')
  call s:detect_filetype_test('#!/usr/sbin/fish'         , patterns , 'fish')
  call s:detect_filetype_test('#!/usr/bin/fish'          , patterns , 'fish')
  call s:detect_filetype_test('#!/sbin/fish'             , patterns , 'fish')
  call s:detect_filetype_test('#!/bin/fish'              , patterns , 'fish')
  " ion
  call s:detect_filetype_test('#!/usr/bin/env ion'       , patterns , 'ion')
  call s:detect_filetype_test('#!/usr/sbin/ion'          , patterns , 'ion')
  call s:detect_filetype_test('#!/usr/bin/ion'           , patterns , 'ion')
  call s:detect_filetype_test('#!/sbin/ion'              , patterns , 'ion')
  call s:detect_filetype_test('#!/bin/ion'               , patterns , 'ion')
  " javascript
  call s:detect_filetype_test('#!/usr/bin/env node'      , patterns , 'javascript')
  " lua
  call s:detect_filetype_test('#!/usr/bin/env lua'       , patterns , 'lua')
  call s:detect_filetype_test('#!/usr/sbin/lua'          , patterns , 'lua')
  call s:detect_filetype_test('#!/usr/bin/lua'           , patterns , 'lua')
  call s:detect_filetype_test('#!/sbin/lua'              , patterns , 'lua')
  call s:detect_filetype_test('#!/bin/lua'               , patterns , 'lua')
  " php
  call s:detect_filetype_test('#!/usr/bin/env php'       , patterns , 'php')
  call s:detect_filetype_test('#!/usr/sbin/php'          , patterns , 'php')
  call s:detect_filetype_test('#!/usr/bin/php'           , patterns , 'php')
  call s:detect_filetype_test('#!/sbin/php'              , patterns , 'php')
  call s:detect_filetype_test('#!/bin/php'               , patterns , 'php')
  " perl
  call s:detect_filetype_test('#!/usr/bin/env perl'      , patterns , 'perl')
  call s:detect_filetype_test('#!/usr/sbin/perl'         , patterns , 'perl')
  call s:detect_filetype_test('#!/usr/bin/perl'          , patterns , 'perl')
  call s:detect_filetype_test('#!/sbin/perl'             , patterns , 'perl')
  call s:detect_filetype_test('#!/bin/perl'              , patterns , 'perl')
  " python
  call s:detect_filetype_test('#!/usr/bin/env jython'    , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/env pypy3'     , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/env pypy'      , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/env python3'   , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/env python2'   , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/env python'    , patterns , 'python')
  
  call s:detect_filetype_test('#!/usr/bin/jython'        , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/pypy3'         , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/pypy'          , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/python3'       , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/python2'       , patterns , 'python')

  call s:detect_filetype_test('#!/usr/sbin/python'       , patterns , 'python')
  call s:detect_filetype_test('#!/usr/bin/python'        , patterns , 'python')
  call s:detect_filetype_test('#!/sbin/python'           , patterns , 'python')
  call s:detect_filetype_test('#!/bin/python'            , patterns , 'python')
  " ruby
  call s:detect_filetype_test('#!/usr/bin/env ruby'      , patterns , 'ruby')
  call s:detect_filetype_test('#!/usr/sbin/ruby'         , patterns , 'ruby')
  call s:detect_filetype_test('#!/usr/bin/ruby'          , patterns , 'ruby')
  call s:detect_filetype_test('#!/sbin/ruby'             , patterns , 'ruby')
  call s:detect_filetype_test('#!/bin/ruby'              , patterns , 'ruby')
  " shells
  call s:detect_filetype_test('#!/usr/sbin/sh'           , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/sh'            , patterns , 'sh')
  call s:detect_filetype_test('#!/sbin/sh'               , patterns , 'sh')
  call s:detect_filetype_test('#!/bin/sh'                , patterns , 'sh')

  call s:detect_filetype_test('#!/usr/sbin/bash'         , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/bash'          , patterns , 'sh')
  call s:detect_filetype_test('#!/sbin/bash'             , patterns , 'sh')
  call s:detect_filetype_test('#!/bin/bash'              , patterns , 'sh')

  call s:detect_filetype_test('#!/usr/bin/env sh'        , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env csh'       , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env ash'       , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env dash'      , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env ksh'       , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env pdksh'     , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env tcsh'      , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env mksh'      , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/env bash'      , patterns , 'sh')
  " zsh
  call s:detect_filetype_test('#!/usr/bin/env zsh'       , patterns , 'zsh')
  call s:detect_filetype_test('#!/usr/sbin/zsh'          , patterns , 'sh')
  call s:detect_filetype_test('#!/usr/bin/zsh'           , patterns , 'sh')
  call s:detect_filetype_test('#!/sbin/zsh'              , patterns , 'sh')
  call s:detect_filetype_test('#!/bin/zsh'               , patterns , 'sh')
endf " }}}
