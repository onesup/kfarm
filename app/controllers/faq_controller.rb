class FaqController < ApplicationController
  def index
    @answers = Answer.all
  end
end
