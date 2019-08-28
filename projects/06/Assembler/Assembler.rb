require('./Main.rb');

filename = ARGV.first

x = Main.new(filename)
x.parse()
