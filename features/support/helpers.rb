def sign_in(password="secret")
  visit("/sign_in")

  within("#sign-in") do
    fill_in "Password", with: password
    click_button "Enter"
  end
end

When(/the user visits the (.*) page/) do |path|
  visit(send("#{path}_path"))
end
