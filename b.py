#!/usr/bin/env python3
import re
from subprocess import run
pages = [] # TODO collect pages
pages = {
    dict(
        # TODO set correct metadata
        title=page,
        file=page,
        url=page,
        date=page,
        layout='default',
        link=[],
        content=page,
    )
    for page in pages
}
# TODO load metadata
cases = {
    k: (re.compile(v[0]), v[1])
    for k,v in dict(
        ul=('^( *[-*] .*?)$$(?m)', '<ul>\1</ul>'), # TODO lists separately
        b=(r'\*\*((\*[^*]|[^*])*)\*\*', r'<b>\1</b>'),
        em=(r'\*([^*]*)\*', r'<em>\1</em>'),
        h=(r'^(#+)([^|]*)\|?(.*)$', lambda M: f'<h{len(M[1])} {M[3]}>{M[2]}</h{len(M[1])}>'),
        hr=('^---+$', '<hr>'),
        p=('(?m)^$', '<p>'),
        # images, internal links and external links are all very similar matches
        img=(r'!\[ *([^]|]*) *\|? *([^]]*)\]\(([^)]*)\)', r'<img src="\3" alt="\1" title="\1" \2>'),
        # TODO internal 'link' should use url metadata
        link=(r'\[ *([^]|]*)? *\|? *([^]]*)\]\(/([^)]*)\)', r'<a href="\3" \2>(?(1)\1|\3)</a>'),
        a=(   r'\[ *([^]|]*)? *\|? *([^]]*)\]\(([^)]*)\)',  r'<a href="\3" \2>(?(1)\1|\3)</a>'),
    ).items()
}
matcher = '|'.join(f'(?P<{n}>{p.pattern})' for n, (p, _) in cases.items())
# print(matcher)
matcher = re.compile(matcher)


def replace(match):
    x = []
    # for case, body in match.groupdict().items():  # should only match one
    #     if body is not None:
    #         r.append(patterns[case].sub(replacements[case], body))
    for n, (p, r) in cases.items():
        if match[n] is not None:
            x.append(p.sub(r, match[n]))
    # print(x)
    return ''.join(x)

sample = """
# header | #meta
* list 1
* list 2


that's *a* **bold** *move* cotton.
 
 
---
![it's a picture| .meta](/at/here.jpg)
"""
print(sample)
print("=========")
print(matcher.sub(replace, sample))
left = sample
while True:
    right = matcher.sub(replace, sample)
    if left == right:
        break
    left = right