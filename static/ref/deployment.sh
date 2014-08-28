cd webapps/findbball
git pull

# directions for deployment on webfaction
cd findbball_rails

export GEM_HOME=$PWD/gems
export RUBYLIB=$PWD/lib
export PATH=$PWD/bin:$PATH
gem install bundle
cd findbball
rake db:migrate RAILS_ENV=production
../bin/restart

#local production server:

rails s -e production

#production assets ( do locally )

rake assets:precompile RAILS_ENV=production







