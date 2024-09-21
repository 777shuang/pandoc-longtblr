# pandoc-tabularray
Lua filter for using tblr/longtblr environment<br>
tblr/longtblr環境を使うためのLuaフィルター

# How to use

You must download [pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr).<br>
[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr)をダウンロードしなければなりません。

```shell
pandoc --filter pandoc-table-attr.py --lua-filter tabularray.lua input.md -o output.tex
```

[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr) must be loaded before `tabularray.lua`<br>
[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr)は`tabularray.lua`より先に読み込む必要があります

If you use pandoc-crossref, `tabularray.lua` must be loaded before.<br>
pandoc-crossrefを使う場合、`tabularray.lua`は先に読み込む必要があります
