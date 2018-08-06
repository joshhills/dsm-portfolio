module Jekyll
    class TestTag < Liquid::Tag
      def initialize(tag_name, markup, tokens)
        super
        
        markup.scan(Liquid::TagAttributes) do |key, value|
          if key == "filePath"
            @renderUsingContext = true
            @filePath = value.gsub(/^'|"/, '').gsub(/'|"$/, '')
          end
        end

        if !@filePath
            @filePath = markup.strip
        end
      end
  
      def render(context)
        if @renderUsingContext == true
          context[@filePath]
        else
          @filePath
        end
      end
    end
  end
  
  Liquid::Template.register_tag('test', Jekyll::TestTag)