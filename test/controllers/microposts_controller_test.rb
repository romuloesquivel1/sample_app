require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum"} }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
     delete micropost_path(@micropost)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete micropost_path(micropost)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should update micropost" do
    log_in_as(users(:michael))
    patch micropost_path(@micropost), params: { micropost: { content: "Updated content" } }
    assert_redirected_to root_url
    @micropost.reload
    assert_equal "Updated content", @micropost.content
  end

  test "should render post_not_found when micropost does not belong to user" do
    log_in_as(users(:archer))
    patch micropost_path(@micropost), params: { micropost: { content: "Updated content" } }
    assert_response :not_found
    assert_nil assigns(:micropost)
  end

  test "should render post_not_found when not logged in" do
    get micropost_path(@micropost)
    patch micropost_path(@micropost), params: { micropost: { content: "Updated content" } }
    assert_response :not_found
    assert_nil assigns(:micropost)
  end
end
