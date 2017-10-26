require 'minitest/autorun'

class PigLatin
  def self.translate(string)
    words = string.split

    words.map do |word|
      if word[0].match(/[aeiou]/) || word[0, 2].match(/y[^aeiou]|xr/)
        word + 'ay'
      else
        slice = word.match(/[^aeiou]+u?/).to_s
        remainder = word.sub(slice, '')

        unless remainder[0].match(/[aeiou]/)
          slice = word.match(/[^aeiou]+/).to_s
          remainder = word.sub(slice, '')
        end
        
        remainder + slice + 'ay'
      end
    end.join(' ')
  end
end

class PigLatinTest < Minitest::Test
  def test_word_beginning_with_a
    assert_equal 'appleay', PigLatin.translate('apple')
  end

  def test_other_word_beginning_e
    assert_equal 'earay', PigLatin.translate('ear')
  end

  def test_word_beginning_with_p
    assert_equal 'igpay', PigLatin.translate('pig')
  end

  def test_word_beginning_with_k
    assert_equal 'oalakay', PigLatin.translate('koala')
  end

  def test_word_beginning_with_ch
    assert_equal 'airchay', PigLatin.translate('chair')
  end

  def test_word_beginning_with_qu
    assert_equal 'eenquay', PigLatin.translate('queen')
  end

  def test_word_with_consonant_preceding_qu
    assert_equal 'aresquay', PigLatin.translate('square')
  end

  def test_word_beginning_with_th
    assert_equal 'erapythay', PigLatin.translate('therapy')
  end

  def test_word_beginning_with_thr
    assert_equal 'ushthray', PigLatin.translate('thrush')
  end

  def test_word_beginning_with_sch
    assert_equal 'oolschay', PigLatin.translate('school')
  end

  def test_translates_phrase
    assert_equal 'ickquay astfay unray', PigLatin.translate('quick fast run')
  end

  def test_word_beginning_with_ye
    assert_equal 'ellowyay', PigLatin.translate('yellow')
  end

  def test_word_beginning_with_yt
    assert_equal 'yttriaay', PigLatin.translate('yttria')
  end

  def test_word_beginning_with_xe
    assert_equal 'enonxay', PigLatin.translate('xenon')
  end

  def test_word_beginning_with_xr
    assert_equal 'xrayay', PigLatin.translate('xray')
  end
end
