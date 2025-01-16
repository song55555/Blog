module ApplicationHelper
    def vite_dev_server_url
      if Rails.env.development?
        "http://localhost:5173"
      end
    end
  end