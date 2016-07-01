class TaskManager
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(task)
    database.execute("INSERT INTO tasks (title, description)
                      VALUES (?, ?);", task[:title], task[:description])
                      # non guarded (\"#{task[:title]}\", \"#{task[:description]}\")
    # database.transaction do
    #   database['tasks'] ||= []
    #   database['total'] ||= 0
    #   database['total'] += 1
    #   database['tasks'] << { "id" => database['total'],
    #                         "title" => task[:title],
    #                          "description" => task[:description] }
    # end
  end

  def raw_tasks
    database.execute("SELECT * FROM tasks;")
    # database.transaction do
    #   database['tasks'] || []
    # end
  end

  def all
    raw_tasks.map { |data| Task.new(data) }
  end

  def raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def find(id)
    Task.new(raw_task(id))
  end

  def update(id, task)
    database.execute("UPDATE tasks SET title= ?, description= ?
                      WHERE id = ?;", task[:title], task[:description], id)

                      # non guarded database.execute("UPDATE tasks SET title= ?, description= ?
                      #                   WHERE id = ?;" task[:title], task[:description], id)
    # database.transaction do
    #   target_task = database['tasks'].find { |data| data["id"] == id}
    #   target_task["title"] = task[:title]
    #   target_task["description"] = task[:description]
    # end
  end

  def destroy(id)
    database.execute("DELETE FROM tasks WHERE id= ?;", id)
    # database.transaction do
    #   database['tasks'].delete_if { |task| task["id"] == id }
    # end
  end

  def delete_all
    database.execute("DELETE FROM tasks")
    # database.transaction do
    #   database["tasks"] = []
    #   database["total"] = 0
    # end
  end
end
