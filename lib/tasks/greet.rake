task :greet do
   puts "Hello world"
   Rake::Task['greetquery'].invoke
end

task :greetquery do
   puts "How are you?"
end