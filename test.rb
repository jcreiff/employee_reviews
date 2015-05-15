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
    sue.give_raise(amount: 10000)
    assert_equal 70000, sue.salary
  end

  def test_employees_can_be_given_raises_by_percent
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    sue.give_raise(percent: 0.1)
    assert_equal 66000, sue.salary
  end

  def test_departments_can_give_raises
    acct = Department.new("Accounting")
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    acct.assign(jim)
    assert acct.give_raises(30000)
  end

  def test_departments_can_give_raises_to_employees_by_amount
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

  def test_departments_can_give_raises_to_employees_by_percent
    #realized after the fact that this wasn't necessary. oh well.
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)

    acct.give_raises(0.1)
    assert_equal 55000, jim.salary
    assert_equal 66000, sue.salary
    assert_equal 82500, mac.salary
    assert_equal 203500, acct.salary_total
  end

  def test_only_good_employees_get_raises_by_amount
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)

    jim.satisfactory = false
    acct.give_raises(30000)

    assert_equal 50000, jim.salary
    assert_equal 75000, sue.salary
    assert_equal 90000, mac.salary
  end

  def test_only_good_employees_get_raises_by_percent
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)

    jim.satisfactory = false
    acct.give_raises(0.1)

    assert_equal 50000, jim.salary
    assert_equal 66000, sue.salary
    assert_equal 82500, mac.salary
  end

  def test_all_parts_work_together
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)

    sue.give_raise(percent: 0.1)

    review = "Jim needs serious help. He can barely read."
    jim.add_review(review)

    jim.satisfactory = false
    acct.give_raises(10000)

    assert_equal "Accounting", acct.name
    assert_equal "Sue", sue.name
    assert_equal "jim@jim.com", jim.email
    assert_equal "123-456-7890", mac.phone_number
    assert_equal ["Jim", "Sue", "Mac"], acct.employee_names
    assert_equal ["Jim needs serious help. He can barely read."], jim.reviews
    assert_equal false, jim.satisfactory
    assert_equal true, mac.satisfactory
    assert_equal 50000, jim.salary
    assert_equal 71000, sue.salary
    assert_equal 80000, mac.salary
    assert_equal 201000, acct.salary_total

  end

  def test_give_raises_can_yield_to_block
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.us", "123-456-7890", 75000)
    ann = Employee.new("Ann", "ann@ann.org", "111-222-3333", 55000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)
    acct.assign(ann)

    jim.satisfactory = false
    acct.give_raises(10000) do |e|
      e.salary < 75000
    end

    assert_equal 50000, jim.salary
    assert_equal 65000, sue.salary
    assert_equal 75000, mac.salary
    assert_equal 60000, ann.salary
  end

  def test_another_block_because_im_excited_that_it_works
    acct = Department.new("Accounting")

    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    mac = Employee.new("Mac", "mac@mac.com", "123-456-7890", 75000)
    ann = Employee.new("Ann", "ann@ann.com", "111-222-3333", 55000)

    acct.assign(jim)
    acct.assign(sue)
    acct.assign(mac)
    acct.assign(ann)

    jim.satisfactory = false
    acct.give_raises(10000) do |e|
      e.email.include?(".com")
    end

    assert_equal 50000, jim.salary
    assert_equal 60000, sue.salary
    assert_equal 80000, mac.salary
    assert_equal 60000, ann.salary
  end

  def test_can_read_employee_reviews
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    review = "Jim, seriously. What are you doing."
    assert jim.assess_review(review)
  end

  def test_reading_review_can_change_rating
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    review = false
    jim.assess_review(review)
    assert_equal false, jim.satisfactory
  end

  def test_regexps_are_finding_negative_keywords
    jim = Employee.new("Jim", "jim@jim.com", "919-999-9999", 50000)
    review = "Jim is a very positive person and encourages those around him,
    but he has not done well technically this year. There are two areas in
    which Jim has room for improvement.  First, when communicating verbally
    (and sometimes in writing), he has a tendency to use more words than are
    required. This conversational style does put people at ease, which is
    valuable, but it often makes the meaning difficult to isolate, and can cause
    confusion. Second, when discussing new requirements with project managers,
    less of the information is retained by Jim long-term than is expected. This
    has a few negative consequences: 1) time is spent developing features that
    are not useful and need to be re-run, 2) bugs are introduced in the code and
    not caught because the tests lack the same information, and 3) clients are
    told that certain features are complete when they are inadequate.  This
    communication limitation could be the fault of project management, but given
    that other developers appear to retain more information, this is worth
    discussing further."
    blank = "No words here"

    assert_empty jim.scan_negative(blank)
    refute_empty jim.scan_negative(review)
  end

  def test_regexps_are_finding_negative_keywords
    sue = Employee.new("Sue", "sue@sue.net", "911-911-9111", 60000)
    review = "Sue has been an incredibly consistent and effective developer.
    Clients are always satisfied with her work, developers are impressed with
    her productivity, and she's more than willing to help others even when she
    has a substantial workload of her own.  She is a great asset to Awesome
    Company, and everyone enjoys working with her.  During the past year, she
    has largely been devoted to work with the Cement Company, and she is the
    perfect woman for the job.  We know that work on a single project can become
    monotonous, however, so over the next few months, we hope to spread some of
    the Cement Company work to others.  This will also allow Sue to pair more
    with others and spread her effectiveness to other projects."
    blank = "No words here"

    assert_empty sue.scan_positive(blank)
    refute_empty sue.scan_positive(review)
  end
end
