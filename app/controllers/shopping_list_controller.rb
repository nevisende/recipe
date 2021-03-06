class ShoppingListController < ApplicationController
  def index
    @recipe = Recipee.find(params[:recipe_id])
    @recipe_food = RecipeFood.all
    @food = Food.all
    @total_price = current_user.sum(@recipe.recipe_food.includes([:food]))
  end

  def show
    @recipe = Recipee.find(params[:recipe_id])
    @recipe_food = RecipeFood.all
    @food = Food.all
    @total_price = 0
    @recipe_food.each do |fd|
      @total_price += fd.quantity * fd.food.price
    end
  end
end
