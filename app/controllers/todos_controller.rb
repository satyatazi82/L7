class TodosController < ApplicationController

  def index
    # render plain: Todo.to_displayable_list.join("\n")
    render "index"
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_displayable_string
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.updateTask(id, completed)

    redirect_to todos_path
  end

  def delete
    id = params[:id]
    todo = Todo.find(id)
    todo.destroy

    redirect_to todos_path
  end

  def create
    text = params[:todo_text]
    due = DateTime.parse(params[:due_date])
    newTodo = Todo.createTask({ :text => text, :due => due, :completed => false })

    redirect_to todos_path
  end
end
