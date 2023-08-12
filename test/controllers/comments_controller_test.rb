require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)  # Asegúrate de reemplazar "one" con el nombre correcto de tu fixture de post
    @comment = comments(:one)
  end


  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_url(@post), params: { comment: { content: @comment.content, post_id: @post.id, user_id: @comment.user_id } }
    end

    assert_redirected_to post_comments_url(@post)
  end

  test "should get edit" do
    get edit_post_comment_url(@post, @comment)
    assert_response :success
  end

  test "should update comment" do
    patch post_comment_url(@post, @comment), params: { comment: { content: @comment.content, post_id: @post.id, user_id: @comment.user_id } }
    assert_redirected_to post_comment_url(@post, @comment)
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete post_comment_url(@post, @comment)
    end

    assert_redirected_to post_comments_url(@post)
  end
end

