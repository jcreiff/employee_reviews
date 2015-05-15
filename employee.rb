class Employee

  attr_reader :name, :email, :phone_number, :reviews, :salary
  attr_accessor :satisfactory

  def initialize(name, email, phone_number, salary)
    @name = name
    @email = email
    @phone_number = phone_number
    @salary = salary
    @reviews = []
    @satisfactory = true
  end

  def add_review(review)
    @reviews << review
  end

  def give_raise(amount: 0, percent: 1)
    amount < 1?  @salary += @salary * percent : @salary += amount
  end
end
