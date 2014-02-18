class Todo < ActiveRecord::Base
  validates_presence_of :title
  scope :unarchived, -> { where(archived: false) }

  def complete!
    self.completed = true
    save!
  end
end
