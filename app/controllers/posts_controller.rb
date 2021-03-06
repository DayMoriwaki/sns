class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :like_ajax]
  before_action :authenticate_user!, except: [:index ,:show]
  #exceptのものだけ許可するという

  def like
    # @post = Post.find(params[:id])
    if @post.like_count.nil?
      @post.like_count = 0
    end

    @post.like_count = @post.like_count + 1
    @post.save

    @comment = Comment.new

    render :show
  end

  def like_ajax
    if @post.like_count.nil?
      @post.like_count = 0
    end

    @post.like_count = @post.like_count + 1
    @post.save

    render json: { "count": @post.like_count }
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    # Postクラスは、modelsのpost.rb
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #@post = Post.find(params[:id])
    #render "posts/show"
    #@user = User.find(@post.user_id)
    @comment = Comment.new
  end

  def users
    #@posts = Post.all
    #.allもクラスのメソッド
    #@posts = Post.where(user_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  # GET /posts/new
  def new
    # deviseのライブラリの機能により、current userと書くと、ログインしているユーザーIDが表示される。
    # if not user_signed_in?
    #   redirect_to new_user_session_path
    #   return
    # end

    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    pp current_user
    @post = Post.new 
    @post.user_id = current_user.id
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :post_date, :like_count)
    end
end
