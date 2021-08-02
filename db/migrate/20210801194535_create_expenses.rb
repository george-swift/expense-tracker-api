class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :title
      t.bigint :amount
      t.string :date
      t.string :notes
      t.references :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
