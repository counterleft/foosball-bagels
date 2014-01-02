Given "an unlogged-in user" do
  # do nothing
end

Then "the user must login" do
  sign_in
  expect(page).to have_selector("a[title='Bagel Central']")
end

And "the user enters an incorrect password" do
  sign_in("bad password")
end

Then "an error is shown" do
  expect(page).to have_selector("#error")
end
