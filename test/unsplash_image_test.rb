require_relative "test_helper"

class UnsplashImageTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert UnsplashImage::VERSION
  end

  test "temp file" do
    assert_nothing_raised do
      UnsplashImage.tempfile
    end
  end

  test "helper" do
    assert_nothing_raised do
      UnsplashImage::Helper.unsplash_image_url(size: '500x500')
    end
  end
end
