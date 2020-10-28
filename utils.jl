using Dates

hfun_datetext(date=locvar("published")) = Dates.format(date, dateformat"yyyy-mm-dd")

function hfun_posts(base="posts")
    io = IOBuffer()
    posts = filter!(p -> endswith(p, ".md"), readdir(base, sort=true))
    for post in reverse(posts)
        ps  = splitext(post)[1]
        url = "/$base/$ps/"
        surl = strip(url, '/')
        title = pagevar(surl, :title)
        pubdate = pagevar(surl, :published)
        write(io, "- [$title]($url) ($pubdate)\n")
    end
    return Franklin.fd2html(String(take!(io)), internal=true)
end
