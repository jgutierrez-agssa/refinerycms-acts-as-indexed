require_dependency 'refinery/authentication/devise/user'
require 'acts_as_indexed'

module Models
  module Refinery
    module UserDecorator
      def self.prepended(base)
        # Añadir indexing solo si no existe
        return if base.respond_to?(:with_query)
        
        base.acts_as_indexed fields: %i[username email]
      end
    end
  end
end

# Aplicación con doble método de compatibilidad
begin
  Refinery::Authentication::Devise::User.prepend(
    Models::Refinery::UserDecorator
  )
rescue NameError
  if defined?(Refinery::Authentication::Devise::User)
    Refinery::Authentication::Devise::User.class_eval do
      acts_as_indexed fields: %i[username email] unless respond_to?(:with_query)
    end
  end
end
