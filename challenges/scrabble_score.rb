require 'minitest/autorun'

class Scrabble
  LETTER_VALUES = { %w[a e i o u l n r s t] => 1,
                    %w[d g] => 2,
                    %w[b c m p] => 3,
                    %w[f h v w y] => 4,
                    %w[k] => 5,
                    %w[j x] => 8,
                    %w[q z] => 10 }

  attr_reader :string

  def initialize(string)
    @string = string
  end

  def self.score(string)
    return 0 if string.nil? || string.empty?

    string.downcase.chars.map do |char|
      points = 0

      LETTER_VALUES.each do |chars, value|
        points = value if chars.include?(char)
      end
      points
    end.reduce(&:+)
  end

  def score
    self.class.score(string)
  end
end

class ScrabbleTest < Minitest::Test
  def test_empty_word_scores_zero
    assert_equal 0, Scrabble.new('').score
  end

  def test_whitespace_scores_zero
    assert_equal 0, Scrabble.new(" \t\n").score
  end

  def test_nil_scores_zero
    assert_equal 0, Scrabble.new(nil).score
  end

  def test_scores_very_short_word
    assert_equal 1, Scrabble.new('a').score
  end

  def test_scores_other_very_short_word
    assert_equal 4, Scrabble.new('f').score
  end

  def test_simple_word_scores_the_number_of_letters
    assert_equal 6, Scrabble.new('street').score
  end

  def test_complicated_word_scores_more
    assert_equal 22, Scrabble.new('quirky').score
  end

  def test_scores_are_case_insensitive
    assert_equal 41, Scrabble.new('OXYPHENBUTAZONE').score
  end

  def test_convenient_scoring
    assert_equal 13, Scrabble.score('alacrity')
  end
end
