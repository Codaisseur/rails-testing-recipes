class Recipe < ActiveRecord::Base
  validates :name, :description, presence: true

  def calorie_bomb?
    calories > 800
  end

  def self.order_by_calories
    order(:calories)
  end

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
