#!/usr/bin/ruby
hdest,fsdest = ARGV
if ARGV.empty?
  puts "Improper usage!!"
  puts "Usage is minute_mtr.rb DESTINATION FILE_DEST"
  puts "Example minute_mtr.rb google.com /var/tmp/"
abort
end
def tstamp
  Time.now.strftime('%H:%M__%m-%d-%y').gsub("\s","")
end
while true do
  mtr = `mtr -n -r -c 10 #{hdest}`
  File.open("#{fsdest}#{hdest}__#{tstamp}.txt", 'w') { |f| f.write(mtr)}
  sleep 60
end

