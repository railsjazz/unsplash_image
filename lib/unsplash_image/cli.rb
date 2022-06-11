require "thor"

require "unsplash_image"
require "pathname"

module UnsplashImage
  class CLI < Thor
    package_name "UnsplashImage"

    map "-d" => :download
    map "--download" => :download

    default_task :info

    desc :info, "Print info about cli"

    method_option :version, type: :boolean, default: false, aliases: [:v], banner: "Print UnsplashImage version"
    def info
      if options[:version]
        puts "UnsplashImage #{UnsplashImage::VERSION}"
      else
        info = [
          "UnsplashImage #{UnsplashImage::VERSION}",
          "",
          "Usage example: ",
          "    unsplash_image download --path images/cats -s 400x400 --tags cat -n 20",
          "",
          "run 'unsplash_image download' to see awailable options"
        ]
        puts info.join("\n")
      end
    end

    desc "download [OPTIONS]", "Download Unsplash images"

    long_desc <<-LONGDESC
      `unsplash_image download` will download random unsplash images on your PC

      Example:

      > $ unsplash_image download --path images/cats -s 400x400 --tags cat -n 20
    LONGDESC

    DEFAULT_COUNT = 1
    DEFAULT_PATH = "."

    method_option :size, type: :string, aliases: [:s], banner: "Specify image size. Example: -s 500x500"
    method_option :count, type: :numeric, aliases: [:n], banner: "Specify images count. Example: -n 10"
    method_option :path, type: :string, banner: "Specify folder. Example: --path images/cats"
    method_option :tags, type: :array, aliases: [:t], banner: "Specify tags. Example: -t cats"
    method_option :prefix, type: :string, banner: "Specify file name prefix. Example: --prefix cat_image"
    def download
      if options.keys.empty?
        invoke :help, ["download"]
      else
        prefix = if !!options[:prefix]
          options[:prefix]
        else
          !(options[:tags].nil? || options[:tags].empty?) ? options[:tags].join("_") : "image"
        end
        tags = options[:tags]&.join(" ").to_s

        base_path = Pathname.new(options[:path] || DEFAULT_PATH)
        FileUtils.mkdir_p(base_path)

        puts "Downloading images to #{base_path.absolute? ? base_path : base_path.realpath.relative_path_from(Dir.pwd)}"
        count = (options[:count] || DEFAULT_COUNT).to_i
        count.times do |i|
          filename = count == 1 ? "#{prefix}.jpeg" : "#{prefix}_#{i + 1}.jpeg"
          filename = filename.encode(Encoding::UTF_8, invalid: :replace, undef: :replace, replace: "�").strip.tr("\u{202E}%$|:;/\t\r\n\\", "-")
          path = File.expand_path(filename, base_path)
          puts "Downloading #{filename}"
          UnsplashImage.tempfile(size: options[:size], filename: filename, tags: tags + (" " * i)) do |tempfile|
            File.write(path, tempfile.read)
          end
        end
        puts "Done!"
      end
    end

    class << self
      def exit_on_failure?
        true
      end
    end
  end
end
