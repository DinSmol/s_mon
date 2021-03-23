require 'sinatra/activerecord'

configure :production, :development do
  db = URI.parse('postgresql://din:password@db:5432/servers?')
  pool = 5
  ActiveRecord::Base.establish_connection(
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:      db.host,
    port:      db.port || 5432,
    username:  db.user,
    password:  db.password,
    database:  db.path[1..-1],
    encoding:  'utf8',
    pool:      pool
  )
end