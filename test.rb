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

  def test_departments_can_have_employees
    acct = Department.new("Accounting")
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    assert acct.assign(jim)
  end

  def test_employees_can_be_added_to_departments
    acct = Department.new("Accounting")
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    acct.assign(jim)
    assert_equal [jim], acct.employees
    assert_equal ["Jim"], acct.employee_names
  end

  def test_departments_can_total_salaries
    acct = Department.new("Accounting")
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    acct.assign(jim)
    acct.assign(sue)
    assert_equal 110000, acct.salary_total
  end

  def test_employees_can_get_reviewed
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    review = "Jim needs serious help. He can barely read."
    assert jim.add_review(review)
  end

  def test_can_see_employee_reviews
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    review = "Jim needs serious help. He can barely read."
    jim.add_review(review)
    assert_equal [review], jim.reviews
  end

  def test_employees_have_satisfactory_rating
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    assert jim.satisfactory
  end

  def test_employee_satisfactory_rating_can_be_changed
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    assert_equal true, jim.satisfactory
    jim.satisfactory = false
    assert_equal false, jim.satisfactory
  end

  def test_employees_can_be_given_raises_by_amount
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    sue.give_raise(10000)
    assert_equal 70000, sue.salary
  end

  def test_employees_can_be_given_raises_by_percent
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    sue.give_raise(0.1)
    assert_equal 66000, sue.salary
  end

  def test_departments_can_give_raises
    acct = Department.new("Accounting")
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    acct.assign(jim)
    assert acct.give_raises(30000)
  end

  def test_departments_can_give_raises_to_employees
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)

    acct.give_raises(30000)
    assert_equal 60000, jim.salary
    assert_equal 70000, sue.salary
    assert_equal 85000, mac.salary
    assert_equal 215000, acct.salary_total
  end

end
