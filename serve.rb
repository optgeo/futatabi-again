require './constants'
require 'sqlite3'
require 'sinatra'

DB = SQLite3::Database.new(MBTILES_FN)

def get_tile(z, x, y)
  tile_row = 2 ** z.to_i - y.to_i - 1
  tile = DB.execute <<-EOS
SELECT tile_data FROM tiles WHERE \
zoom_level=#{z} AND tile_column=#{x} AND tile_row=#{tile_row}
  EOS
  tile[0] ? tile[0][0] : 404
end

get "/zxy/:z/:x/:y.#{EXT}" do |z, x, y|
  content_type #{CONTENT_TYPE}
  response.headers['Content-Type'] = CONTENT_TYPE
  get_tile(z, x, y)
end

