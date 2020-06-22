#!/usr/bin/env python3
import markdown
from os import path, walk, makedirs, remove

from jinja2 import Environment, FileSystemLoader

# CONFIG
template_dir = 'templates'
content_dir = 'content'
render_dir = 'site'
static_dir = 'static'
SITE_CONFIG = {
    "title": "Caeman Toombs",
    "email": "toombs.caeman@gmail.com",
    "github_username": "toombs-caeman",
    "description": "Just trying things out.",
    "template_dir": template_dir,
    "content_dir": content_dir,
    "render_dir": render_dir,
    "static_dir": static_dir,
}

# RENDER


def lsR(PATH):
    for dp, dn, filenames in walk(PATH):
        for f in filenames:
            yield path.join(dp, f)

def render():
    env = Environment(loader=FileSystemLoader(template_dir))
    md = markdown.Markdown(extensions=['meta'])

    # delete old content
    for file in lsR(render_dir):
        remove(file)

    # create name mapping
    name_map = {}
    for file in lsR(content_dir):
        sp = path.split(file)
        new_file = path.join(render_dir, *sp[1:-1], sp[-1].replace(".md", ".html"))
        name_map[file] = new_file
        # make sure the directories exist
        makedirs(
            path.join(*path.split(new_file)[:-1]),
            exist_ok=True,
        )

    # render markdown content
    for file, new_file in name_map.items():
        with open(file, 'r') as source:
            with open(new_file, 'w') as out:
                print('converting', path.split(new_file)[-1])
                html = md.convert(source.read())
                meta = md.Meta
                layout = meta.get("layout", ["default.html"])[0]
                template = env.get_template(layout)
                data = {
                    'site':SITE_CONFIG,
                    'page':meta,
                }
                out.write(
                    template.render(
                        {
                            'content':env.from_string(html).render(data),
                            **data,
                        }
                    )
                )




def serve():
    from flask import Flask, redirect
    # set the project root directory as the static folder, you can set others.
    app = Flask(__name__, static_url_path='', static_folder='')
    app.route('/')(lambda :redirect('/index.html'))
    app.run()

if __name__ == "__main__":
    import sys
    render()
    if len(sys.argv) > 1 and sys.argv[1] == 'serve':
        serve()


