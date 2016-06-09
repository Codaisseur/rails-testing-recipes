require 'rails_helper'

describe "Navigating recipes" do
  it "allows navigation from the detail page to the listing page" do
    recipe = Recipe.create(name: "Spanish Omelet", description: "Delicious", calories: 400)
    visit recipe_url(recipe)

    click_link "Back"

    expect(current_path).to eq(recipes_path)
  end
end
