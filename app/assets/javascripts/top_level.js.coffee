# set the pageIdentifyer variable
# allowing me to specify with JS gets loaded per page
path = window.location.pathname.substring(1)
ary = path.split("/")
window.pathAry = ary

# if $.inArray("file-focus", pathAry) >= 0