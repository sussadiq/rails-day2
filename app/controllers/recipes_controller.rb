class RecipesController < ApplicationController
    before_action :fetch_recipe, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index]
    before_action :check_ownership, only: [:edit, :update, :destroy]
    include Ownership
    def index
        @recipes= Recipe.all.order(created_at: :desc)
    end
    def new
        @recipe = Recipe.new
    end
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user = current_user
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end
    def show
    end
    def edit
    end
    def update
        @recipe.update(recipe_params)
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :edit
        end
    end
    def destroy
        @recipe.destroy
        flash[:notice] = "Recipe deleted successfully."
        redirect_to recipes_path
    end
    def my
        @recipes=Recipe.where(user: current_user).order(created_at: :desc)
    end

    private
    def recipe_params
        params.expect(recipe:[:title,:instructions])
    end
    def fetch_recipe
        @recipe=Recipe.find(params[:id])
    end
    def check_ownership
        if current_user != @recipe.user
            flash[:alert] = "You are not authorized to edit this recipe."
            redirect_to recipe_path(@recipe) and return
        end
    end
end