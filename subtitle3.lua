if FORMAT:match('beamer') then
    function Header(elem)
        -- Safely get the slide level, defaulting to 2 if not set
        local slide_level = PANDOC_WRITER_OPTIONS.slide_level or 1

        -- Check if the header level is one above the slide level
        if elem.level == slide_level + 1 then
            -- Check if the header includes the class "subtitle"
            if elem.classes:includes("subtitle") then
                -- Return a LaTeX framesubtitle command
                return pandoc.RawBlock('latex', '\\framesubtitle{' .. pandoc.utils.stringify(elem.content) .. '}')
            end
        end

        -- Return the original element if conditions are not met
        return elem
    end
end
