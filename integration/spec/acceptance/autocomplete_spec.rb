require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Autocomplete", %q{
  In order to do funky stuff
  As a User
  I want autocomplete!
} do

  background do
    enable_javascript
    lambda do 
      Brand.create! [
         { :name => "Alpha"   , :state => true  },
         { :name => "Beta"    , :state => false },
         { :name => "Gamma"   , :state => false },
         { :name => "Kappa"   , :state => true  },
         { :name => "Kappler" , :state => false }
      ]
    end.should change(Brand, :count).by(5)
    lambda { Feature.create! [{:name => "Shiny"}, {:name => "Glowy"}] }.should change(Feature, :count).by(2)
  end

  context "Autocomplete" do
    scenario "Autocomplete" do
      visit home_page
      fill_in "Brand name", :with => "al"
      choose_autocomplete_result "Alpha"
      find_field("Brand name").value.should include("Alpha")
    end

    scenario "Autocomplete, id_element option" do
      visit new_id_element_page
      fill_in "Brand name", :with => "al"
      choose_autocomplete_result "Alpha"
      find_field("Brand name").value.should include("Alpha")
      find_field("Brand").value.should include(Brand.find_by_name("Alpha").id.to_s)
    end

    scenario "Autocomplete for a sub class" do
      lambda { ForeignBrand.create! :name => "Omega" }.should change(ForeignBrand, :count)

      visit new_sub_class_page
      fill_in "Brand name", :with => "om"
      choose_autocomplete_result "Omega"
      find_field("Brand name").value.should include("Omega")
    end

    scenario "Multiple autocomplete" do
      visit new_multiple_section_page
      send_to("Brand name", "al")
      choose_autocomplete_result "Alpha"
      send_to("Brand name", "bet")
      choose_autocomplete_result "Beta"
      find_field("Brand name").value.should include("Alpha,Beta")
    end

    scenario "Autocomplete for Nested Models" do
      visit new_nested_model_page
      send_to("Feature Name", "sh")
      choose_autocomplete_result "Shiny"
      find_field("Feature Name").value.should include("Glowy,Shiny")
    end

    scenario "Autocomplete for simple_form" do
      visit new_simple_form_page
      fill_in("Brand name", :with => "al")
      choose_autocomplete_result "Alpha"
      find_field("Brand name").value.should include("Alpha")
    end

    scenario "Autocomplete with scope" do
      kappa_brand = Brand.find_by_name('Kappa')
      kappa_brand.address = Address.create!
      kappa_brand.save!
      visit new_scoped_cutocomplete_page
      fill_in("Brand name", :with => "ka")
      choose_autocomplete_result "Kappa"
      find_field("Brand name").value.should include("Kappa")
    end
  end
end
