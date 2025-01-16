Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src    :self, :https, :data
    policy.img_src     :self, :https, :data
    policy.object_src  :none
    policy.script_src  :self, :https, :unsafe_inline 
    policy.style_src   :self, :https, :unsafe_inline
    policy.connect_src :self, :https, :ws, :wss, 'http://localhost:5173', 'ws://localhost:5173', 'wss://localhost:5173'
 end