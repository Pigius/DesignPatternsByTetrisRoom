class UserDecorator < Draper::Decorator
    delegate_all
    
    def full_name
      object.first_name.present? ? "#{object.first_name.split[0]} #{object.last_name}" : ''
    end
  end
  