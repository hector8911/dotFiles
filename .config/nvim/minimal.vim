scriptencoding utf-8

let g:airline#themes#minimal#palette = {}

let s:N1   = [ '#00005f' , '#30CFE9' , 17  , 190 ]
let s:N2   = [ '#E5E5E5' , '#444444' , 255 , 238 ]
let s:N3   = [ '#9cffd3' , '#31322c' , 85  , 234 ]
let g:airline#themes#minimal#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#minimal#palette.accents = {
      \ 'red': [ '#FF1E8E' , '' , 160 , ''  ]
      \ }

let pal = g:airline#themes#minimal#palette
for item in ['insert', 'replace', 'visual', 'inactive', 'ctrlp']
  exe "let pal.".item." = pal.normal"
  for suffix in ['_modified', '_paste']
    exe "let pal.".item.suffix. " = pal.normal"
  endfor
endfor
