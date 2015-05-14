require './employee'

class Department

  attr_reader :name, :employees

  def initialize(name)
    @name=name
    @employees = []
    @employee_names = []
    @salary_total = 0
  end

  def assign(employee)
    @employees<<employee
  end

  def employee_names
    @employees.map {|e| e.name}
  end

  def salary_total
    salaries = @employees.map {|e| e.salary}
    salaries.reduce {|t, s| t+s}
  end

  def give_raises(amount: 0, percent: 1)
    the_worthy = @employees.select {|e| e.satisfactory}
    if amount > 0
      each_raise = amount/the_worthy.length
      the_worthy.each {|e| e.give_raise(amount: each_raise)}
    else
      each_raise = percent
      the_worthy.each {|e| e.give_raise(percent: each_raise)}
    end
  end

end
