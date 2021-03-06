require 'test_helper'

class StandardTypeCreationTest < ActionDispatch::IntegrationTest
  test "standard type creation" do
    get "/standard_types/new"
    assert_response :success
    assert_difference('StandardType.count',1) do
      post_via_redirect "/standard_types", standard_type: { name: 'Charlie'}
    end
    assert assigns(:standard_type)
    created = assigns(:standard_type)
    assert_equal 'Charlie', created.name
    assert_equal standard_type_path(created), path
    get "/standard_types"
    assert assigns(:standard_types)
    assert_includes assigns(:standard_types), created
  end
end
