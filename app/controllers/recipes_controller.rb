class RecipesController < ApplicationController
    before_action :authorize

    def index
        render json: Recipe.all, status: :created
    end


    private

    def authorize
        return render json: {errors: ["Unauthorized"]}, status: :unauthorized unless session[:user_id]
    end

end
