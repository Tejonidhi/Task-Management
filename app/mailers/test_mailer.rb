# app/mailers/test_mailer.rb

class TestMailer < ApplicationMailer
    default from: 'tejonidhi1997@gmail.com' # Replace with your Gmail email
  
    def welcome_email
      mail(to: 'tejonidhi1997@gmail.com', subject: 'Test Email')
    end
  end
  