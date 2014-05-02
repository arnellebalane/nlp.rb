class PorterStemmer

  def self.stem(word)
    word = step_1a(word)
    word = step_1b(word)
    word = step_1c(word)
    word = step_2(word)
    word
  end

  private

    def self.step_1a(word)
      if word.match(/sses$/)
        return word.gsub(/sses$/, "ss")
      elsif word.match(/ies$/)
        return word.gsub(/ies$/, "i")
      elsif word.match(/ss$/)
        return word.gsub(/ss$/, "ss")
      elsif word.match(/s$/)
        return word.gsub(/s$/, "")
      end
      return word
    end

    def self.step_1b(word)
      if word.match(/eed$/)
        word = word.gsub(/eed$/, "ee") if word.stem("eed").m > 0
        return word
      elsif word.match(/ed$/)
        if word.stem("ed").has_vowel?
          word = word.gsub(/ed$/, "")
          special = true
        else
          return word
        end
      elsif !special and word.match(/ing$/)
        if word.stem("ing").has_vowel?
          word = word.gsub(/ing$/, "")
          special = true
        else
          return word
        end
      end

      if special
        if word.match(/at$/)
          return word.gsub(/at$/, "ate")
        elsif word.match(/bl$/)
          return word.gsub(/bl$/, "ble")
        elsif word.match(/iz$/)
          return word.gsub(/iz$/, "ize")
        elsif word.ends_with_double_consonant? and !word.match(/[lsz]$/)
          return word = word[0...-1]
        elsif word.m == 1 and word.ends_with_cvc?
          return word = word + "e"
        end
      end
      return word
    end

    def self.step_1c(word)
      if word.match(/y$/)
        return word.gsub(/y$/, "i") if word.stem("y").has_vowel?
      end
      return word
    end

    def self.step_2(word)
      if word.match(/ational$/)
        return word.gsub(/ational$/, "ate") if word.stem("ational").m > 0
      elsif word.match(/tional$/)
        return word.gsub(/tional$/, "tion") if word.stem("tional").m > 0
      elsif word.match(/enci$/)
        return word.gsub(/enci$/, "ence") if word.stem("enci").m > 0
      elsif word.match(/anci$/)
        return word.gsub(/anci$/, "ance") if word.stem("anci").m > 0
      elsif word.match(/izer$/)
        return word.gsub(/izer$/, "ize") if word.stem("izer").m > 0
      elsif word.match(/abli$/)
        return word.gsub(/abli$/, "able") if word.stem("abli").m > 0
      elsif word.match(/alli$/)
        return word.gsub(/alli$/, "al") if word.stem("alli").m > 0
      elsif word.match(/entli$/)
        return word.gsub(/entli$/, "ent") if word.stem("entli").m > 0
      elsif word.match(/eli$/)
        return word.gsub(/eli$/, "e") if word.stem("eli").m > 0
      elsif word.match(/ousli$/)
        return word.gsub(/ousli$/, "ous") if word.stem("ousli").m > 0
      elsif word.match(/ization$/)
        return word.gsub(/ization$/, "ize") if word.stem("ization").m > 0
      elsif word.match(/ation$/)
        return word.gsub(/ation$/, "ate") if word.stem("ation").m > 0
      elsif word.match(/ator$/)
        return word.gsub(/ator$/, "ate") if word.stem("ator").m > 0
      elsif word.match(/alism$/)
        return word.gsub(/alism$/, "al") if word.stem("alism").m > 0
      elsif word.match(/iveness$/)
        return word.gsub(/iveness$/, "ive") if word.stem("iveness").m > 0
      elsif word.match(/fulness$/)
        return word.gsub(/fulness$/, "ful") if word.stem("fulness").m > 0
      elsif word.match(/ousness$/)
        return word.gsub(/ousness$/, "ous") if word.stem("ousness").m > 0
      elsif word.match(/aliti$/)
        return word.gsub(/aliti$/, "al") if word.stem("aliti").m > 0
      elsif word.match(/iviti$/)
        return word.gsub(/iviti$/, "ive") if word.stem("iviti").m > 0
      elsif word.match(/biliti$/)
        return word.gsub(/biliti$/, "ble") if word.stem("biliti").m > 0
      end
      return word
    end

end



class String
  # extended String class to add some 
  # helper methods to string objects

  def form(compress = true)
    word = self.gsub(/[aeiou]/, "`")
    word = word.gsub(/[a-z^aeiou]y/, "b`")
    word = word.gsub(/[a-z^aeiou]/, "~")
    return word.gsub(/`+/, "v").gsub(/~+/, "c") if compress
    word.gsub(/`/, "v").gsub(/~/, "c")
  end

  def m
    self.form.scan(/vc/).size
  end

  def stem(suffix)
    if self.match(/#{suffix}$/)
      return self.gsub(/#{suffix}$/, "")
    end
    self
  end

  def has_vowel?
    !!self.match(/[aeiou]/)
  end

  def ends_with?(string)
    !!self.match(/#{string}$/)
  end

  def ends_with_double_consonant?
    !!self.match(/[^aeiou]{2}$/) and self[-1] == self[-2]
  end

  def ends_with_cvc?
    !!self.form(false).match(/cvc$/) and !self[-1].match(/[wxy]/)
  end

end



words = %w{caresses ponies ties caress cats feed agreed plastered bled motoring sing conflated troubled 
            sized hopping tanned falling hissing fizzing failing filing happy sky relational conditional
            rational valenci hesitanci digitizer conformabli radicalli differentli vileli analogousli
            vietnamization predication operator feudalism decisiveness hopefulness callousness formaliti
            sensitiviti sensibiliti}

words.each do |word|
  p PorterStemmer.stem(word)
end