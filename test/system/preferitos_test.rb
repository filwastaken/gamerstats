require "application_system_test_case"

class PreferitosTest < ApplicationSystemTestCase
  setup do
    @preferito = preferitos(:one)
  end

  test "visiting the index" do
    visit preferitos_url
    assert_selector "h1", text: "Preferitos"
  end

  test "creating a Preferito" do
    visit preferitos_url
    click_on "New Preferito"

    fill_in "Dest", with: @preferito.dest_id
    fill_in "Mitt", with: @preferito.mitt_id
    fill_in "Nome dest", with: @preferito.nome_dest
    click_on "Create Preferito"

    assert_text "Preferito was successfully created"
    click_on "Back"
  end

  test "updating a Preferito" do
    visit preferitos_url
    click_on "Edit", match: :first

    fill_in "Dest", with: @preferito.dest_id
    fill_in "Mitt", with: @preferito.mitt_id
    fill_in "Nome dest", with: @preferito.nome_dest
    click_on "Update Preferito"

    assert_text "Preferito was successfully updated"
    click_on "Back"
  end

  test "destroying a Preferito" do
    visit preferitos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Preferito was successfully destroyed"
  end
end
