# Made this old style rather than new style because this way
# is it compatible with chef 11 and also early versions of chef 12.

actions :create
default_action :create

attribute :url,  kind_of: String, required: true
attribute :user, kind_of: String, required: true
attribute :pass, kind_of: String, required: true

