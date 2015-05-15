#Employee Reviews

This program makes tracking information about the employees in your company simple, whether you're a tiny up-and-coming startup or a monolithic blue-chip behemoth.  Here's how it works:

###Departments

Keep track of all the moving parts in your business by organizing at the departmental level. Once you've named each department and assigned its employees, here are the features this program provides:

1. Print a list of `employee_names`
2. Find out how much of your precious budget this department is draining by looking up `salary_total`
3. When you come upon a financial windfall, `give_raises` to everyone in the department!
  * Well, almost everyone...employees with an unsatisfactory performance rating get left out
  * Simply provide the program with the total amount of money you have to distribute, and it will be divvied up evenly among eligible employees. You can even set more specific parameters, like "only give raises to employees named Jim." (But we've seen Jim's reviews, and we know that's not a likely scenario...)
  * Keeping pace with inflation? You can also give all eligible employees a raise by percent
  
###Employees

All your employee info, in one place.  Initialize each employee with a `name`, `phone_number`, `email`, and `salary`, and this program takes care of the rest: 

1. Add employee `reviews` to each employee's file
2. Too busy to read those reviews?  Of course you are. Not to worry, the `assess_review` feature will scan the documents for important keywords to determine if employee performance has been satisfactory.  That's right, folks: your eligibility for the next round of raises is being determined by a machine. 
3. Want to single out a special employee for a raise?  The `give_raise` feature does just that--just feed it a `percent:` or an `amount:`


