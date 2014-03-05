# JsonMinify

JSON.minify implementation - rationale is here: https://github.com/getify/JSON.minify

> Though comments are not officially part of the JSON standard, this post from
> Douglas Crockford back in late 2005 helps explain the motivation behind this project.
>
> http://tech.groups.yahoo.com/group/json/message/152
>
> "A JSON encoder MUST NOT output comments. A JSON decoder MAY accept and ignore comments."


## Installation

Add this line to your application's Gemfile:

    gem 'json_minify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json_minify

## Usage

Use with MultiJson,

    MultiJson.minify("{ }") #=> "{}"

    MultiJson.minify("{ /* comment */ }") #=> "{}"


Use on the command-line:

    $ cat file.json | json_minify

    $ json_minify file.json
    $ json_minify file.json --pretty-print

    $ json_minify --help
    $ json_minify --version

## Contributing

1. Fork it (https://github.com/lumberj/json-minify-rb)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
