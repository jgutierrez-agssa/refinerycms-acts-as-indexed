# app/decorators/models/refinery/blog/post_decorator.rb
require 'acts_as_indexed'

module Models
  module Refinery
    module Blog
      module PostDecorator
        def self.prepended(base)
          return if base.respond_to?(:with_query)
          
          base.acts_as_indexed fields: %i[title custom_teaser body]
        end
      end
    end
  end
end

begin
  Refinery::Blog::Post.prepend(Models::Refinery::Blog::PostDecorator)
rescue NameError
  # Manejar caso donde la clase no existe
end
