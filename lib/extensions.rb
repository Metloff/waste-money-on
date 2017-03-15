class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end

  def present?
    !blank?
  end
end

class String
  def standartize
    self.strip.mb_chars.downcase
  end
end