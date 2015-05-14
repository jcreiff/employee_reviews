class Employee

  attr_reader :name, :email, :phone_number, :salary, :reviews

  def initialize(name, email, phone_number, salary)
    @name = name
    @email = email
    @phone_number = phone_number
    @salary = salary.to_f
    @reviews = []
  end

  def add_review(review)
    @reviews << review
  end
end
