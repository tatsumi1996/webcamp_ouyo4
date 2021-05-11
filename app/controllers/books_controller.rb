class BooksController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = BookComment.new
    @comments = @book.book_comments

  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def ensure_correct_user
    @user = Book.find(params[:id]).user
	  if current_user.id != @user.id
		  flash[:notice] = "権限がありません"
		  redirect_to books_path
	  end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params[:book].permit(:title, :body)
  end

end
