class RecipesController < ApplicationController
    before_action :fetch_recipe, only: [:show, :edit, :update]
    before_action :authenticate_user!, except: [:index]
    def index
        @recipes= Recipe.all
    end
    def new
        @recipe = Recipe.new
    end
    def create
        @recipe = Recipe.new(recipe_params)
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
    private
    def recipe_params
        params.expect(recipe:[:title,:instructions])
    end
    def fetch_recipe
        @recipe=Recipe.find(params[:id])
    end
end