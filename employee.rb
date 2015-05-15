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

  def assess_review(review=@reviews.to_s)
    good = scan_positive(review)
    bad = scan_negative(review)

    if good.count > bad.count
      @satisfactory = true
      return true
    else
      @satisfactory = false
      return false
    end
  end

  def give_raise(amount: 0, percent: 1)
    amount < 1?  @salary += @salary * percent : @salary += amount
  end

  def scan_negative(review)
    negative_keywords = [/difficult?\w+/, /confus?\w+/i, /negative?\w+/i,
      /s?lack?\w+/, /adequate.?.?/i, /\slimit?\w+/, /fault.?/, /not/,
      /needs\sto\simprove/, /room\sfor\simprove/, /could\simprove/,
      /\sless/, /below/, /needs?/, /poor.?.?/, /bad\w+\w+/i, /discuss?\w+/,
      /unhappy/, /mediocre/i, /average/i, /concern.?.?.?/, /First/, /Second/,
      /tendenc\w+/, /interrupt.?.?.?/i, /disrespect.?.?.?/, /dwell.?.?.?/,
      /issues?/, /off-?\s?topic/, /though/]

    negative_matches = []
    negative_keywords.each do |regex|
      match = review.scan(regex)
      negative_matches << match if match != []
    end
    negative_matches.flatten
  end

  def scan_positive(review)
    positive_keywords = [/assets?/, /\spleasure/, /quick\w*/, /always/,
    /\ssuccess\w*/, /\shappy/, /\sperfect\w*/, /incredibl\w/, /solid\w*/,
    /\sconsisten\w*/, /\seffective\w*/, /\ssatisf\w+/, /\simpress\w*/,
    /willing\sto\shelp/, /great\w*/, /enjoy\w*/, /devote\w?/, /\sbig/,
    /\sbig-?time/, /huge/, /amazing/, /!/, /super\w*/, /wonderful.?.?/,
    /\stalent\w*/, /awesome/i, /fantastic/, /fabulous/]

    positive_matches = []
    positive_keywords.each do |regex|
      match = review.scan(regex)
      positive_matches << match if match != []
    end
    positive_matches.flatten
  end
end
