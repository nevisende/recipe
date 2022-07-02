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
          flash[:notice] = 'Recipe Created Successfully'
          redirect_to recipes_path
        else
          flash[:notice] = 'Error occcured, Please check values'
        end
      end
    end
  end

  def toggle_public
    @recipe = Recipee.find(params[:id])
    is_public = params['public']
    puts is_public
    @recipe.public = is_public
    flash[:notice] = if @recipe.save
                       'Success'
                     else
                       'Error occcured'
                     end
  end

  def destroy
    recipe = current_user.recipees.find(params[:id])
    recipe.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Removed Successfully'
        redirect_to recipes_path
      end
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
