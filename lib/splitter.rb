# frozen_string_literal: true

require 'English'

class Splitter
  def initialize(sep: nil)
    @sep =
      case sep
      in :blank_line
        [$INPUT_RECORD_SEPARATOR + $INPUT_RECORD_SEPARATOR]
      in :space
        []
      in :eol
        [$INPUT_RECORD_SEPARATOR]
      end
  end

  def split(data) = data.split(*@sep)
end
