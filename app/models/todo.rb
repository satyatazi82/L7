class Todo < ActiveRecord::Base
  belongs_to :user
  validates :todo_text, presence: true
  validates :todo_text, length: { minimum: 2}
  validates :due_date, presence: true

  def self.of_user(user)
    where(user_id: user.id)
  end

  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    "#{id}. #{completed ? "[X]" : "[ ]"} #{todo_text} #{due_today? ? nil : due_date}"
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where(due_date: Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def self.completed
    where(completed: true)
  end

  def self.notcompleted
    where(completed: false)
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.updateTask(id, completed)
    todo = Todo.find(id)
    todo.completed = completed
    todo.save
    todo
  end

  def self.createTask(h)
    Todo.create(todo_text: h[:text], due_date: h[:due], completed: false)
  end

  def self.add_task(h)
    Todo.create(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    user = find_by(id: id)
    user.completed = true
    user.save
    user
  end
end
