json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :description, :calories
  json.url recipe_url(recipe, format: :json)
end
