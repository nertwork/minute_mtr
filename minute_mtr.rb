#!/usr/bin/ruby
dest,filename  = ARGV
def timestamp
  Time.now.strftime('%l:%M:%S').gsub("\s","")
end
while true do
  mtr = `mtr -b -r -c 1 #{dest}`
  File.open("#{filename}#{timestamp}.txt", 'w') do |f|
    f.write(mtr)
  end
  sleep 60
end

