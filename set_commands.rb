require_relative 'model/Entities'

path = %x(realpath ~/.bash_profile)

open(path.gsub("\n", ""), 'a') do |file|
	file.puts "\n"
	file.puts "alias new='ruby /usr/bin/simpl/services/Create.rb'"
	file.puts "alias update='ruby /usr/bin/simpl/services/Update.rb'"	
	file.puts "alias payback='ruby /usr/bin/simpl/services/Payback.rb'"
	file.puts "alias report='ruby /usr/bin/simpl/services/Report.rb'"
end

Entities.create_table	