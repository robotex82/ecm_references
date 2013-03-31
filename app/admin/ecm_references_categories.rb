ActiveAdmin.register Ecm::References::Category do
  menu :parent => Proc.new { I18n.t('ecm.references.active_admin.menu') }.call

  # Nested set settings
  config.sort_order = 'lft_asc'
  sortable_tree_member_actions

  form do |f|
    f.inputs do
      f.input :parent, :as => :select, :collection => nested_set_options(Ecm::References::Category, f.object) { |c| "#{'&#160;&#160;&#160;&#160;' * c.depth}&bull; #{c.to_s}".html_safe }
    end # f.inputs

    f.inputs do
      f.input :name
      f.input :description
    end # f.inputs

    f.inputs do
      f.input :markup_language, :as => :select, :collection => Ecm::References::Configuration.markup_languages.map(&:to_s)
    end # f.inputs

    f.actions
  end # form

  index :as => :nested_set do
    selectable_column
    sortable_tree_columns
    sortable_tree_indented_column :name
    column :created_at
    column :updated_at
    default_actions
  end # index

  show do
    panel Ecm::References::Category.human_attribute_name(:description) do
      ecm_references_category.description
    end
  end # show

  sidebar Ecm::References::Category.human_attribute_name(:details), :only => :show do
    attributes_table_for ecm_references_category do
      row :parent
      row :name
      row :markup_language
      row :depth
      row :created_at
      row :updated_at
    end
  end # sidebar
end
