#clear && bundle exec cucumber

Given("I am logged in as a user with uid {int}") do |uid|
    user = User.find_by(uid: uid.to_i)
    assert_not_nil user, "User with UID #{uid} not found"
  
    visit '/users/sign_in'
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => "111111"
    click_button "Log in"
end

And("I am on the new team page") do 
    visit new_team_path
end

And("I am on the home page") do 
    visit home_index_path
end

When("I fill in {string} with {string}") do |field, value|
    fill_in field, with: value
end

And("I press {string}") do |button|
    click_button button
end

Then("I should see {string}") do |notice|
    #expect(page).to have_content(notice)
    elem = find("#alert")
    assert_equal(notice,elem.text)
end

And("a team exists with giocatore1: {string}, giocatore3: {string}, giocatore2: {string}") do |giocatore1, giocatore3, giocatore2|
    Team.create!(nome_team: "myTeamX", giocatore1: giocatore1, giocatore2: giocatore2, giocatore3: giocatore3, giocatore4: "")
end

And ("a team exists with team_nome_team: {string}") do |nome|
    Team.create!(nome_team: nome, giocatore3: "1", giocatore2: "51")
end
  
And("a preferito exists with nome_dest: {string}, dest_id: {string}") do |nome, id|
    Preferito.create!(nome_dest: nome, dest_id: id)
end

And("I am on the new preferito page") do 
    visit new_preferito_path
end

And("I am on the personstats page") do 
    visit personstats_path
end

Given ("I am logged in as an Admin") do
    admin = Admin.find_by(id: 1)
    assert_not_nil admin, "Admin with ID 1 not found"
  
    visit '/admins/sign_in'
    fill_in "admin_email", :with => "adminemail@placeholder.com"
    fill_in "admin_password", :with => "0123456789"
    click_button "Log in"
end

And("I am on the admin page") do 
    visit adminpage_path
end
  
When("I select {string} in {string}") do |email, field|
    select(email, from: field)
end


Then("Non dovrebbe essere presente l'elemento con id {string}") do |element_id|
    if !(page.has_no_selector?("#" + element_id))
      raise "L'elemento con ID #{element_id} è presente nella pagina"
    end
end

Then("Dovrebbe essere presente l'elemento con id {string}") do |element_id|
    if page.has_no_selector?("#" + element_id)
      raise "L'elemento con ID #{element_id} non è presente nella pagina"
    end
end