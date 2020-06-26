html() {
    local tag=$1; shift
    local id
    local class=()
    local attrs=()
    local content=()
    for i in $*; do
        shift; [[ "$i" == "--" ]] && break; content+=("$i")
    done
    # process attributes
    for a in $*; do
        case $a in
            \.*) class+=("${a#.}") ;;
            @*) id="${a#@}" ;;
            *=*) attrs+=("${a/=/"='"}'") ;;
            *) attrs+=("$a") ;;
        esac
    done
    # output
    echo "<$tag${id:+ id="$id"}${class[0]:+ class="${class[@]}"}${attrs[0]:+ ${attrs[@]}}>${content[@]}"
}
# generate html tag functions
for tag in div ol hr ul li p head header footer span title meta h{1..5}; do
    eval "$tag() { html $tag \$*; }; /$tag() { echo -n '</$tag>'; }"
done
for tag in a link; do
    eval "$tag() { local href=\$1; shift; html $tag \$* -- href=\"\$href\"; }; /$tag() { echo -n '</$tag>'; }"
done
