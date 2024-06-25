class DeadlineAlertWorker
    include Sidekiq::Worker
  
    def perform(task_id, time_frame)
      task = Task.find(task_id)
      TaskMailer.deadline_alert(task, time_frame).deliver_now if task.status == 'in_progress'
    end
  end
  