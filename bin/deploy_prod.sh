#!/bin/sh

heroku maintenance:on --app bagel-central-lg
heroku scale web=0 --app bagel-central-lg
git push git@heroku.com:bagel-central-lg.git $CIRCLE_SHA1:refs/heads/master
heroku run rake db:migrate --app bagel-central-lg
heroku scale web=1 --app bagel-central-lg
heroku maintenance:off --app bagel-central-lg
