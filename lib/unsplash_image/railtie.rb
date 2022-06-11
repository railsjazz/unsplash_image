module UnsplashImage
  class Railtie < ::Rails::Railtie
    initializer "unsplash_image.helpers", before: :load_config_initializers do
      ActiveSupport.on_load :action_view do
        include UnsplashImage::Helper
      end
    end
  end
end
