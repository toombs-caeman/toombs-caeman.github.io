#!/usr/bin/env python3
from datetime import datetime

import markdown
from os import path, walk, makedirs, remove

from jinja2 import Environment, FileSystemLoader

# CONFIG
config_file = 'config.txt'
template_dir = 'templates'
content_dir = 'content'
render_dir = 'site'
static_dir = 'static'

def lsR(p):
    for dp, dn, filenames in walk(p):
        for f in filenames:
            if path.splitext(f)[-1] == '.txt':
                yield path.join(dp, f)

def date_to_rfc822(date):
    if isinstance(date, str):
        date = datetime.strptime(date, '%Y-%m-%d')
    ctime = date.ctime()
    return (f'{ctime[0:3]}, {date.day:02d} {ctime[4:7]}'
            + date.strftime(' %Y 00:00:00 %z'))

def render():
    env = Environment(loader=FileSystemLoader(template_dir))
    env.filters['date_to_rfc822'] = date_to_rfc822
    md = markdown.Markdown(extensions=['meta'])
    with open(config_file, 'r') as conf:
        md.convert(conf.read())
    SITE_CONFIG = {
        "date": datetime.today(),
        "template_dir": template_dir,
        "content_dir": content_dir,
        "render_dir": render_dir,
        "static_dir": static_dir,
        **{k:"\n".join(v) for k, v in md.Meta.items()},

    }

    # delete old content
    for file in lsR(render_dir):
        remove(file)

    # create name mapping
    name_map = {}
    for file in lsR(content_dir):
        sp = path.split(file)
        new_file = file.replace(content_dir, render_dir, 1).replace(".txt", ".html", 1)
        name_map[file] = new_file
        # make sure the directories exist
        makedirs(
            path.split(new_file)[0],
            exist_ok=True,
        )
    print(name_map)

    # convert raw markdown and collect site map
    pages = {}
    for file, new_file in name_map.items():
        with open(file, 'r') as source:
            print('processing', file)
            txt = source.read()
            html = md.convert(txt)
            meta = {k: "\n".join(v) for k, v in md.Meta.items()}
            meta.update(origin=file, url=new_file)
            if 'textonly' in meta:
                new_file = new_file.replace('.html', '.txt')
                html = txt
            pages[new_file] = (html, meta)
    pages = sorted(pages.items())
    SITE_CONFIG['pages'] = [(k, v[1]) for k, v in pages]

    # render final output
    for new_file, contents in pages:
        html, meta = contents
        layout = meta.get('layout')
        template = None
        if layout:
            template = env.get_template(meta.get("layout"))
        with open(new_file, 'w') as out:
            data = {
                'site': SITE_CONFIG,
                'page': meta,
            }
            content = env.from_string(html).render(data)
            if template:
                content = template.render({
                    'content': content,
                    **data,
                })
            out.write(content)


def serve():
    from flask import Flask, redirect
    # set the project root directory as the static folder, you can set others.
    app = Flask(__name__, static_url_path='', static_folder='')
    app.route('/')(lambda: redirect('/index.html'))
    app.run()


if __name__ == "__main__":
    import sys

    render()
    if len(sys.argv) > 1 and sys.argv[1] == 'serve':
        serve()
