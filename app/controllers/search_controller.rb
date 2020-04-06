class SearchController < ApplicationController
	before_action :authenticate_user!

	def search
		if params[:search_select] == "User"
			@results = User.search(params[:search], params[:search_method])
			if @results
				@book = Book.new
			else
				redirect_to users_path
			end
		elsif params[:search_select] == "Book"
			@results = Book.search(params[:search], params[:search_method])
			if @results
				@book = Book.new
			else
				redirect_to books_path
			end
		end
	end

	private
end
