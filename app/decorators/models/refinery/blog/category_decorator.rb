require 'acts_as_indexed'

module Models
  module Refinery
    module Blog
      module CategoryDecorator
        def self.prepended(base)
          return if base.respond_to?(:with_query)
          
          base.acts_as_indexed(fields: [:title])
        end
      end
    end
  end
end

# Precargar la clase manualmente si es necesario
if defined?(Refinery::Blog::Category)
  Refinery::Blog::Category.prepend(Models::Refinery::Blog::CategoryDecorator)
end
