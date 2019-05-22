# Adapter design pattern - 22.05.19 by Grzegorz Jakubiak
# Sources:
# - https://en.wikipedia.org/wiki/Adapter_pattern
# - https://www.tutorialspoint.com/design_pattern/adapter_pattern.htm
# - https://medium.com/@dljerome/design-patterns-in-ruby-adapter-89a482c26d8c
# - https://www.sitepoint.com/using-and-testing-the-adapter-design-pattern/

# Adapter pattern is used to make a class comply with an existing interface of a client.

# First Example
# Let's assume we've got a class defined as follows
class Tool
  def use_tool(kind)
    case kind
    when :hammer
      puts 'using hammer'
    when :screwdriver
      puts 'using screwdriver'
    when :drill
      puts 'using drill'
    end
  end
end

# Second Example
# Consider we've rewritten previous example using adapter pattern
# We've definied separate a class for each tool as well as an adapter for it
class Hammer
  def swing!
    'using hammer'
  end
end

class HammerAdapter
  attr_reader :hammer

  def initialize(hammer)
    @hammer = hammer
  end

  def use_tool
    hammer.swing!
  end
end

class Screwdriver
  def screw!
    'using screwdriver'
  end
end

class ScrewdriverAdapter
  attr_reader :screwdriver

  def initialize(screwdriver)
    @screwdriver = screwdriver
  end

  def use_tool
    screwdriver.screw!
  end
end

class Drill
  def drill!
    'using drill'
  end
end

class DrillAdapter
  attr_reader :drill

  def initialize(drill)
    @drill = drill
  end

  def use_tool
    drill.drill!
  end
end

class Tool
  attr_reader :adapter

  def initialize(adapter)
    @adapter = adapter
  end

  def use_tool
    adapter.use_tool
  end
end

hammer = Hammer.new
hammer_adapter = HammerAdapter.new(hammer)
tool = Tool.new(hammer_adapter)

tool.use_tool