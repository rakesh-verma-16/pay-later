# Runs all the test files and the tests in them.
Dir[File.dirname(File.absolute_path(__FILE__)) + '/**/*_tests.rb'].each {|file| require file }
