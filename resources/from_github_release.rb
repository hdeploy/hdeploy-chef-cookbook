# Made this old style rather than new style because this way
# is it compatible with chef 11 and also early versions of chef 12.

actions :install
default_action :install

attribute :package,    kind_of: String, required: true, name_property: true
attribute :version,    kind_of: String, required: true
attribute :repository, kind_of: String, required: true
