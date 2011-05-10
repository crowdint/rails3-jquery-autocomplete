module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def home_page
    "/"
  end
  
  def new_id_element_page
    "/id_elements/new"
  end

  def new_sub_class_page
    "/sub_classes/new"
  end

  def new_multiple_section_page
    "/multiple_selections/new"
  end

  def new_nested_model_page
    "/nested_models/new"
  end

  def new_simple_form_page
    "/simple_forms/new"
  end
  
  def new_scoped_cutocomplete_page
    "/scoped_autocompletes/new"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
