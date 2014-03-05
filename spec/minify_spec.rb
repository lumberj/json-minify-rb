require 'json_minify'
require 'rspec/autorun'

describe MultiJson do
  describe "::minify" do
    it "removes whitespace from JSON" do
      expect(MultiJson.minify("{ }")).to eql("{}")
      expect(MultiJson.minify(%Q<{"foo": "bar"\n}\n>)).to eql(%Q<{"foo":"bar"}>)
    end

    it "removes comments from JSON" do
      expect(MultiJson.minify("{ /* foo */ } /* bar */")).to eql("{}")
      expect(MultiJson.minify(%Q<{"foo": "bar"\n}\n // this is a comment>)).to eql(%Q<{"foo":"bar"}>)
    end

    it "throws a SyntaxError on invalid JSON" do
      expect { MultiJson.minify("{ /* foo */ } /* bar ") }.to raise_error(SyntaxError)
      expect { MultiJson.minify(%Q<{ "foo": new Date(1023) }>) }.to raise_error(SyntaxError)
    end

    it "copes with the example from https://github.com/getify/JsonMinify.minify" do
      expect(MultiJson.minify( %Q'{ /* comment */ "foo": 42 \n }' )).to eql('{"foo":42}')
    end
  end


  describe "::load" do
    context "with :minify option" do
      let(:opts) { {minify: true, symbolize_keys: true} }

      it "removes whitespace from JSON" do
        expect(MultiJson.load("{ }", opts)).to eq({})
        expect(MultiJson.load(%Q<{"foo": "bar"\n}\n>, opts)).to eq({foo:"bar"})
      end

      it "removes comments from JSON" do
        expect(MultiJson.load("{ /* foo */ } /* bar */", opts)).to eq({})
        expect(MultiJson.load(%Q<{"foo": "bar"\n}\n // this is a comment>, opts)).to eq({foo:"bar"})
      end

      it "throws a SyntaxError on invalid JSON" do
        expect { MultiJson.load("{ /* foo */ } /* bar ", opts) }.to raise_error(SyntaxError)
        expect { MultiJson.load(%Q<{ "foo": new Date(1023) }>, opts) }.to raise_error(SyntaxError)
      end

      it "copes with the example from https://github.com/getify/JsonMinify.load" do
        expect(MultiJson.load( %Q'{ /* comment */ "foo": 42 \n }' , opts)).to eq({foo:42})
      end
    end
  end
end
