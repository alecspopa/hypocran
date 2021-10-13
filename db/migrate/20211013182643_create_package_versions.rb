class CreatePackageVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :package_versions do |t|
      t.references :package, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
