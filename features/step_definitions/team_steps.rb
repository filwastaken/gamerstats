#clear && bundle exec cucumber

Given("I am logged in as a user with uid {int}") do |uid|
    user = User.find_by(uid: uid.to_i)
    assert_not_nil user, "User with UID #{uid} not found"
  
    visit '/users/sign_in'
    fill_in "user_email", :with => "pinco.pallino@gmail.com"
    fill_in "user_password", :with => "111111"
    click_button "Log in"
end

And("I am on the new team page") do 
    visit new_team_path
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
    puts elem.text
    assert_equal(notice,elem.text)
end

And("a team exists with giocatore1: {string}, giocatore3: {string}, giocatore2: {string}") do |giocatore1, giocatore3, giocatore2|
    Team.create!(nome_team: "myTeamX", giocatore1: giocatore1, giocatore2: giocatore2, giocatore3: giocatore3, giocatore4: "")
end

And ("a team exists with team_nome_team: {string}") do |nome|
    Team.create!(nome_team: nome, giocatore3: "1", giocatore2: "51")
end
  
