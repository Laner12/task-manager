require_relative "../test_helper"

class UserSeesTasksTest < FeatureTest

  def test_user_sees_index_of_tasks
    task1 = task_manager.create({title: "Learn to code",
                                description: "Study your face off"
                                })

    task2 = task_manager.create({title: "Finish robo world",
                                description: "Finish assignment"
                                })
    # As a user
    # when i visit the tasks index
    # then i should see a list of my tasks and their titles
    visit "/tasks"
    # binding.pry
    within ("#task_list") do
    assert page.has_content?("Learn to code")
    assert page.has_content?("Finish robo world")
    end
  end
end
