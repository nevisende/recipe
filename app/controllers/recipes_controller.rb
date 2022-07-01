class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipees
  end

  def public
    @recipes = Recipee.where(public: true).order('created_at DESC')
  end

  def show
    @recipe = Recipee.find(params[:id])
  end

  def new
    recipe = Recipee.new
    respond_to do |format|
      format.html { render :new, locals: { recipe: } }
    end
  end

  def create
    recipe = current_user.recipees.new(recipe_params)
    respond_to do |format|
      format.html do
        if recipe.save
          redirect_to recipes_path flash: { alert: 'Success' }
        else
          render :new, locals: { recipe: }, flash: { alert: 'Error occured' }
        end
      end
    end
  end

  def destroy
    recipe = current_user.recipees.find(params[:id])
    recipe.destroy
    respond_to do |format|
      format.html do
        redirect_to recipes_path flash: { alert: 'Success' }
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
