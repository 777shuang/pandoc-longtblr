# pandoc-longtblr
Lua filter for using longtblr environment<br>
longtblr環境を使うためのLuaフィルター

# How to use

You must download [pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr).<br>
[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr)をダウンロードしなければなりません。

```shell
pandoc --filter pandoc-table-attr.py --lua-filter longtblr.lua input.md -o output.tex
```

[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr) must be loaded before `longtblr.lua`<br>
[pandoc-table-attr](https://github.com/rnwst/pandoc-table-attr)は`longtblr.lua`より先に読み込む必要があります
