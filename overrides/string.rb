class String
  def to_bool
    if self =~ (/^(true|t|yes|y|1)$/i)
      true
    else
      false
    end
  end
end