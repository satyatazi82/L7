class TodosController < ApplicationController

  def index
    @todos = Todo.of_user(current_user)
    # render plain: Todo.to_displayable_list.join("\n")
    render "index"
  end

  def show
    id = params[:id]
    render plain: Todo.of_user(current_user).find(id).to_displayable_string
  end

  def update
    id = params[:id]
    completed = params[:completed]
    begin
      todo = Todo.of_user(current_user).updateTask(id, completed)
    rescue => exception
    end

    redirect_to todos_path
  end

  def delete
    id = params[:id]
    begin
      todo = Todo.of_user(current_user).find(id)
      todo.destroy
    rescue => exception
    end

    redirect_to todos_path
  end

  def create
    text = params[:todo_text]
    due = params[:due_date]
    newTodo =  Todo.new(todo_text: text, due_date: due, completed: false, user_id: current_user.id)
    if !newTodo.save
      flash[:error] = newTodo.errors.full_messages.join(', ')
    end
    redirect_to todos_path
  end
end
