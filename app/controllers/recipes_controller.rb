class RecipesController < ApplicationController
    before_action :authorize
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Recipe.all, status: :created
    end

    def create
        user_id = session[:user_id]
        user = User.find(user_id)
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end


    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, :user_id)
    end

    def authorize
        return render json: {errors: ["Unauthorized"]}, status: :unauthorized unless session[:user_id]
    end

    def record_invalid(invalid)
        render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity
    end

end
