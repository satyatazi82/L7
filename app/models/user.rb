class User < ActiveRecord::Base
  def to_displayable_string
    "#{id}. #{name} #{email}"
  end

  def self.login(email, password)
    User.find_by(email: email, password: password)
  end

  def self.register(hash)
    User.create!(name: hash[:name], email: hash[:email], password: hash[:password])
  end

  def self.to_displayable_list
    all.map { |user| user.to_displayable_string }
  end
end
