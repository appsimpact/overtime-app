require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, scope: :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = FactoryBot.create(:post, user: @user)
      post2 = FactoryBot.create(:second_post, user: @user)
      visit posts_path
      expect(page).to have_content(/rationale|content/)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "some rationale"
      click_on "Save"

      expect(page).to have_content("some rationale")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      click_on "Save"

      expect(@user.posts.last.rationale).to eq('User Association')
    end
  end

  describe 'edit' do
    let!(:post) { FactoryBot.create(:post, user: @user) }

    it 'can be reached by clicking Edit on index page' do
      visit posts_path

      click_link("edit_#{post.id}")
      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "updated content"
      click_on "Save"

      expect(page).to have_content("updated content")
    end

  end
end
