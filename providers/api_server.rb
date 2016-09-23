# Made this old style rather than new style because this way
# is it compatible with chef 11 and also early versions of chef 12.

require 'uri'

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  converge_by "run hdeploy::server recipe" do
    run_context.include_recipe 'hdeploy::server'
  end
end
