class PorterStemmer

  def self.stem(word)
    word = step_1a(word)
    word = step_1b(word)
    word = step_1c(word)
    word = step_2(word)
    word = step_3(word)
    word = step_4(word)
    word = step_5a(word)
    word = step_5b(word)
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

    def self.step_3(word)
      if word.match(/icate$/)
        return word.gsub(/icate$/, "ic") if word.stem("icate").m > 0
      elsif word.match(/ative$/)
        return word.gsub(/ative$/, "") if word.stem("ative").m > 0
      elsif word.match(/alize$/)
        return word.gsub(/alize$/, "al") if word.stem("alize").m > 0
      elsif word.match(/iciti$/)
        return word.gsub(/iciti$/, "ic") if word.stem("iciti").m > 0
      elsif word.match(/ical$/)
        return word.gsub(/ical$/, "ic") if word.stem("ical").m > 0
      elsif word.match(/ful$/)
        return word.gsub(/ful$/, "") if word.stem("ful").m > 0
      elsif word.match(/ness$/)
        return word.gsub(/ness$/, "") if word.stem("ness").m > 0
      end
      return word
    end

    def self.step_4(word)
      if word.match(/al$/)
        return word.gsub(/al$/, "") if word.stem("al").m > 1
      elsif word.match(/ance$/)
        return word.gsub(/ance$/, "") if word.stem("ance").m > 1
      elsif word.match(/ence$/)
        return word.gsub(/ence$/, "") if word.stem("ence").m > 1
      elsif word.match(/er$/)
        return word.gsub(/er$/, "") if word.stem("er").m > 1
      elsif word.match(/ic$/)
        return word.gsub(/ic$/, "") if word.stem("ic").m > 1
      elsif word.match(/able$/)
        return word.gsub(/able$/, "") if word.stem("able").m > 1
      elsif word.match(/ible$/)
        return word.gsub(/ible$/, "") if word.stem("ible").m > 1
      elsif word.match(/ant$/)
        return word.gsub(/ant$/, "") if word.stem("ant").m > 1
      elsif word.match(/ement$/)
        return word.gsub(/ement$/, "") if word.stem("ement").m > 1
      elsif word.match(/ment$/)
        return word.gsub(/ment$/, "") if word.stem("ment").m > 1
      elsif word.match(/ent$/)
        return word.gsub(/ent$/, "") if word.stem("ent").m > 1
      elsif word.match(/ion$/)
        return word.gsub(/ion$/, "") if word.stem("ion").m > 1 and word.stem("ion").match(/[st]$/)
      elsif word.match(/ou$/)
        return word.gsub(/ou$/, "") if word.stem("ou").m > 1
      elsif word.match(/ism$/)
        return word.gsub(/ism$/, "") if word.stem("ism").m > 1
      elsif word.match(/ate$/)
        return word.gsub(/ate$/, "") if word.stem("ate").m > 1
      elsif word.match(/iti$/)
        return word.gsub(/iti$/, "") if word.stem("iti").m > 1
      elsif word.match(/ous$/)
        return word.gsub(/ous$/, "") if word.stem("ous").m > 1
      elsif word.match(/ive$/)
        return word.gsub(/ive$/, "") if word.stem("ive").m > 1
      elsif word.match(/ize$/)
        return word.gsub(/ize$/, "") if word.stem("ize").m > 1
      end
      return word
    end

    def self.step_5a(word)
      if word.match(/e$/)
        if word.stem("e").m > 1
          return word.gsub(/e$/, "")
        elsif word.stem("e").m == 1 and !word.stem("e").ends_with_cvc?
          return word.gsub(/e$/, "")
        end
      end
      return word
    end

    def self.step_5b(word)
      return word.gsub(/.$/, "") if word.m > 1 and word.match(/ll$/)
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
            sensitiviti sensibiliti triplicate formative formalize electriciti electrical hopeful goodness
            revival allowance inference airliner gyroscopic adjustable defensible irritant replacement
            adjustment dependent adoption homologou communism activate angulariti homologous effective
            bowdlerize probate rate cease controll roll}

words.each do |word|
  p PorterStemmer.stem(word)
end