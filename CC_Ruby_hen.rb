#programa que modela a un granjero que recoge huevos de gallinas ponedoras. 
#Este será un sistema que contendrá dos tipos de objetos: Huevo(Egg) y Gallina Ponedora(LayingHen).

$hatched_hours = 0

class LayingHen 
  
  #'@age' and '@eggs' variables are initialized
  def initialize
    @age = 0
    @eggs = []
    @piojo = Piojo.new
  end
  
  #reader attributes of 'eggs', 'age' and 'piojo'
  attr_reader :eggs, :age, :piojo

  # Ages the hen one month, and lays 4 eggs if the hen is older than 3 months
  def age!
    @age += 1
    if @age > 3
      #4 eggs objects are created into Array
      4.times do
        new_egg = Egg.new
        @eggs << new_egg
      end
    end
  end

  # Returns +true+ if the hen has laid any eggs, +false+ otherwise
  def any_eggs?
    if @eggs.length > 0 
      true
    else
      false
    end
    #other way for doing
    #!eggs.empty?
  end

  # Returns an Egg if there are any
  # Raises a NoEggsError otherwise
  def pick_an_egg!
    raise NoEggsError, "The hen has not layed any eggs" unless self.any_eggs?
    # egg-picking logic goes here
    return @eggs.pop
  end

  # Returns +true+ if the hen can't laid eggs anymore because of its age, +false+ otherwise.
  # The max age for a hen to lay eggs is 10 
  def old?
    if @age >= 10
      true
    else
      false
    end
  end
 
  #hatched hours are increased
  def increase_hatched_hour(hours)
    $hatched_hours = $hatched_hours + hours
  end
end

#this class will be used for creating an Array with objects 'eggs' 
class Egg
  # Initializes a new Egg with hatched hours +hatched_hours+
  def initialize
    $hatched_hours = 0
  end

  # Return +true+ if hatched hours is greater than 3, +false+ otherwise
  def rotten?
    if $hatched_hours > 3
      true
    else
      false
    end
  end
end

#class to test an instance in 'LayingHen' class
class Piojo
    #method to print a string
    def to_s 
      "soy un piojo"
    end

end

#Driver code

#'hen' instance is created
hen = LayingHen.new

puts "Este es el piojo " + hen.piojo.to_s

#'basket' Array is initialized
basket = []
#'rotten_eggs' variable is initialized
rotten_eggs = 0

#'age' is increased until starting to laid eggs
hen.age! until hen.any_eggs?

puts "Hen is #{hen.age!} months old, its starting to laid eggs."
puts ""

#if hen is ten months old then loop is broken
until hen.old?

  # The time we take to pick up the eggs
  hours = rand(5)
  #'hatched_hours' variable is initialized
  hen.increase_hatched_hour(hours)
  
  #if no objects 'eggs' then loop is broken
  while hen.any_eggs?
    #'egg' variable is initialized with an object 
    egg = hen.pick_an_egg!
    #it evaluates if object 'egg' is rotten or not
    if egg.rotten?
      rotten_eggs += 1
    else
      basket << egg
    end
  end

  puts "Month #{hen.age} Report"
  puts "We took #{hours} hour(s) to pick the eggs"
  puts "Eggs in the basket: #{basket.size}"
  puts "Rotten eggs: #{rotten_eggs}"
  puts ""

  # Age the hen another month
  hen.age!
end

puts "The hen is old, she can't laid more eggs!"
puts "The hen laid #{basket.size + rotten_eggs} eggs"
if rotten_eggs == 0
  puts "CONGRATULATIONS NO ROTTEN EGGS" 
else
  puts "We pick to late #{rotten_eggs} eggs so they become rotten"
end