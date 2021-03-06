require 'rails_tools-absence_validator'
require 'active_admin-acts_as_list'
require 'active_admin-awesome_nested_set'
require 'acts_as_list'
require 'acts_as_markup'
require 'acts_as_published'
require 'awesome_nested_set'
require 'awesome_nested_set-tools'
require 'ecm_pictures'
require 'friendly_id'

require 'ecm/references/engine'
require 'ecm/references/configuration'
require 'ecm/references/routing'

module Ecm
  module References
    extend Configuration
  end
end
