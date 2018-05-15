class SettingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :receive_emails_for_likes, :receive_emails_for_follows, :receive_emails_from_emerged
  belongs_to :user
end
