#!/sbin/nu
# TODO pre-commit hook
# TODO h1 needs ids for 'jump to header'??
# TODO support blog series? as a way to link together
# TODO support sidenotes?
# TODO codeblocks with links to originating file?

let default_options = { layout: default.html }

# render all files in src/
def main [] {
    cd (git rev-parse --show-toplevel)
    glob -D src/** | each {|f| main render $f }
    ignore
}

# watch files for changes and update on write
def 'main watch' [] {
    cd (git rev-parse --show-toplevel)
    watch src/ {|op path new_path|
        match $op {
            Rename => {
                rm ($path | dest)
                main render $new_path
            }
            Remove => {
                # nvim writes are reported as create then remove rather than write for some reason
                if ($path | path parse).extension != 'md~' {
                    rm -f ($path | dest) }
            }
            _ => { main render $path }
        }
    }
}

# get the output destination from the source file name
def dest [] {
    # as a special case, index should keep the extension
    $in | path relative-to ('./src' | path expand) |
        path parse | update extension (
            if ($in.stem == 'index') { 'html' } else { '' }
        ) | path join
}

# pacman -S mustach
def mu [template] { $in | to json | mustach - $template }
def md [] {
    # pacman -S md4c
    $in | md2html --github | # render markdown
        str replace -ar 'href="([^"]*)\.md"' 'href="$1"' # convert internal links md => html
}

# render a single source file
def 'main render' [file] {
        let dest = $file | dest
        print $"($file) => ($dest)"
        mut content = open -r $file
        mut options = $default_options

        if ($content =~ "---\n.*") {
            let split = $content | lines | split list '---'
            if ($split | length) > 1 {
                $options = $options | merge ($split.0 | str join "\n" | from yaml)
                $content = $split | skip | flatten --all | str join "\n"
            } 
            # TODO special handling of metadata
        }
        mkdir ($dest | path dirname)
        $options | insert content ($content | md) | mu ( './inc' | path join $options.layout) | save -f $dest

}

def 'main serve' [] { cd (git rev-parse --show-toplevel); bin/serve.py }

# remove build artifacts
def 'main clean' [] {
    cd (git rev-parse --show-toplevel)
    rm -r ...(glob * -Fe [src inc bin .git])
    rm ...(glob * -De [($env.CURRENT_FILE | path basename) .gitignore])
}
