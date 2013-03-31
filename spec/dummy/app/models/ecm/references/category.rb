module Ecm::References
  class Category < ActiveRecord::Base
    self.table_name = 'ecm_references_categories'

    # associations
    has_many :references, :foreign_key => :ecm_categories_category_id

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
    validates :markup_language, :presence => true,
                                :inclusion => Ecm::References::Configuration.markup_languages.map(&:to_s)
    validates :name, :presence => true,
                     :uniqueness => { :scope => [ :parent_id ] }

    def reference_count
      references.count
    end

    def to_s
      name
    end # def

    private

    def set_defaults
      if self.new_record?
        self.markup_language ||= Ecm::References::Configuration.default_markup_language
      end
    end # def
  end # class Category < ActiveRecord::Base
end # module Ecm::References
