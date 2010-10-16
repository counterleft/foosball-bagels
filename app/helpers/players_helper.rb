module PlayersHelper
  
  def self.bagel_contributors(contributors, bagel_contributor_links)
    contribute_verb = " is "
    contribute_verb = " are " if bagel_contributor_links.size > 1

    plus_minus = PlayersHelper.colored_plus_minus contributors.first.plus_minus

    return (bagel_contributor_links.to_sentence + contribute_verb + "more likely to help a team receive a bagel with a plus-minus of " + plus_minus + ".").html_safe
  end

  def self.bagel_preventers(preventers, bagel_preventer_links)
    prevent_verb = " is "
    prevent_verb = " are " if bagel_preventer_links.size > 1

    plus_minus = PlayersHelper.colored_plus_minus preventers.first.plus_minus

    return (bagel_preventer_links.to_sentence + prevent_verb + "more likely to help a team give a bagel to another team with a plus-minus of " + plus_minus + ".").html_safe
  end

  def self.colored_plus_minus(plus_minus)
    if plus_minus > 0
      css_class = "positive"
    elsif plus_minus < 0
      css_class = "negative"
    else
      css_class = "neutral"
    end
    %(<span class="#{css_class}">#{plus_minus}</span>).html_safe
  end
end
