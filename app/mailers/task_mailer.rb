# app/mailers/task_mailer.rb

class TaskMailer < ApplicationMailer
default from: 'tejonidhi1997@gmail.com' # Replace with your Gmail email
  
    def deadline_alert(task, time_frame)
      @task = task
      @time_frame = time_frame
      mail(to: @task.user.email, subject: "Task Deadline Alert - #{@time_frame}")
    end
  end
  