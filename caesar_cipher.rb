def caesar_cipher(string, shift)
  replacements = ['a'..'z', 'A'..'Z'].map { |x| x.drop(shift).push(x.take(shift)) }

  string.tr("a-zA-Z", replacements.join)
end