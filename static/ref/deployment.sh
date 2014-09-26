
#local production server:

rails s -e production

#production assets ( do locally )

rake assets:precompile RAILS_ENV=production



cd webapps/findbball_rails/findbball
git pull

# directions for deployment on webfaction
cd webapps/findbball_rails  or  cd ../

export GEM_HOME=$PWD/gems
export RUBYLIB=$PWD/lib
export PATH=$PWD/bin:$PATH
gem install bundle
cd findbball
bundle install
rake db:migrate RAILS_ENV=production
../bin/restart


#troubleshooting ,

check the files in .gitignore



on production

tail -f /home/thornybranch/webapps/findbball_rails/nginx/logs/error.log





