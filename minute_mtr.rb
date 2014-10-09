#!/usr/bin/ruby
class String
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
end

unless ARGV.size == 3
  print "Usage is minute_mtr.rb ".blue
  puts "<DESTINATION> <FILE_DEST> <MAX HOURS>".cyan
  print "Example minute_mtr.rb ".blue
  puts "google.com /var/tmp/ 168 & ".green
  exit 1
end
hdest, fsdest, max_age = ARGV[0],ARGV[1],ARGV[2].to_i
unless File.exists?(fsdest)
  puts "Bad directory #{fsdest}!"
  exit 2
end
unless max_age > 0
  puts "Max age must be greater than zero! I don't want to remove ALL your files!".red
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

