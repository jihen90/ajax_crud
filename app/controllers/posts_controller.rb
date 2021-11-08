class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy]


  def index
    # posts = "COALESCE(title, '') LIKE '%'"
    # unless params[:q].nil?
    #   posts = "COALESCE(title, '') LIKE '%" + params[:q] + 
    #   "%' OR COALESCE(content, '') LIKE '%" + params[:q] + "%'"
    # end
    
    # @posts = Post.where(posts)

    if params[:search]
      @search_results_posts = Post.search_by_title_and_content(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js { render nothing: true, notice: 'Lo creaste' }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update!(post_params)
        format.js { render nothing: true, notice: 'Lo actualizaste' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.js { render nothing: true, notice: 'borrado' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
