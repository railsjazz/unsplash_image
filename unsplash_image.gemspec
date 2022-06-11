require_relative "lib/unsplash_image/version"

Gem::Specification.new do |spec|
  spec.name        = "unsplash_image"
  spec.version     = UnsplashImage::VERSION
  spec.authors     = ["Igor Kasyanchuk", "Liubomyr Manastyretskyi"]
  spec.email       = ["igorkasyanchuk@gmail.com", "manastyretskyi@gmail.com"]
  spec.homepage    = "https://github.com/railsjazz/unsplash_image"
  spec.summary     = "Show the random images in your Rails app or download them to use for seeding a DB"
  spec.description = "Show the random images in your Rails app or download them to use for seeding a DB"
  spec.license     = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.executables << "unsplash_image"

  spec.add_dependency "rails"
  spec.add_dependency "thor", ">= 0.20"

  spec.add_development_dependency "faker"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "puma"
end
