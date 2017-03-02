class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_filter :login_required, only:[:edit, :update, :destroy]

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  # GET /posts/new
  def new
    @user = User.new
  end

  # GET /posts/1/edit
  def edit
    @user = current_user
  end

  # POST /posts
  # POST /posts.json
  def create

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id

        format.html { redirect_to posts_url, notice: 'user was successfully created.' }
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
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
