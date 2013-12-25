class JqueryFuRails::Attachment < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  self.table_name = :jquery_fu_rails_attachments

  belongs_to :attachable, polymorphic: true

  mount_uploader :file, JqueryFuRailsAttachmentUploader, mount_on: :file_name

  delegate :url, :current_path, :size, :content_type, :filename, to: :file

  validates_presence_of :file

  attr_accessible :file, :attachable_type, :attachable_id, :assetable

  scope :by_attachable, ->(objs) {
    arel = nil
    objs.each do |obj|
      one_arel = arel_table[:attachable_id].eq(obj.id).and(arel_table[:attachable_type].eq(obj.class.to_s))
      if arel.nil?
        arel = one_arel
      else
        arel = arel.or(one_arel)
      end
    end
    where(arel)
  }

  def to_jqueryfu
    {
      "name" => read_attribute(:file_name),
      "size" => read_attribute(:file_size),
      "url" => file.url(:thumb),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE"
    }
  end
end
