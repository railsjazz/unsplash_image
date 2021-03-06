require "open-uri"
require "tempfile"

module UnsplashImage
  module Download
    def tempfile(size: nil, filename: "image.jpeg", tags: nil)
      file = Tempfile.new(filename, binmode: true)
      begin
        file.write(URI.parse(UnsplashImage::Helper.unsplash_image_url(size: size, tags: tags)).read)
        file.rewind
        if block_given?
          yield file
        else
          file
        end
      ensure
        if block_given?
          file.close
          file.unlink
        end
      end
    end
  end

  extend Download
end
