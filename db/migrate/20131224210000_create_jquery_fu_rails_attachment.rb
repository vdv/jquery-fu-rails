class CreateJqueryFuRailsAttachment < ActiveRecord::Migration
  def self.up
    create_table :jquery_fu_rails_attachments do |t|
      t.string  :file_name, null: false
      # t.string  :content_type
      # t.integer :file_size

      t.integer :attachable_id
      t.string  :attachable_type, limit: 30

      t.timestamps
    end

    add_index "jquery_fu_rails_attachments", ["attachable_type", "attachable_id"], name: "attachable_type_attachable_id"
  end

  def self.down
    drop_table :jquery_fu_rails_attachments
  end
end
