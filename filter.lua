local function is_http_url(text)
    return string.match(text, [[http[s]?://[^%s]+]]) ~= nil
end

function Str(el)
    -- Add hyperlinks to bare HTTP(S) URLs.
    -- Similar to the autolink_bare_uris extension for Markdown,
    -- which will not be added to the man reader; see
    -- https://github.com/jgm/pandoc/issues/10566
    if is_http_url(el.text) then
        return pandoc.Link(el.text, el.text)
    end
    return el
end

function Header(el)
    -- Assign identifiers to man headings (workaround for https://github.com/jgm/pandoc/issues/8852)
    -- and make each heading a link to itself.
    el.identifier = pandoc.text.lower(pandoc.utils.stringify(el.content)):gsub(" ", "-")
    el.content = pandoc.Link(el.content, "#" .. el.identifier)
    return el
end
