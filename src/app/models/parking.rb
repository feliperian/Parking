class Parking < ApplicationRecord
    validates_presence_of :plate
    validates :plate, format: {
        with: /\A[A-Z]{3}-[0-9]{4}\z/,
        message: 'It must be like AAA-9999' }
end
