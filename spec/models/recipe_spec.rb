require 'rails_helper'

describe Recipe do
  describe "validations" do
    it "is invalid without a name" do
      recipe = Recipe.new(name: "")
      recipe.valid?
      expect(recipe.errors).to have_key(:name)
    end

    it "is invalid without a description" do
      recipe = Recipe.new(description: "")
      recipe.valid?
      expect(recipe.errors).to have_key(:description)
    end

    it "is valid without calories" do
      recipe = Recipe.new(calories: "")
      recipe.valid?
      expect(recipe.errors).not_to have_key(:calories)
    end
  end

  describe "#calorie_bomb?" do
    it "returns true if the calories are more than 800" do
      recipe = Recipe.new(calories: 1000)
      expect(recipe.calorie_bomb?).to eq(true)
    end

    it "returns false if the calories are less than 800" do
      recipe = Recipe.new(calories: 500)
      expect(recipe.calorie_bomb?).to eq(false)
    end
  end

  describe "#order_by_calories" do
    it "returns a sorted array of recipes by calories" do
      omelette = Recipe.create(name: "Spanish Omelette", description: "delicious", calories: 500)
      risotto = Recipe.create(name: "Risotto", description: "cheesy", calories: 600)
      brownie = Recipe.create(name: "Brownie", description: "sweet", calories: 1000)

      expect(Recipe.order_by_calories).to match_array [omelette, risotto, brownie]
    end
  end

  describe "#by_letter" do
    subject { Recipe.by_letter("S") }

    it "returns a sorted array of results that match" do
      omelette = Recipe.create(name: "Spanish Omelette", description: "delicious", calories: 500)
      salad = Recipe.create(name: "Salad", description: "healthy", calories: 300)
      brownie = Recipe.create(name: "Brownie", description: "sweet", calories: 1000)

      expect(subject).to match_array [salad, omelette]
      expect(subject).not_to include brownie
    end
  end
end
