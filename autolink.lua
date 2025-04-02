-- This Pandoc filter adds hyperlinks to bare HTTP(S) URLs.

local function is_http_url(text)
    return string.find(text, [[http[s]?://[^\s]+]]) ~= nil
end

function Str(el)
    if is_http_url(el.text) then
        return pandoc.Link(el.text, el.text)
    end
    return el
end
