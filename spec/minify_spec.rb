require 'json_minify'
require 'rspec/autorun'

describe JsonMinify do
  it "should remove whitespace from MultiJson" do
    expect(MultiJson.minify("{ }")).to eql("{}")
    expect(MultiJson.minify(%Q<{"foo": "bar"\n}\n>)).to eql(%Q<{"foo":"bar"}>)
  end

  it "should remove comments from MultiJson" do
    expect(MultiJson.minify("{ /* foo */ } /* bar */")).to eql("{}")
    expect(MultiJson.minify(%Q<{"foo": "bar"\n}\n // this is a comment>)).to eql(%Q<{"foo":"bar"}>)
  end

  it "should throw a SyntaxError on invalid MultiJson" do
    expect { MultiJson.minify("{ /* foo */ } /* bar ") }.to raise_error(SyntaxError)
    expect { MultiJson.minify(%Q<{ "foo": new Date(1023) }>) }.to raise_error(SyntaxError)
  end

  it "should cope with the example from https://github.com/getify/MultiJson.minify" do
    expect(MultiJson.minify( %Q'{ /* comment */ "foo": 42 \n }' )).to eql('{"foo":42}')
  end
end
