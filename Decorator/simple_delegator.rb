require 'date'
class User
    def born_on
      Date.new(1989, 9, 10)
    end
  end
  
  class UserDecorator < SimpleDelegator
    def birth_year
      born_on.year
    end
  end

  class LeapDecorator < SimpleDelegator
    def is_leap_year?
        Date.leap?(birth_year)
    end
  end

  
  decorated_user = UserDecorator.new(User.new)
  decorated_user.birth_year  #=> 1989
  decorated_user.__getobj__  #=> #<User: ...>

  decorated_user_year_leap = LeapDecorator.new(decorated_user)
  decorated_user_year_leap.is_leap_year?  #=> false
  decorated_user_year_leap.__getobj__  #=> #<User: ...>

  'If we need more decorators in our app then we can create a base decorator:'

  class BaseDecorator < SimpleDelegator 
    def base
    __getobj__
    end 
end

class UserProfileDecorator < BaseDecorator
     def name
    "#{base.first_name} #{base.last_name}"
    end 
end