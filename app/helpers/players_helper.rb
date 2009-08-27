module PlayersHelper
  def self.colored_plus_minus(plus_minus)
    if plus_minus > 0
      css_class = "positive"
    elsif plus_minus < 0
      css_class = "negative"
    else
      css_class = "neutral"
    end
    %(<span class="#{css_class}">#{plus_minus}</span>)
  end
end
