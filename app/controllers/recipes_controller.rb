class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def public
    @recipes = Recipe.where(public: true)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: recipe } }
    end
  end

  def create
    recipe = current_user.recipe.new(recipe_params)
    respond_to do |format|
      format.html do
        if recipe.save
          redirect_to controller: "recipe", action: "index", flash: { alert: 'Success' }
        else
          render :new, locals: { recipe: recipe }, flash: { alert: 'Error occured' }
        end
      end
    end
  end

  def destroy
    recipe = current_user.recipes.find(params[:id])
    recipe.destroy
    respond_to do |format|
      format.html do
        redirect_to controller: "recipe", action: "index", flash: { alert: 'Success' }
      end
    end
  end

  private

  def recipe_params
    params.require(:post).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
