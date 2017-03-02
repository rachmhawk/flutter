class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :like, :destroy]

  # GET /posts
  # GET /posts.json

  def index
    @post = Post.new
    @posts = Post.order("created_at DESC").all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    user = User.first
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
        format.js{}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.js{}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST /posts/1/like
  def like
    #@post.likes.create(user: current_user)
    like = @post.likes.where(user: current_user).first_or_initialize

      if like.new_record?
        like.save
        #create like
        #@post.likes.create(user: current_user)
      else
        #delete like
        like.destroy
      end

      respond_to do |format|
          format.html {redirect_to request.referer}
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if current_user == @post.user
      @post.destroy
        respond_to do |format|
          format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
          format.js {}
          format.json { head :no_content }
    end

  else #if surrent_user == @post
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.js {}
      format.json { head :no_content }
    end
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      id = params[:id]
      id ||= params[:post_id]
      @post = Post.find(id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, )
    end
end
