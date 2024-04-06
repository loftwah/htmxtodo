# app.rb
require 'sinatra'

set :server, 'thin'
set :public_folder, File.dirname(__FILE__) + '/public'

todos = []
id = 0

get '/' do
  erb :index
end

post '/todos' do
  id += 1  # Increment the ID for each new todo
  todos << { id: id, task: params[:task], completed: false }
  erb :todos, locals: { todos: todos }, layout: false
end

post '/todos/:id/toggle' do
    todo = todos.find { |t| t[:id] == params[:id].to_i }
    todo[:completed] = !todo[:completed] if todo
    erb :todos, locals: { todos: todos }, layout: false
  end

post '/todos/:id/delete' do
  todos.reject! { |t| t[:id] == params[:id].to_i }
  erb :todos, locals: { todos: todos }, layout: false
end
