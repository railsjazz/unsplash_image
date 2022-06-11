require "thor"

require "unsplash_image"
require "pathname"

module UnsplashImage
  class CLI < Thor
    package_name "UnsplashImage"

    default_task :info

    desc :info, "Print info about cli"

    method_option :version, type: :boolean, default: false, aliases: [:v], banner: "Print UnsplashImage version"
    def info
      if options[:version]
        puts "UnsplashImage #{UnsplashImage::VERSION}"
      else
        info = [
          "UnsplashImage #{UnsplashImage::VERSION}",
          "run 'unsplash_image --help' to see awailable options"
        ]
        puts info.join("\n")
      end
    end

    desc :download, "Download Unsplash images"

    method_option :size, type: :string, default: "500x500", aliases: [:s], banner: "Specify image size"
    method_option :count, type: :numeric, default: 1, aliases: [:n], banner: "Specify images count"
    method_option :path, type: :string, default: ".", banner: "Specify folder", required: true
    method_option :tags, type: :array, banner: "Specify tags"
    method_option :prefix, type: :string, banner: "Specify file name prefix"
    def download
      prefix = if !!options[:prefix]
        options[:prefix]
      else
        !(options[:tags].nil? || options[:tags].empty?) ? options[:tags].join("_") : "image"
      end
      tags = options[:tags]&.join(" ").to_s

      FileUtils.mkdir_p(options[:path])

      base_path = Pathname.new(options[:path])
      puts "Downloading images to #{base_path.absolute? ? base_path : base_path.realpath.relative_path_from(Dir.pwd)}"
      options[:count].to_i.times do |i|
        filename = options[:count].to_i == 1 ? "#{prefix}.png" : "#{prefix}_#{i + 1}.png"
        path = File.expand_path(filename, base_path)
        puts "Downloading #{filename}"
        UnsplashImage.tempfile(size: options[:size], filename: filename, tags: tags + (" " * i)) do |tempfile|
          File.write(path, tempfile.read)
        end
      end
      puts "Done!"
    end

    class << self
      def exit_on_failure?
        true
      end
    end
  end
end
