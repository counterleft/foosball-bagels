# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def will_paginate(collection_or_options = nil, options = {})
    if collection_or_options.is_a? Hash
      options, collection_or_options = collection_or_options, nil
    end
    unless options[:renderer]
      options = options.merge :renderer => PaginationLinkRenderer
    end
    super *[collection_or_options, options].compact
  end
end
