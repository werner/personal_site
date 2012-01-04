desc "Builds the minified CSS and JS assets."
task :minify do
  require './main.rb'   # <= change this
  puts "Building..."

  files = Sinatra::Minify::Package.build(Main)  # <= change this
  files.each { |f| puts " * #{File.basename f}" }
  puts "Construction complete!"
end