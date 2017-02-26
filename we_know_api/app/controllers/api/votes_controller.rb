class API::VotesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def create
    fact = Fact.find(params[:fact_id])
    vote = fact.votes.build({user_id: current_user[:id]})
    if vote.save
      render json: vote, status: 201, location: [:api, vote]
    else
      render json: { errors: vote.errors, status: 422 }
    end
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy
    head 204
  end
end
