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

  def give_raise(amt_or_pct)
    amt_or_pct > 1? @salary += amt_or_pct : @salary += @salary * amt_or_pct
  end
end
