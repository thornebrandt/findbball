# directions for deployment
cd findbball_rails

export GEM_HOME=$PWD/gems
export RUBYLIB=$PWD/lib
export PATH=$PWD/bin:$PATH
gem install bundle
cd findbball
rake db:migrate RAILS_ENV=production
../bin/restart





