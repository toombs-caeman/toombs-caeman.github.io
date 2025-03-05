#!/usr/bin/env python
import http.server
import socketserver

PORT = 8080

Handler = http.server.SimpleHTTPRequestHandler

Handler.extensions_map={
    '.html': 'text/html',
    '': 'text/html', # Default is 'application/octet-stream'
    }

print(f"http://localhost:{PORT}/")
httpd = socketserver.TCPServer(("", PORT), Handler)

httpd.serve_forever()
