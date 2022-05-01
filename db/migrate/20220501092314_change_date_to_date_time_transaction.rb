# frozen_string_literal: true

class ChangeDateToDateTimeTransaction < ActiveRecord::Migration[7.0]
  def up
    change_column :transactions, :date, :datetime
  end

  def down
    change_column :transactions, :datetime, :date
  end
end
