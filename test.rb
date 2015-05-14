require 'minitest/autorun'
require 'minitest/pride'

require './department.rb'
require './employee.rb'

class EmployeeReviewsTest < Minitest::Test

  def test_departments_can_created_with_name
    acct = Department.new("Accounting")
    assert_equal "Accounting", acct.name
  end

  def test_employees_can_be_created_with_info
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    assert_equal "Jim", jim.name
    assert_equal "jim@jim.com", jim.email
    assert_equal "919-999-9999", jim.phone_number
    assert_equal 50000, jim.salary
  end

end
