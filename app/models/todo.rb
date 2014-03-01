class Todo < ActiveRecord::Base
  validates_presence_of :title
  scope :unarchived, -> { where(archived: false).order('completed, created_at') }
  scope :archived, -> { where(archived: true).order('completed, created_at') }

  def complete!
    self.completed = true
    save!
  end

  def archive!
    self.archived = true
    save!
  end
end
