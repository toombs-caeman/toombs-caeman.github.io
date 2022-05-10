#!/usr/bin/env python3
import os  # https://docs.python.org/3/library/os.html
import datetime  # https://docs.python.org/3/library/datetime.html
import markdown  # https://python-markdown.github.io/
import chevron  # http://mustache.github.io/mustache.5.html
import argparse  # https://docs.python.org/3/library/argparse.html
from flask import Flask, abort  # https://flask.palletsprojects.com/en/2.1.x/

"""
KISS:
* no frontmatter
* file extension based layouts
* single python file implementation
* file name -> page name
* low/no javascript

TODO
* insert self as git pre-commit hook
* get git file timestamps 
* autolink between pages that reference the title of a post
* minify css
"""

src_root = 'content'
bin_root = 'site'
layouts = {
    '.md': 'markdown.ms'
}


def site_data():
    pages = []
    for dirpath, _, filenames in os.walk(src_root):
        for f in filenames:
            src = os.path.join(os.path.relpath(dirpath, src_root), f)
            if src.startswith('./'):  # src.removeprefix('./') # python >= 3.9
                src = src[2:]
            dest, ext = os.path.splitext(src)
            layout = layouts.get(ext)
            if not layout:
                dest = src
            pages.append(
                {
                    'title': os.path.splitext(f)[0].replace('_', ' ').title(),
                    'layout': layout,
                    'src': src,
                    'dest': dest,
                    'created': 'some when',  # TODO file creation time (according to git?)
                    'updated': 'some when',  # TODO file update time (touch)
                }
            )
    site = {
        p['src']: p for p in pages
    }
    extra = {
        'site': site,
        'pages': pages,
        'rendered': datetime.datetime.now().isoformat(),
        # add site functions here with signature `(text:str, render:Callable)->str`
        # where render is a chevron.render partial function
        'markdown': lambda text, render: markdown.markdown(render(text)),
    }
    site.update(extra)
    for p in pages:
        p.update(extra)
    return site


def render_page(page, write=True):
    if page['layout']:
        with open(page['layout'], 'r') as fd:
            layout = fd.read()
    else:
        layout = '{{> content}}'

    src = os.path.join(src_root, page['src'])
    dest = os.path.join(bin_root, page['dest'])

    with open(src, 'r') as fd:
        content = fd.read()

    final = chevron.render(layout, data=page, partials_dict={'content': content})
    if write:
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, 'w') as f:
            f.write(final)
    return final


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='A basic static site generator')
    parser.add_argument('--serve', action='store_true', help='serve site locally')
    args = parser.parse_args()
    if args.serve:
        app = Flask(__name__)
        @app.route('/', defaults={'path': ''})
        @app.route('/<path:path>')
        def get_dir(path):
            print(path)
            if os.path.isdir(os.path.join(bin_root, path)):
                path = os.path.join(path, 'index.html')
            print(path)
            for page in site_data()['pages']:
                if page['dest'] == path:
                    return render_page(page, False)
            abort(404)
        app.run(debug=True)
    else:
        # TODO clear out site before writing
        for page in site_data()['pages']:
            render_page(page)