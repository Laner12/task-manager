require "sqlite3"

database = SQLite3::Database.new("db/task_manager_development.db")

database.execute("DELETE FROM tasks")

database.execute(
                "INSERT INTO tasks
                (title, description)
                VALUES ('Go to the gym', 'because'),
                ('Brush cat', 'to prevent matting'),
                ('Do your homework', 'becasue your dumb');")
                puts "It worked and:"
puts database.execute("SELECT * FROM tasks;")
