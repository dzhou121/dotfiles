# -*- coding: utf-8 -*-
import os
import sys

file_node_extensions = {
    'styl'     : '',
    'scss'     : '',
    'htm'      : '',
    'html'     : '',
    'slim'     : '',
    'ejs'      : '',
    'css'      : '',
    'less'     : '',
    'md'       : '',
    'markdown' : '',
    'json'     : '',
    'js'       : '',
    'jsx'      : '',
    'rb'       : '',
    'php'      : '',
    'py'       : '',
    'pyc'      : '',
    'pyo'      : '',
    'pyd'      : '',
    'coffee'   : '',
    'mustache' : '',
    'hbs'      : '',
    'conf'     : '',
    'ini'      : '',
    'yml'      : '',
    'bat'      : '',
    'jpg'      : '',
    'jpeg'     : '',
    'bmp'      : '',
    'png'      : '',
    'gif'      : '',
    'ico'      : '',
    'twig'     : '',
    'cpp'      : '',
    'c++'      : '',
    'cxx'      : '',
    'cc'       : '',
    'cp'       : '',
    'c'        : '',
    'hs'       : '',
    'lhs'      : '',
    'lua'      : '',
    'java'     : '',
    'sh'       : '',
    'fish'     : '',
    'ml'       : 'λ',
    'mli'      : 'λ',
    'diff'     : '',
    'db'       : '',
    'sql'      : '',
    'dump'     : '',
    'clj'      : '',
    'cljc'     : '',
    'cljs'     : '',
    'edn'      : '',
    'scala'    : '',
    'go'       : '',
    'dart'     : '',
    'xul'      : '',
    'sln'      : '',
    'suo'      : '',
    'pl'       : '',
    'pm'       : '',
    't'        : '',
    'rss'      : '',
    'f#'       : '',
    'fsscript' : '',
    'fsx'      : '',
    'fs'       : '',
    'fsi'      : '',
    'rs'       : '',
    'rlib'     : '',
    'd'        : '',
    'erl'      : '',
    'hrl'      : '',
    'vim'      : '',
    'ai'       : '',
    'psd'      : '',
    'psb'      : '',
    'ts'       : '',
    'jl'       : ''
}

if len(sys.argv) > 1:
    rootdir = sys.argv[1]
else:
    rootdir = '.'
for root, dirs, files in os.walk(rootdir):
    files = [f for f in files if not f[0] == '.']
    dirs[:] = [d for d in dirs if not d[0] == '.']
    if rootdir == ".":
        root = root.replace("./", "")
        if root == ".":
            root = ""

    for f in files:
        extension = f.split('.')[-1]
        icon = file_node_extensions.get(extension, '')
        print('%s  %s' % (icon, os.path.join(root, f)))
