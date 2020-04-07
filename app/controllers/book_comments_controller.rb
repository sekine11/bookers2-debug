class BookCommentsController < ApplicationController
	before_action :authenticate_user!

  def create
  	@book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
  end

  def destroy
    @comment = BookComment.find(params[:book_id])
    @book = @comment.book
    @comment.destroy
  end

  private
  def ensure_correct_user
    @comment = BookComment.find(params[:id])
    if current_user.id != @comment.user.id
      redirect_back(fallback_location: :back)
    end
  end
  def book_comment_params
  	params.require(:book_comment).permit(:content)
  end
end
