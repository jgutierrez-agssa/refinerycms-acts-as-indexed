require_dependency 'refinery/image'
require 'acts_as_indexed'

module Models
  module Refinery
    module ImageDecorator
      def self.prepended(base)
        # Solo agregar acts_as_indexed si no existe
        unless base.respond_to?(:with_query)
          base.acts_as_indexed fields: [:title]
        end
      end
    end
  end
end

# Aplicar el decorador con doble método para compatibilidad
begin
  Refinery::Image.prepend(Models::Refinery::ImageDecorator)
rescue NameError
  # Manejar caso donde la clase padre no existe
  Rails.logger.warn "Refinery::Image no encontrado, no se aplicó el decorador"
end
