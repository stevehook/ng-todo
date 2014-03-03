class Todo < ActiveRecord::Base
  validates_presence_of :title
  scope :unarchived, -> { where(archived: false).order('completed, created_at') }
  scope :archived, -> { where(archived: true).order('completed, created_at') }
  after_initialize :set_defaults

  def complete!
    self.completed = true
    save!
  end

  def archive!
    self.archived = true
    save!
  end

  private

  def set_defaults
    self.complete_by ||= (Date.today + 1.day) if new_record?
  end
end
