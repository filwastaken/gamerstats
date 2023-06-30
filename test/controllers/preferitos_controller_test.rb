require "test_helper"

class PreferitosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preferito = preferitos(:one)
  end

  test "should get index" do
    get preferitos_url
    assert_response :success
  end

  test "should get new" do
    get new_preferito_url
    assert_response :success
  end

  test "should create preferito" do
    assert_difference('Preferito.count') do
      post preferitos_url, params: { preferito: { dest_id: @preferito.dest_id, mitt_id: @preferito.mitt_id, nome_dest: @preferito.nome_dest } }
    end

    assert_redirected_to preferito_url(Preferito.last)
  end

  test "should show preferito" do
    get preferito_url(@preferito)
    assert_response :success
  end

  test "should get edit" do
    get edit_preferito_url(@preferito)
    assert_response :success
  end

  test "should update preferito" do
    patch preferito_url(@preferito), params: { preferito: { dest_id: @preferito.dest_id, mitt_id: @preferito.mitt_id, nome_dest: @preferito.nome_dest } }
    assert_redirected_to preferito_url(@preferito)
  end

  test "should destroy preferito" do
    assert_difference('Preferito.count', -1) do
      delete preferito_url(@preferito)
    end

    assert_redirected_to preferitos_url
  end
end
