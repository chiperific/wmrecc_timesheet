# Warning, this file is referenced first in the head, outside of the asset pipeline.
# Libraries like jQuery have not yet been loaded at the time of execution.

# set the pageIdentifyer variable
# allowing me to specify with JS gets loaded per page
path = window.location.pathname.substring(1)
ary = path.split("/")
window.pathAry = ary

# Usage: if $.inArray("file-focus", pathAry) >= 0