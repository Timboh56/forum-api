module Base
  extend ActiveSupport::Concern

  included do
    scope :limit_ten, lambda { 
      limit(10) }

    
  end
end