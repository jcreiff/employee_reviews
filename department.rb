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
    fits_block = []
    if block_given?
      @employees.each do |e|
        if yield(e)
          fits_block << e
        end
      end
      eligible = fits_block.select {|e| e.satisfactory}
      distribute_raises(eligible, amount)
    else
      eligible = @employees.select {|e| e.satisfactory}
      distribute_raises(eligible, amount)
    end

  end

  def distribute_raises(array=[], amount)
    if amount < 1
      each_raise = amount
      array.each {|e| e.give_raise(percent: each_raise)}
    else
      each_raise = amount/array.length
      array.each {|e| e.give_raise(amount: each_raise)}
    end
  end

end
