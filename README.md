# Unsplash Image Downloader & Helpers

[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)

[!["Buy Me A Coffee"](https://github.com/igorkasyanchuk/get-smart/blob/main/docs/snapshot-bmc-button-small.png?raw=true)](https://buymeacoffee.com/igorkasyanchuk)

A CLI and a set of Rails helpers to get free images from [Unsplash](https://unsplash.com/).

This is the easiest way to fill your Rails app with real photos.

## Usage

1. as Rails helper to generate dummy images:
```ruby
<%= image_tag unsplash_image_url(size: '300x200', tags: 'cat, dog') %>

<%= image_tag unsplash_image_url(size: '800x600', tags: 'building') %>

<%= image_tag unsplash_image_url(tags: 'nature') %>
```

2. as a tool to download images from Unsplash.com and use them for your seeds or specs.

```bash
unsplash_image download --path images/cats --tags cat -n 20
```

3. If you need to have a `File` object with a random image.

```ruby
file = UnsplashImage.tempfile(size: '500x500', tags: 'cat')
```

### CLI

By default `unsplash_image download  --path ./files` will download 10 random images into a `./files` folder.

You can see list of all available options by running:


```bash
unsplash_image --help download
```

With additional options you can specify a destination folder, tags, resolution of the images.


### In your Rails app

You can get random image url inside your views using `unsplash_image_url`.

Example:
```erb
<%= image_tag unsplash_image_url(size: '300x200', tags: 'cat, dog') %>
```

Also you can get it as a file with `UnsplashImage.tempfile`.

Example:
```ruby
file = UnsplashImage.tempfile(size: '500x500', tags: 'cat')
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem "unsplash_image"
```

And then execute:
```bash
$ bundle
```

To use CLI anywhere in the system you can install gem globally:

```bash
gem install unsplash_image
```

## Unit Tests

We have simple tests, just run: `ruby test/unsplash_image_test.rb`.

## Contributing

You are welcome to contribute. See list of `TODO's` below.

## TODO

- allow caching downloaded files for performance improvement (eg using in factories)
- check with older Rails versions
- tests or specs
- make stand-alone executable installable via `brew`, `apt get`, etc?

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/?utm_source=github&utm_medium=bottom&utm_campaign=unsplash_image)

[!["Buy Me A Coffee"](https://github.com/igorkasyanchuk/get-smart/blob/main/docs/snapshot-bmc-button.png?raw=true)](https://buymeacoffee.com/igorkasyanchuk)
