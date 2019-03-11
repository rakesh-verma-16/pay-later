require_relative 'model/Entities'

path = %x(realpath ~/.bash_profile)

open(path.gsub("\n", ""), 'a') do |file|
	file.puts "\n"
	file.puts "alias new='ruby CreateObject.rb'"
	file.puts "alias update='ruby UpdateObject.rb'"	
	file.puts "alias payback='ruby Payback.rb'"
	file.puts "alias report='ruby Report.rb'"
end

system("source ~/.bash_profile")

Entities.create_table	