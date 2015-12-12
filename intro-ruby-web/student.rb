class Student

  def initialize(grade)
    @grade = grade
  end

  def better_grade_than?(other)
    better = self.grade > other.grade ? true : false
    if better
      "I have better grades than you"
    else
      "You have better grades than me"
    end
  end

  protected

    def grade
      @grade
    end

end

joe = Student.new(95)
bob = Student.new(85)

puts joe.better_grade_than?(bob)
puts joe.instance_variables
puts joe.grade
