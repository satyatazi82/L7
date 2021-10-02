class User < ActiveRecord::Base
  validates :firstname, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 2}
  validates :password, presence: true

  has_secure_password

  has_many :todos

  def to_displayable_string
    "#{id}. #{name} #{email}"
  end

  def self.login(email, password)
    User.find_by(email: email, password: password)
  end

  def self.register(hash)
    User.new(firstname: hash[:firstname], lastname: hash[:lastname], email: hash[:email], password: hash[:password])

  end

  def self.to_displayable_list
    all.map { |user| user.to_displayable_string }
  end
end
