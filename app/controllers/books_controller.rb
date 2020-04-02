class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def show
    @newbook = Book.new
  	@book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @newcomment = BookComment.new
    @comments = BookComment.where(book_id: @book.id)
  end

  def index
    @user = User.find(current_user.id)
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      @user = User.find(current_user.id)
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
    @user = User.find(current_user.id)
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      @user = User.find(current_user.id)
  		render "edit"
  	end
  end

  def delete
  	@book = Book.find(params[:id])
  	@book.destoy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private
  def ensure_correct_user
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end
  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
