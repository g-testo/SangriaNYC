class RecipesController < ApplicationController
  def index
    if params[:flavor]
      recipeFlavor = params[:flavor]
      unless recipeFlavor == "Other"
        @title = "#{recipeFlavor} Recipes"
      else
        @title = "Unique Recipes"
      end
      @recipes = Recipe.where(:flavor => params[:flavor])
    else
      @title = "All Recipes"
      @recipes = Recipe.all
      @recipes = Recipe.paginate(page: params[:page], :per_page => 6)
    end
  end

  def new
    @recipe = current_user.recipes.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @rating = Rating.where(recipe_id: @recipe.id, user_id: current_user.id).first
    unless @rating
      @rating = Rating.create(recipe_id: @recipe.id, user_id: current_user.id, score: 0)
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    current_user.inspect
    @recipe.author = current_user.user_name
    if @recipe.save
        redirect_to @recipe, notice: "Recipe created successfully."
    else
        redirect_to new_recipe_path, alert: "Error creating recipe."
    end
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
        redirect_to @recipe, notice: "Recipe updated successfully."
    else
        redirect_to edit_recipe_path(@recipe), alert: "Error updating recipe."
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :instructions, :author, :servings, :recipe_image, :user_id, :flavor, :ingredients)
    end
end
