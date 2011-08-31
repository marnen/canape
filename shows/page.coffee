(doc, req) ->
  body: """
    <html>
      <head>
        <title>#{doc.title}</title>
      </head>
      <body>#{doc.content}</body>
    </html>
  """