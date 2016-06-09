require 'rails_helper'

describe RecipesController do
  describe "GET #index" do
    it "gets index" do
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
    end

    it "assigns recipes variable" do
      recipe = Recipe.create(name: "Spanish Omelet", description: "delicious")
      get :index
      expect(assigns(:recipes)).to eq([recipe])
    end
  end

  describe "GET #show" do
    it "assigns the requested recipe as @recipe" do
      recipe = Recipe.create(name: "Spanish Omelet", description: "delicious")

      get :show, id: recipe.id

      expect(assigns(:recipe)).to eq(recipe)
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns a new recipe as @recipe" do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    let(:recipe) { Recipe.create(name: "Spanish Omelet", description: "delicious") }

    before do
      get :edit, id: recipe.id
    end

    it "assigns the requested recipe as @recipe" do
      expect(assigns(:recipe)).to eq(recipe)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { recipe: { name: "Risotto", description: "cheesy" } } }

      it "creates a new Recipe" do
        expect {
          post :create, valid_params
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        post :create, valid_params
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it "redirects to the created recipe" do
        post :create, valid_params
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { recipe: { name: "Risotto", description: nil } } }

      it "assigns a newly created but unsaved recipe as @recipe" do
        post :create, invalid_params
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        post :create, invalid_params
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    let(:current_attributes) { { name: "Spanish Omelet", description: "delicious" } }

    context "with valid params" do
      let(:valid_params) { { name: "Risotto", description: "cheesy" } }

      it "updates the requested recipe" do
        recipe = Recipe.create! current_attributes
        put :update, {:id => recipe.to_param, :recipe => valid_params}
        recipe.reload

        expect(recipe.name).to eq("Risotto")
        expect(recipe.description).to eq("cheesy")
      end

      it "assigns the requested recipe as @recipe" do
        recipe = Recipe.create! current_attributes
        put :update, {:id => recipe.to_param, :recipe => valid_params}
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "redirects to the recipe" do
        recipe = Recipe.create! current_attributes
        put :update, {:id => recipe.to_param, :recipe => valid_params}
        expect(response).to redirect_to(recipe)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { name: "Risotto", description: nil } }

      it "assigns the recipe as @recipe" do
        recipe = Recipe.create! current_attributes
        put :update, {:id => recipe.to_param, :recipe => invalid_params}
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "re-renders the 'edit' template" do
        recipe = Recipe.create! current_attributes
        put :update, {:id => recipe.to_param, :recipe => invalid_params}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe" do
      recipe = Recipe.create(name: "Spanish Omelet", description: "delicious")
      expect {
        delete :destroy, {:id => recipe.to_param}
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      recipe = Recipe.create(name: "Spanish Omelet", description: "delicious")
      delete :destroy, {:id => recipe.to_param}
      expect(response).to redirect_to(recipes_url)
    end
  end
end
