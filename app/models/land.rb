class Land < ActiveRecord::Base
	has_many :images, dependent: :destroy
end
