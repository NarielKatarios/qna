require 'active_support/concern'

module Commented
  extend ActiveSupport::Concern

  def comment
    #vote_model.comments
    #vote_model.reload
  end
end