class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
  
    if user_signed_in?
      @comment.user = current_user
    else
      @comment.display_name = params[:comment][:display_name]
    end
  
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Failed to create comment.'
    end
  end

  # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize_comment_owner!(@comment)
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    authorize_comment_owner!(@comment)
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: 'Comentario actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    
    if @comment.user.nil? || (@comment.user == current_user)
      @comment.destroy
      redirect_to post_path(@post), notice: 'Comentario eliminado correctamente.'
    else
      redirect_to post_path(@post), alert: 'No tienes permiso para eliminar este comentario.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def authorize_comment_owner!(comment)
      unless user_signed_in? && (comment.user == current_user)
        # Verifica si el usuario no está autenticado pero es el autor del comentario
        unless !user_signed_in? && comment.user.nil?
          redirect_to post_path(comment.post), alert: 'No tienes permiso para realizar esta acción.'
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      permitted_params = [:content, :post_id]
      permitted_params << :display_name unless user_signed_in?
      params.require(:comment).permit(permitted_params)
    end
end
