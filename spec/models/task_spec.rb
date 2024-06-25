require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }

  before do
    Sidekiq::Testing.inline!
  end

  context 'when the task is in progress' do
    it 'schedules a 1 day alert' do
      task = create(:task, user: user, deadline: 2.days.from_now)

      expect(DeadlineAlertWorker).to receive(:perform_at).with(task.deadline - 1.day, task.id, '1 Day')
      
      task.save
    end

    it 'schedules a 1 hour alert' do
      task = create(:task, user: user, deadline: 2.hours.from_now)

      expect(DeadlineAlertWorker).to receive(:perform_at).with(task.deadline - 1.hour, task.id, '1 Hour')

      task.save
    end

    it 'sends a 1 hour alert immediately if less than 1 hour remains' do
      task = create(:task, user: user, deadline: 30.minutes.from_now)

      expect(DeadlineAlertWorker).to receive(:perform_async).with(task.id, '1 Hour')

      task.save
    end
  end

  context 'when the task is not in progress' do
    it 'does not schedule any alerts' do
      task = create(:task, user: user, status: 'backlog', deadline: 2.days.from_now)

      expect(DeadlineAlertWorker).not_to receive(:perform_at)
      expect(DeadlineAlertWorker).not_to receive(:perform_async)

      task.save
    end
  end
end
