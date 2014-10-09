#!/usr/bin/ruby
hdest,fsdest = ARGV
def tstamp
  Time.now.strftime('%H:%M__%m-%d-%y').gsub("\s","")
end
while true do
  mtr = `mtr -b -r -c 1 #{hdest}`
  File.open("#{fsdest}#{hdest}__#{tstamp}.txt", 'w') { |f| f.write(mtr)}
  sleep 5
end

