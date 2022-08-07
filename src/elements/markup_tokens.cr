module Chitra
  struct MarkupTag
    property name = "", opentag = ""

    def closetag
      "</#{@name}>"
    end
  end

  class MarkupTokens
    include Iterator(Tuple(String, String))

    def initialize(@raw_text : String, @markup = false)
      @open_tags = [] of MarkupTag
      @tokens = [] of String
      @count = @tokens.size
      @idx = -1
      tokenize
    end

    def full
      @raw_text
    end

    def tokenize
      tag_started = false
      token = ""
      @raw_text.split("").each do |letter|
        token += letter

        if letter == "<"
          tag_started = true
        elsif tag_started && letter == ">"
          tag_started = false
          @tokens << token
          token = ""
        elsif !tag_started && (letter == " " || letter == "\n")
          @tokens << token
          token = ""
        end
      end
      @tokens << token if token != ""
      @count = @tokens.size
    end

    def parse_word(word)
      data = word.scan(/<\/?[^>]*>/m)

      data.each do |d|
        if d[0].starts_with?("</")
          @open_tags.pop
        else
          tag = MarkupTag.new
          tag.name = d[0].split(" ")[0].sub("<", "").sub(">", "")
          tag.opentag = d[0]
          @open_tags << tag
        end
      end
    end

    def close_tags
      outstr = ""
      @open_tags.reverse_each do |tag|
        outstr += tag.closetag
      end
      outstr
    end

    def open_tags
      (@open_tags.map &.opentag).join
    end

    def next
      if @idx < (@count - 1) && @count > 0
        @idx += 1

        # If it is markup tag then include atleast one more word
        word = ""
        loop do
          break if @idx == @count

          word += @tokens[@idx]
          if @tokens[@idx].starts_with?("<") && @tokens[@idx][1] != "/"
            @idx += 1
          else
            break
          end
        end

        stop if word == ""

        parse_word(word)
        {
          @tokens[0..@idx].join.rstrip + close_tags,
          open_tags + @tokens[@idx + 1..-1].join,
        }
      else
        stop
      end
    end
  end
end
