# app/models/task.rb
class Task < ApplicationRecord
  belongs_to :user

  enum status: { backlog: 'backlog', in_progress: 'in_progress', done: 'done' }

  validates :title, presence: { message: "Title can't be blank" }
  validates :description, presence: { message: "Description can't be blank" }
  validates :status, presence: { message: "Status can't be blank" }
  validates :deadline, presence: { message: "Deadline can't be blank" }

  after_save :schedule_deadline_alerts

  private

  def schedule_deadline_alerts
    puts "Scheduling alerts for task ##{self.id} with status #{self.status}"
    if self.deadline.present? && self.status == 'in_progress'
      Rails.logger.info "Scheduling alerts for task ##{self.id}"

      # Cancel existing scheduled jobs for this task
      Sidekiq::ScheduledSet.new.each do |job|
        if job.args[0] == self.id
          job.delete 
        end
      end

      # Calculate time difference
      time_to_deadline = self.deadline - Time.current
      puts "Time to deadline: #{time_to_deadline} seconds"

      # Schedule alerts only if time permits, otherwise send immediately
      if time_to_deadline > 1.day
        Rails.logger.info "Scheduling 1 day alert for task ##{self.id}"
        puts "Scheduling 1 day alert for task ##{self.id}"
        DeadlineAlertWorker.perform_at(self.deadline - 1.day, self.id, '1 Day')
      elsif time_to_deadline > 1.hour
        Rails.logger.info "Scheduling 1 hour alert for task ##{self.id}"
        puts "Scheduling 1 hour alert for task ##{self.id}"
        DeadlineAlertWorker.perform_at(self.deadline - 1.hour, self.id, '1 Hour')
      elsif time_to_deadline > 0
        Rails.logger.info "Scheduling immediate 1 hour alert for task ##{self.id}"
        puts "Scheduling immediate 1 hour alert for task ##{self.id}"
        DeadlineAlertWorker.perform_async(self.id, '1 Hour')
      else
        puts "Deadline is in the past or too close to schedule alerts for task ##{self.id}"
      end
    end
  end
end
