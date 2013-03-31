module Ecm::References
  class Reference < ActiveRecord::Base
    self.table_name = 'ecm_references_references'

    # acts as list
    acts_as_list :scope => :ecm_categories_category
    default_scope :order => 'ecm_categories_category_id ASC, position ASC'

    # acts as published
    include ActsAsPublished::ActiveRecord
    acts_as_published

    # associations
    belongs_to :category, :foreign_key => :ecm_categories_category_id

    # attributes
    attr_accessible :ecm_categories_category_id,
                    :description,
                    :markup_language,
                    :name

    # callbacks
    after_initialize :set_defaults

    # friendly id support
    extend FriendlyId
    friendly_id :name, :use => :slugged

    # markup support
    acts_as_markup :language => :variable, :columns => [ :description ]

    # validations
    validates :ecm_categories_category_id, :presence => true
    validates :markup_language, :presence => true,
                                :inclusion => Ecm::References::Configuration.markup_languages.map(&:to_s)
    validates :name, :presence => true,
                     :uniqueness => { :scope => [ :ecm_categories_category_id ] }

    def to_s
      name
    end # def

    private

    def set_defaults
      if self.new_record?
        self.markup_language ||= Ecm::References::Configuration.default_markup_language
        self.published = Ecm::References::Configuration.new_references_published_by_default ? true : false
      end
    end # def
  end # class Reference < ActiveRecord::Base
end # module Ecm::References
