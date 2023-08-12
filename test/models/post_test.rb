require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)  # Accede al usuario con el alias 'one' definido en las fixtures
  end

  test "should create post" do
    post = Post.new(title: "Título del post", content: "Contenido del post", user: @user)
    assert post.save
  end

  test "should not create post without title" do
    post = Post.new(title: nil, content: "Contenido del post")
    assert_not post.save, "Saved the post without title"
  end  
end
