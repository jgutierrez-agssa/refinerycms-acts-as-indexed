require_dependency 'refinery/resource'
require 'acts_as_indexed'

module Models
  module Refinery
    module ResourceDecorator
      def self.prepended(base)
        # Solo agregar indexing si no existe
        unless base.respond_to?(:with_query)
          base.acts_as_indexed(
            fields: [:file_name, :title, :type_of_content]
          )
        end
      end
    end
  end
end

# Aplicación con doble método de compatibilidad
begin
  Refinery::Resource.prepend(Models::Refinery::ResourceDecorator)
rescue NameError => e
  # Fallback para versiones muy antiguas
  if defined?(Refinery::Resource)
    Refinery::Resource.class_eval do
      acts_as_indexed fields: %i[file_name title type_of_content] unless respond_to?(:with_query)
    end
  end
end
