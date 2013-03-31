require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/hash_with_indifferent_access'

module Ecm
  module References
    module Configuration
      def configure
        yield self
      end

      mattr_accessor :markup_languages
      @@markup_languages = []

      mattr_accessor :default_markup_language
      @@default_markup_language = nil
    end
  end
end
