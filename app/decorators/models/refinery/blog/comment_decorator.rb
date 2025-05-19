require 'acts_as_indexed'

module Models
  module Refinery
    module Blog
      module CommentDecorator
        def self.prepended(base)
          base.acts_as_indexed fields: [:name, :email, :message] unless self.respond_to? :with_query
        end
      end
    end
  end
end

# Precargar la clase manualmente si es necesario
if defined?(Refinery::Blog::Comment)
  Refinery::Blog::Comment.prepend(Models::Refinery::Blog::CommentDecorator)
end
