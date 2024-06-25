# Task Management Application

This is a Task Management web application built using Ruby on Rails. The application allows users to manage their tasks with features such as user authentication, task states, deadlines, and email alerts. The project includes test cases and a README file explaining the code structure.

## Features
- User authentication with Devise
- Task creation, editing
- Task states: Backlog, In-progress, Done
- Task deadlines with email alerts
- Responsive and user-friendly UI
- Background jobs with Sidekiq

## Requirements
- Ruby 3.0.2
- Rails 7.1.3
- PostgreSQL
- Redis (for Sidekiq)
- Node.js and Yarn

## Setup
1. **Clone the repository:**
   ```sh
   git clone https://github.com/Tejonidhi/Task-Management.git
   cd Task-Management

2. **Install Depedenices:**
    bundle install
    yarn install
3. ***Setup Database*
    rails db:create
    rails db:migrate
    rails db:seed

Usage
    Access the application:
    Open your browser and navigate to http://localhost:3000.

Sign up or log in:
    Use the Devise authentication system to sign up or log in.

Manage tasks:
    Create new tasks.
    Edit existing tasks.
    Mark tasks as Backlog, In-progress, or Done.
    Set deadlines for tasks and receive email alerts.

Background Jobs
    Sidekiq is used for background processing.
    Redis is required for running Sidekiq.
