module UnsplashImage
  module Helper
    extend self

    BASE = "https://source.unsplash.com/random".freeze

    def unsplash_image_url(size: nil, tags: nil)
      options = [BASE]

      options << size if size
      options << "?#{tags}" if tags

      options.join("/")
    end
  end
end
