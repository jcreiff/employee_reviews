class Department

  attr_reader :name, :employees

  def initialize(name)
    @name=name
    @employees = []
    @employee_names = []
  end

  def assign(employee)
    @employees<<employee
  end

  def employee_names
    @employees.map {|e| e.name}
  end

end
