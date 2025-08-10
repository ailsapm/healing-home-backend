Rails.application.config.session_store :cookie_store,  #use browser cookies to store session data
  key: "_healing_home_session",  #giving the cookie a name
  same_site: :none,  #to send cookie because backend on 3000 and frontend on 3001
  secure: false  # if true cookie only gets sent over https - change to true for production but false for right now