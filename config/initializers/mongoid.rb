class String
  def identify
    if Mongoid.parameterize_keys
      key = ""
      each_char { |c| key += ((c != '_' && c != '-' && CHAR_CONV[c]) || c.downcase) }; key
    else
      self
    end
  end
end
