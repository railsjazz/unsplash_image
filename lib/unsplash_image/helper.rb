module UnsplashImage
  module Helper
    BASE = "https://source.unsplash.com/random".freeze

    def unsplash_image_url(size:, tags: nil)
      options = [BASE]

      options << size
      options << "?#{tags}" if tags

      options.join("/")
    end
  end
end
