class Review < ApplicationRecord
    # associations
    belongs_to :user
    belongs_to :watched_movie

    #validations
    validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

end
