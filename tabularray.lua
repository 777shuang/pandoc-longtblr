function RawInline(el)
    if el.format == "html" and el.text == "<br>" then
        return pandoc.LineBreak()
    end
    return el
end

function LaTeX(text)
    return pandoc.RawInline("latex", text)
end

-- List of Row to LaTeX code
function Rows(rows)
    local inlines = {}
    for _, row in ipairs(rows) do
        for i, cell in ipairs(row.cells) do
            if i == 1 then
                table.insert(inlines, LaTeX("{"))
            else
                table.insert(inlines, LaTeX("} & {"))
            end
            for _, inline in ipairs(pandoc.utils.blocks_to_inlines(cell.contents)) do
                table.insert(inlines, inline)
            end
        end
        table.insert(inlines, LaTeX("} \\\\\n"))
    end
    return inlines
end

function Colspec(el)
    local colspec_text = el.attributes["colspec"]
    if colspec_text == nil then
        colspec_text = ""
        for _, colspec in ipairs(el.colspecs) do
            local alignment = {
                AlignDefault = "l",
                AlignLeft = "l",
                AlignCenter = "c",
                AlignRight = "r"
            }
            colspec_text = colspec_text .. alignment[colspec[1]]
        end
    end
    return colspec_text
end

function Table(el)
    local tbl = {}
    local caption = el.caption["long"]
    local label = el.identifier

    if #el.classes == 1 and el.classes[1] == "long" then
        local begin = {LaTeX("\\begin{center}\\begin{longtblr}")}
        if caption ~= nil then
            table.insert(begin, LaTeX("[\n  caption={"))
            for _, inline in ipairs(pandoc.utils.blocks_to_inlines(caption)) do
                table.insert(begin, inline)
            end
            table.insert(begin, LaTeX("},\n"))
            if label ~= "" then
                table.insert(begin, LaTeX("  label={" .. label .. "},\n"))
            end
            table.insert(begin, LaTeX("]"))
        else
            table.insert(begin, LaTeX("[label=none ,entry=none]"))
        end
        table.insert(begin, LaTeX("{\n  colspec={" .. Colspec(el) .. "},\n"))
        table.insert(begin, LaTeX("  rowhead=1,\n"))
        table.insert(begin, LaTeX("}"))

        table.insert(tbl, begin)

        table.insert(tbl, LaTeX("\\hline"))
        table.insert(tbl, Rows(el.head.rows))
        table.insert(tbl, LaTeX("\\hline"))
        for _, body in ipairs(el.bodies) do
            table.insert(tbl, Rows(body.body))
        end
        table.insert(tbl, LaTeX("\\hline"))
        table.insert(tbl, LaTeX("\\end{longtblr}\\end{center}"))
    else
        local begin = {}
        table.insert(begin, LaTeX("\\begin{table}\n\\centering\n"))
        if caption ~= nil then
            table.insert(begin, LaTeX("\\caption{"))
            for _, inline in ipairs(pandoc.utils.blocks_to_inlines(caption)) do
                table.insert(begin, inline)
            end
            table.insert(begin, LaTeX("}\n"))
            if label and label ~= "" then
                table.insert(begin, LaTeX("\\label{" .. label .. "}"))
            end
        end
        table.insert(begin, LaTeX("\\begin{tblr}{colspec={" .. Colspec(el) .. "}}"))

        table.insert(tbl, begin)

        table.insert(tbl, LaTeX("\\hline"))
        table.insert(tbl, Rows(el.head.rows))
        table.insert(tbl, LaTeX("\\hline"))
        for _, body in ipairs(el.bodies) do
            table.insert(tbl, Rows(body.body))
        end
        table.insert(tbl, LaTeX("\\hline"))

        table.insert(tbl, LaTeX("\\end{tblr}\n\\end{table}"))
    end
    return tbl
end
