namespace :db do
  task import: :environment do
    system "heroku pg:backups:capture"
    system "heroku pg:backups:download"
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d school_development latest.dump"
    system "rm latest.dump*"
  end
end
