require_relative "../test_helper"

class UserCanCreateATaskTest < FeatureTest

  def test_user_can_create_a_task
    # As a User
    # When I visit the dashboard
    # and i click the link "create task"
    # then i should be on new task pase
    # and i fill the title field with
    visit "/"
    click_link "New Task"
    assert_equal "/tasks/new", current_path
    fill_in "task[title]", with: "new task"
    fill_in "task[description]", with: "new description"
    click_button("Submit")
    assert_equal "/tasks", current_path
    assert page.has_css?("#title")
    assert page.has_content?("All Tasks")
    # make sure that these names are accurate
  end
end
