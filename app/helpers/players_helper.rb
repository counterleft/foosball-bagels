module PlayersHelper
  def colored_plus_minus(player)
    if player.plus_minus > 0
      css_class = "positive"
    elsif player.plus_minus < 0
      css_class = "negative"
    else
      css_class = "neutral"
    end
    %(<span class="#{css_class}">#{player.plus_minus}</span>)
  end
end
