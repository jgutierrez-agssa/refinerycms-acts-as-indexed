# app/decorators/models/refinery/inquiries/inquiry_decorator.rb
require 'acts_as_indexed'


module Models
  module Refinery
    module Inquiries
      module InquiryDecorator
        def self.prepended(base)
          return if base.respond_to?(:with_query)
          
          base.acts_as_indexed fields: %i[name email message phone]
        end
      end
    end
  end
end

if defined?(Refinery::Inquiries::Inquiry)
  Refinery::Inquiries::Inquiry.prepend(Models::Refinery::Inquiries::InquiryDecorator)
end
