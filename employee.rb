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

  def assess_review(review)
    if review
      @satisfactory = true
    else
      @satisfactory = false
    end
  end

  def give_raise(amount: 0, percent: 1)
    amount < 1?  @salary += @salary * percent : @salary += amount
  end

  def scan_negative(review)
    negative_keywords = [/difficult?\w/i, /confus?\w+/i, /negative?\w+/i,
      /s?lack?\w+/, /adequate?\w+/i, /\slimit?\w+/, /fault?\w+/, /not/,
      /needs\sto\simprove?\w+/, /room\sfor\simprove?\w+/, /could\simprove?\w+/,
      /\sless/, /below/, /needs?/, /poor?\w+/, /bad?\w+/i, /discuss?\w+/,
      /unhappy/, /mediocre/i, /average/i, /concern?\w+/, /First/, /Second/,
      /tendenc?\w+/, /interrupt?\w+/i, /disrespect?\w+/, /dwell?\w+/, /issue?\w+/,
      /off-?\s?topic/, /though/]

    negative_matches = []
    negative_keywords.each do |regex|
      match = review.scan(regex)
      negative_matches << match if match != []
    end
    negative_matches.flatten
  end

  def scan_positive(review)
  end
end
