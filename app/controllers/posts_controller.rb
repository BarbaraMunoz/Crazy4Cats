class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all.order(created_at: :desc)

    @pagy, @posts = pagy(@posts) # Gema pagy

    @filtro = params[:buscar] # Gema pg-search
    if @filtro.present?
      @posts = Post.search_by_title_and_username(@filtro)
    end
  end


  # Dar Me gusta
  def upvote
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end

    respond_to do |format|
      format.html do
        redirect_to @post
      end
      format.js do
        render "vote.js.erb" # Renderiza la vista parcial para actualizar los botones y el recuento
      end
    end
  end

  # Dar No me gusta
  def downvote
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end

    respond_to do |format|
      format.html do
        redirect_to @post
      end
      format.js do
        render "vote.js.erb" # Renderiza la vista parcial para actualizar los botones y el recuento
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post, notice: 'Post actualizado correctamente.'
    else
      render :edit
    end
  end


  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    
      if current_user.admin?
        @post.destroy
        redirect_to root_path, notice: 'Post eliminado correctamente.'
      elsif current_user == @post.user
        @post.destroy
        redirect_to root_path, notice: 'Post eliminado correctamente.'
      else
        redirect_to root_path, alert: 'No tienes permiso para eliminar este post.'
      end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, images: [])
  end

end




