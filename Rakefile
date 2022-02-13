require './constants'

desc 'create GeoTIFF file'
task :tif do
  sh <<-EOS
gdalwarp -s_srs #{SRS} #{SRC_PATH} #{TIF_PATH}
  EOS
end

desc 'create MBTiles'
task :mbtiles do
  sh <<-EOS
docker run -ti --rm -v #{HERE_DIR}:#{MOUNT_DIR} unvt/rgbify \
rasterio rgbify -b -10000 -i 0.1 --max-z 17 --min-z 8 \
--format webp --verbose \
#{MOUNT_DIR}/#{TIF_FN} #{MOUNT_DIR}/#{MBTILES_FN}
  EOS
end

desc 'serve'
task :serve do
  sh <<-EOS
ruby serve.rb -p #{PORT}
  EOS
end