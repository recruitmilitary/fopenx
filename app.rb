require 'sinatra'

# Link: http://a.recruitmilitary.com/www/delivery/ck.php?zoneid=75
# Image: http://a.recruitmilitary.com/www/delivery/avw.php?zoneid=75&cb=42
#
# Link: http://a.recruitmilitary.com/www/delivery/ck.php?zoneid=76
# Image: http://a.recruitmilitary.com/www/delivery/avw.php?zoneid=76

REDIRECTS = {
  '75' => 'http://pilot.vaforvets.com/?utm_source=recruitmilitary&utm_medium=banner&utm_content=250x250&utm_campaign=Telehealth',
  '76' => 'https://tsajobs.tsa.dhs.gov/tsajobs/TSAJobs.aspx',
}

IMAGE_EXT = {
  '75' => 'gif',
  '76' => 'jpeg',
}

ROOT_PATH = '/www/delivery'

# redirects links
get ROOT_PATH + '/ck.php' do
  zoneid = params[:zoneid]
  destination = REDIRECTS[zoneid] || 'http://recruitmilitary.com'
  redirect destination
end

# serves images
get ROOT_PATH + '/avw.php' do
  zoneid = params[:zoneid]
  if extension = IMAGE_EXT[zoneid]
    filename = "#{zoneid}.#{extension}"
    send_file filename
  else
    raise Sinatra::NotFound
  end
end
