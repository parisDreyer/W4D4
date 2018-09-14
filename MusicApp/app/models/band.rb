# == Schema Information
#
# Table name: bands
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Band < ApplicationRecord

  validates :name, optional: false

  belongs_to :band_member,
    primary_key: :id,
    foreign_key: :member_id,
    class_name: :User


end
