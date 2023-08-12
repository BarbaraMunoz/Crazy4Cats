require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @comment = Comment.new(content: "This is a comment.", post_id: @post.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "content should be present" do
    @comment.content = "   "
    assert_not @comment.valid?
  end

  test "should belong to a post" do
    @comment.post = nil
    assert_not @comment.valid?
  end
end
