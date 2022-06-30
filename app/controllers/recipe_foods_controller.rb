class RecipeFoodsController < ApplicationController
  def index; end

  def create
    @recipe_food = Recipee.new(params.require(:recipe_food).permit(:quantity))
    @food = Food.find(params[:food_id])
    @recipe = Recipee.find(params[:recipe_id])
    @recipe_food.food_id = @food_id
    @recipe_food.recipe_id = @recipe_id

    respond_to do |format|
      format.html do
        if @recipe_food.save
          redirect_to(recipe_path(@recipe))
        else
          render :new, locals: { recipe_food: @recipe_food }, flash: { alert: 'Error: Action Failed' }
        end
      end
    end
  end
end
