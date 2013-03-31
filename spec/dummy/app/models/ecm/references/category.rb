class Ecm::References::Category < ActiveRecord::Base
self.table_name = 'ecm_references_categories'

  # attributes
  attr_accessible :description,
                  :markup_language,
                  :name,
                  :parent_id,
                  :slug

  # callbacks
  after_initialize :set_defaults

  # friendly id support
  extend FriendlyId
  friendly_id :name, :use => :slugged

  # markup support
  acts_as_markup :language => :variable, :columns => [ :description ]

  # nested set support
  acts_as_nested_set

  # validations
  validates :name, :presence => true,
                   :uniqueness => { :scope => [ :parent_id ] }

  def to_s
    name
  end

  private

  def set_defaults
    if self.new_record?
      self.markup_language ||= Ecm::References::Configuration.default_markup_language
    end
  end
end

