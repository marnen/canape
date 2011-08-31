# Field syntax as in Pickle -- field1: "data", field2: "data"
Given /^a page exists with ([^\s:]+: "[^"]*"(?:, (?:[^\s:]+: "[^"]*"))*)$/ do |fields|
  fields = fields.split ', '
  record = {:type => 'page'}
  fields.each do |field|
    k, v = field.split ': '
    v.chomp!(?").gsub!(%r{\A"}, '')
    if k == 'slug'
      k = '_id'
    end
    record[k] = v
  end
  
  couch.put "#{database}/#{record['_id']}", Yajl::Encoder.encode(record)
end