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

  def give_raises(amount)
    the_worthy = @employees.select {|e| e.satisfactory}
    each_raise = amount/the_worthy.length
    the_worthy.each {|e| e.give_raise(each_raise)}
  end

end
