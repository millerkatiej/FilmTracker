class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :name
      t.string :director
      t.integer :year
      t.string :country
      t.string :language
      t.string :distributor
      t.string :date
      t.integer :rating
      t.string :format
      t.string :notes
    end
  end
end

    [:name, :director, :year, :country, :language, :distributor, :date, :rating, :format, :notes].each do |attr|
