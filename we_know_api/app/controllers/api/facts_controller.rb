class API::FactsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def index
    respond_with Fact.all
  end

  def show
    respond_with Fact.find(params[:id])
  end

  def create
    fact = current_user.facts.build(fact_params)
    if fact.save
      render json: fact, status: 201, location: [:api, fact]
    else
      render json: { errors: fact.errors, status: 422 }
    end
  end

  def update
    fact = current_user.facts.find(params[:id])
    if fact.update(fact_params)
      render json: fact, status: 200, location: [:api, fact]
    else
      render json: { errors: fact.error }, status: 422
    end
  end

  def destroy
    fact = current_user.facts.find(params[:id])
    fact.destroy
    head 204
  end

private

  def fact_params
    params.require(:fact).permit(:title, :description, :flagged)
  end
end
