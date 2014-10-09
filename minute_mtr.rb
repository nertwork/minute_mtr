#!/usr/bin/ruby
unless ARGV.size == 3
  puts "Usage is minute_mtr.rb <DESTINATION> <FILE_DEST> <MAX HOURS>"
  puts "Example minute_mtr.rb google.com /var/tmp/ 168 &"
  exit 1
end
hdest, fsdest, max_age = ARGV[0],ARGV[1],ARGV[2].to_i
unless File.exists?(fsdest)
  puts "Bad directory #{fsdest}!"
  exit 2
end
unless max_age > 0
  puts "Max age must be greater than zero! I don't want to remove ALL your files!"
  exit 3
end
def f_age(name)
  age = (Time.now - File.ctime(name))/(3600)
end
def tstamp
  Time.now.strftime('%H:%M__%m-%d-%y').gsub("\s","")
end
while true do
  pid = fork do 
    mtr = `mtr -n -r -c 10 #{hdest}`
    File.open("#{fsdest}#{hdest}__#{tstamp}.mtr.txt", 'w') { |f| f.write(mtr)}
  end
  Process.detach(pid)
  Dir.chdir(fsdest)
  Dir.glob('*.mtr.txt').each { |filename| File.delete(filename) if f_age(filename) > max_age }
  sleep 60
end

