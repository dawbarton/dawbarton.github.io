using Dates

hfun_datetext(date=locvar("published")) = Dates.format(date, dateformat"yyyy-mm-dd")

function hfun_inserttitle()
    title = locvar("title")
    date = locvar("published")
    if title === nothing
        return ""
    elseif date === nothing
        return "<div class=\"franklin-content\"><h1>$title</h1></div>\n"
    else
        return "<div class=\"franklin-content\"><h1>$title <span class=\"header-date\">$date</span></h1></div>\n"
    end
end

function hfun_posts(params=["blog", "0"])
    base = params[1]
    nposts = length(params) > 1 ? parse(Int, params[2]) : 0
    io = IOBuffer()
    posts = reverse(filter!(p -> endswith(p, ".md"), readdir(base, sort=true)))
    if nposts > 0
        posts = Iterators.take(posts, nposts)
    end
    for post in posts
        ps  = splitext(post)[1]
        url = "/$base/$ps/"
        surl = strip(url, '/')
        title = pagevar(surl, :title)
        pubdate = pagevar(surl, :published)
        write(io, "- [$title]($url) ($pubdate)\n")
    end
    return Franklin.fd2html(String(take!(io)), internal=true)
end

ispage(page::Regex) = match(page, locvar("fd_url")) !== nothing ? true : false
ispage(page::String) = page == locvar("fd_url")

function hfun_navitem(params)
    base_surl = strip(params[1], '/')
    base_url = '/'*base_surl*'/'
    base_title = pagevar(base_surl, :shorttitle)
    if base_title === nothing
        base_title = pagevar(base_surl, :title)
        if base_title === nothing
            return ""
        end
    end
    active = ispage("$(base_url)index.html") ? " active" : ""
    base_item = "<a class=\"sidebar-nav-item$active\" href=\"$base_url\">$base_title</a>"
    if ispage(Regex("$(base_url).*")) && isdir(base_surl)
        pages = filter!(p -> endswith(p, ".md"), readdir(base_surl, sort=true))
        pageitems = String[]
        for page in pages
            ps = splitext(page)[1]
            url = "/$base_surl/$ps/"
            surl = "$base_surl/$ps"
            title = pagevar(surl, :shorttitle)
            if title === nothing
                title = pagevar(surl, :title)
                if title === nothing
                    continue
                end
            end
            active = ispage("$(url)index.html") ? " style=\"font-weight:bold;\"" : ""
            push!(pageitems, "<li><a$active href=\"$url\">$title</a></li>")
        end
        if !isempty(pageitems)
            return base_item*"\n<ul style=\"margin-bottom: 0px; list-style-position: inside;\">\n"*join(pageitems, "\n")*"\n</ul>"
        else
            return base_item
        end
    else
        return base_item
    end
end
