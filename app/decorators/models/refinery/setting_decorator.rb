require_dependency 'refinery/setting'
require 'acts_as_indexed'

module Models
  module Refinery
    module SettingDecorator
      def self.prepended(base)
        return if base.respond_to?(:with_query)
        
        base.acts_as_indexed fields: [:name]
      end
    end
  end
end

# Aplicación con doble método para compatibilidad
begin
  Refinery::Setting.prepend(Models::Refinery::SettingDecorator)
rescue NameError
  if defined?(Refinery::Setting)
    Refinery::Setting.class_eval do
      acts_as_indexed fields: [:name] unless respond_to?(:with_query)
    end
  end
end
