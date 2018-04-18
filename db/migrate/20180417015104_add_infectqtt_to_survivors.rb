class AddInfectqttToSurvivors < ActiveRecord::Migration[5.0]
  def change
    add_column :survivors, :infectqtt, :integer, default: 0
  end
end
