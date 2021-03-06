class Product < ActiveRecord::Base
  validates_presence_of :title, :description, :image_url
  validates_numericality_of :price
  validates_uniqueness_of :title
  validates_format_of :image_url,
                      :with => %r{\.(gif|jpg|png)$}i,
                      :message => 'must be a URL of GIF, JPG, or PNG.'

  validate :price_must_be_at_least_a_cent

  def self.find_products_for_sale
    find(:all, :order => "title")
  end
  
protected
  def price_must_be_at_least_a_cent
    errors.add(:price, 'must be more than 0.01.') if price.nil? || price < 0.01
  end
end
