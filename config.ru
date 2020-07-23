require './config/environment'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride #needed to use patch, put or delete

use DeliveryController
use RecepientController
use VolunteerController
run ApplicationController
