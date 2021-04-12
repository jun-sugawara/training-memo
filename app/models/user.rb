class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :training_records
    has_many :body_records

    with_options presence: true do
      validates :nickname
      validates :age
      validates :gender
    end
end
