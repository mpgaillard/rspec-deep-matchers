## Rspec Deep Matchers
Matchers that allows deep search within hashes. Simply include the code in deep_matchers.rb in your spec helper file. Will turn it to a gem in the future if necessary. Use this matcher carefully if there are multiple places in a deeply nested JSON object for example there can be a match.

# Example
```bash
json_message = { 'somewhere' => [ { 'something' => 'incredible' }, { 'is' => 'waiting', 'to' => ['be', 'known'] } ],
'milky' => 'way' }

expect(json_message).to include_deeply('milky' => 'way', 'to' => ['be', 'known'], 'an' => ['dromeda'])
```

#Coming In the Near Future
Search for single item within array(no need for key)
```bash
expect(JSON.parse(message)).to include_deeply('dromeda')
```
Search within another hash
```bash
expect(JSON.parse(message)).to include_deeply('something' => 'incredible').within('somewhere')
```
