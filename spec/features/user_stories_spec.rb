# As a User
# So that I can keep track of my bookmarks
# I want to see them displayed chronologically on a webpage

feature 'bookmark manager' do
  scenario 'user is able to see list of bookmarks on homepage' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'add a website to the bookmark manager' do
    visit '/links/add'
    #click_button('Add link')
    fill_in(:url, with: 'google.com')
    fill_in(:title, with: 'live')
    click_button('Submit')

    within 'ul#links' do
        expect(page).to have_content('live')
      end
  end

  scenario 'add a tag to a link' do
    visit '/links/add'
    fill_in(:url, with: 'google.com')
    fill_in(:title, with: 'live')
    fill_in(:tags, with: 'search')
    click_button('Submit')
    link = Link.last
    expect(link.tags.map(&:tags)).to include('search')
  end



scenario 'I can filter links by tag' do
  Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(tags: 'education')])
  Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(tags: 'search')])
  Link.create(url: 'http://www.zombo.com', title: 'This is Zombocom', tags: [Tag.first_or_create(tags: 'bubbles')])
  Link.create(url: 'http://www.bubble-bobble.com', title: 'Bubble Bobble', tags: [Tag.first_or_create(tags: 'bubbles')])
  visit '/tags/bubbles'

  expect(page.status_code).to eq(200)
  within 'ul#links' do
    expect(page).not_to have_content('Makers Academy')
    expect(page).not_to have_content('Code.org')
    expect(page).to have_content('This is Zombocom')
    expect(page).to have_content('Bubble Bobble')
  end
end

scenario 'add a tag to a link' do
  visit '/links/add'
  fill_in(:url, with: 'google.com')
  fill_in(:title, with: 'live')
  fill_in(:tags, with: 'search, best')
  click_button('Submit')
  link = Link.last
  expect(link.tags.map(&:tags)).to include('search', 'best')
end

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    visit '/register'

    fill_in :email,    with: 'alice@example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'oranges!'
    expect { click_button 'Log in' }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end
end

scenario 'requires a matching confirmation password' do
    visit '/register'
    fill_in :email, with: 'email'
    fill_in :password, with: 'password'
    fill_in :password_confirmation, with: 'passwor'

    expect { click_button 'Log in' }.not_to change(User, :count)

  end

end
