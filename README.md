# README
# Healing Home Backend

## Requirements

- Ruby 3.3.7
- Rails 8.0.2
- PostgreSQL 
- Node.js v20.19.1
- Frontend (React) must be running on `http://localhost:3001`

## Setup Instructions

1. **Install PostgreSQL**
- Make sure PostgreSQL is installed and running on your system.
- Set your password during setup.
- You can set the `PGPASSWORD` environment variable in GitBash before running commands by using:

  export PGPASSWORD=your_postgres_password

2. **Download code**  
- In GitBash use cd command to navigate into downloaded project directory

3. **Install dependencies**  
- In GitBash run:

  bundle install

4. **Create and set up the database**  
- In GitBash run the following commands one by one:

 rails db:create
 rails db:migrate
 rails db:seed


5. **Start the Rails server**  
- In GitBash run:

 rails -s

 or
 
 rails server -p 3000

- to explicity ensure it runs on the required localhost:3000

The backend should be available at http://localhost:3000

## Notes

- This is a backend-only Rails app — there are no frontend views.
- CSRF has been disabled for development; it should be enabled before deployment.
- Run the Healing Home frontend React app on localhost:3001.
- Make sure PostgreSQL is running before starting the app.
- The seed file includes an admin user, example recipes, plants, and other data for testing.
- If you see a database connection error, make sure the PostgreSQL user and password match 
  what's expected in `config/database.yml`.
- If using Git Bash, make sure to export `PGPASSWORD` in the same terminal session where you 
  run the server or setup commands.

## Development Info

- Port: `3000`
- Default test admin user:  
    - Email: admin@example.com  
    - Password: password



