class CreateDataConfigs < ActiveRecord::Migration
  def change
    create_table :data_configs do |t|
      t.string :ledger_designation_list
      t.string :ledger_area_list
      t.string :ledger_salesman_list
      t.string :ledger_use_voucher_list
      t.string :ledger_rate_used_list
      t.string :ledger_grade_list
      t.string :ledger_grade_list
      t.string :ledger_fleetorder_list
      t.string :ledger_segment_list

      t.timestamps
    end
  end
end
