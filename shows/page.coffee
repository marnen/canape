# !code vendor/milk.coffee
(doc, req) ->
  `
    // !json templates.page
  `
  {body: Milk.render(templates.page, doc)}