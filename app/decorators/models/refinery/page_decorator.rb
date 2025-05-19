require_dependency 'refinery/page'
require 'acts_as_indexed'

module Models
  module Refinery
    module PageDecorator
      def self.prepended(base)
        # Solo agregar indexing si no existe
        unless base.respond_to?(:with_query)
          base.acts_as_indexed(fields: [
            :ascii_title, :meta_description,
            :menu_title, :browser_title, :ascii_all_page_part_content
          ])
        end
      end

      # Métodos de instancia
      def all_page_part_content
        parts.map(&:body).join(" ")
      end

      private

      def ascii_title
        title&.to_ascii
      end

      def ascii_all_page_part_content
        all_page_part_content&.to_ascii
      end
    end
  end
end

# Aplicación del decorador con fallback clásico
begin
  Refinery::Page.prepend(Models::Refinery::PageDecorator)
rescue NameError
  if defined?(Refinery::Page)
    Refinery::Page.class_eval do
      acts_as_indexed(fields: %i[ascii_title meta_description menu_title browser_title ascii_all_page_part_content]) unless respond_to?(:with_query)
      
      def all_page_part_content
        parts.map(&:body).join(" ")
      end

      private

      def ascii_title
        title&.to_ascii
      end

      def ascii_all_page_part_content
        all_page_part_content&.to_ascii
      end
    end
  end
end
