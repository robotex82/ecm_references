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
    belongs_to :category,
               :foreign_key => :ecm_categories_category_id
    has_many :attached_pictures, :as => :pictureable,
                                 :class_name => Ecm::Pictures::AttachedPicture,
                                 :inverse_of => :pictureable
    has_many :pictures, :through => :attached_pictures,
                        :class_name => Ecm::Pictures::Picture

    accepts_nested_attributes_for :attached_pictures, :allow_destroy => true
    accepts_nested_attributes_for :pictures, :allow_destroy => true

    # attributes
    attr_accessible :attached_pictures_attributes,
                    :category,
                    :ecm_categories_category_id,
                    :description,
                    :markup_language,
                    :name,
                    :pictures_attributes

    # callbacks
    after_initialize :set_defaults
#    before_validation do
#      self.published = ["published"] # if @attributes.has_key?("published")
#    end

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

    def self.localized
      joins(:category).where(:ecm_references_categories => { :locale => I18n.locale })
    end

    def self.with_public_visibility
     published.localized
    end

    def preview_picture
      pictures.first
    end

    def preview_picture_image_url(style = nil)
      preview_picture.image.url(style) if preview_picture.respond_to?(:image) && preview_picture.image.respond_to?(:url)
    end

    def to_s
      name
    end # def

    private

    def set_defaults
      if self.new_record?
        self.markup_language ||= Ecm::References::Configuration.default_markup_language
        self.published = Ecm::References::Configuration.new_references_published_by_default if self.published_at.nil?
      end
    end # def
  end # class Reference < ActiveRecord::Base
end # module Ecm::References
