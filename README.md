# xmonad-web: the website for the xmonad window manager
The website for [xmonad.org](https://xmonad.org).

## Requirements
The website is built with [Jekyll](https://jekyllrb.com/). Check their website
to get started.

The tl;dr is the following:

1. Install some form of `ruby` (and possibly `ruby-devel`) on your
   system.

2. Install `bundler` and `jekyll` with

   ``` shell
     $ gem install --user bundler jekyll
   ```

   Make sure to add the necessary directories to your `$PATH`!

3. Install the required gems locally; you must be in the `xmonad-web`
   directory for this:

   ``` shell
     $ bundle config set --local path '.bundle/xmonad-gems'
     $ bundle install
   ```

4. Build the website with

   ``` shell
     $ bundle exec jekyll serve
   ```

   This should create a browsable copy of the website—and your changes
   thereof—on `http://127.0.0.1:4000`.

## Application Structures

All the `.md` files in the root (except for `README.md`) will
be converted into `html` files. These go at the root of the
website. The `css` directory has custom styles, as well as
`bootstrap.min.css` for [Bootstrap](https://getbootstrap.com/).
Image should go in the `images` directory.

The videos that are linked in `videos.html` are hardcoded in
the `_data/videos.yml`

The `_site` directory is a place for the Jekyll output.

## Contributing
Contributions to the content as well as to the looks of the website are welcome!
Please don't check the `_site` folder, as *it will be overwritten while
deploying the website*. Check our [contributing
guidelines](https://github.com/xmonad/xmonad/blob/master/CONTRIBUTING.md#rebasing-and-squashing-commits)
for information on rebasing and squashing commits.
