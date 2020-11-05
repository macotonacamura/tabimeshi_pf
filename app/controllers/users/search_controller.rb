class Users::SearchController < ApplicationController
  # def search
  #   @model = params["search"]["model"]
  #   @content = params["search"]["content"]
  #   @how = params["search"]["how"]
  #   @users = search_for(@how, @model, @content)
  # end

  # private

  # def partical(model, content)
  #   if model == 'user'
  #     User.where("name LIKE ?", "%#{content}%")
  #   end
  # end

  # def search_for(how, model, content)
  #   case how
  #   when 'partical'
  #     partical(model, content)
  #   end
  # end
end
