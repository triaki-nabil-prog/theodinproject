require 'rails_helper'

RSpec.describe 'Lesson Completions', type: :system do
  let!(:path) { create(:path, default_path: true) }
  let!(:course) { create(:course, path: path) }
  let!(:section) { create(:section, course: course) }
  let!(:lesson) { create(:lesson, section: section) }

  context 'when user is signed in' do

    before do
      sign_in(create(:user))
      visit path_course_lesson_path(path, course, lesson)
    end
    
    it 'can complete a lesson' do
      find(:test_id, 'complete_btn').click

      expect(find(:test_id, 'incomplete_btn')).not_to be(nil)
    end
    
    it 'can change a completed lesson to incomplete' do
      find(:test_id, 'complete_btn').click
      find(:test_id, 'incomplete_btn').click

      expect(find(:test_id, 'complete_btn')).not_to be(nil)
    end
  end

  context 'when user is not signed in' do
    it 'cannot complete a lesson' do
      visit path_course_lesson_path(path, course, lesson)

      expect(find(:test_id, 'login_button')).to have_content('Login to track progress')
    end
  end
end
