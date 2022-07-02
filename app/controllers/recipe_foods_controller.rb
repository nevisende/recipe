class RecipeFoodsController < ApplicationController
  def index; end

  def new
    @foods = Food.all
    @recipe = Recipee.find(params[:recipe_id])
    recipe_food = RecipeFood.new
    respond_to do |format|
      format.html { render :new, locals: { recipe_food: } }
    end
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipee_id = params[:recipe_id]

    respond_to do |format|
      format.html do
        if @recipe_food.save
          redirect_to recipes_path
          flash[:notice] = 'Success'
        else
          flash[:notice] = 'Error occcured, Please check values'
        end
      end
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
