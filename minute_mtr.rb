#!/usr/bin/ruby
dest = ARGV.first
def timestamp
  Time.now.strftime('%l:%M:%S').gsub("\s","")
end
while true do
  mtr = `mtr -b -r -c 1 #{dest}`
  File.open("out#{timestamp}.txt", 'w') do |f|
    f.write(mtr)
  end
  sleep 60
end

