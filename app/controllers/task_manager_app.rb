require "sqlite3"

class TaskManagerApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
     @tasks = task_manager.all
     erb :index
   end

  get '/tasks/new' do
   erb :new
 end

 post '/tasks' do
   task_manager.create(params[:task])
   redirect '/tasks'
 end

 get '/tasks/:id/edit' do |id|
   @task = task_manager.find(id.to_i)
   erb :edit
 end

 get '/tasks/:id' do |id|
   @task = task_manager.find(id.to_i)
   erb :show
 end

 put '/tasks/:id/' do |id|
   task_manager.update(id.to_i, params[:task])
   redirect "/tasks/#{id}"
 end

 delete '/tasks/:id' do |id|
   task_manager.destroy(id.to_i)
   redirect '/tasks'
 end

 def task_manager
   if ENV['RACK_ENV'] == 'test'
     database = SQLite3::Database.new('db/task_manager_test.db')
   else
     database = SQLite3::Database.new('db/task_manager_development.db')
   end
   database.results_as_hash = true
   @task_manager ||= TaskManager.new(database)
 end
end
