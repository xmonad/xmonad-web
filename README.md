# xmonad-web: the website for the xmonad window manager

The website for [xmonad.org](https://xmonad.org).

## Requirements

The website is built with [Jekyll](https://jekyllrb.com/). Check their website
to get started.

The tl;dr is the following:

1. Install `ruby`, `ruby-dev(el)` and `bundler` on your system. Depending on
   your distribution, `bundler` might not be packaged and may need to be
   installed manually via `gem`:

   ```console
   $ gem install --user bundler
   ```

   Make sure to add the necessary directories to your `$PATH`!

2. Build the website with

   ```console
   $ make
   ```

   This uses `bundler` to get all the necessary Jekyll extensions to
   replicate a GitHub Pages setup locally. The result will be in `./_site`.

3. For an interactive editing session with live reloads in your browser, use

   ```console
   $ make serve
   ```

   This serves a browsable local copy of the website—and your changes
   thereof—on `http://127.0.0.1:4000`.

## Application Structures

All the `.md` files in the root (except for `README.md`) will
be converted into `html` files. These go at the root of the
website. The `css` directory has custom styles.
Images should go in the `images` directory.

The videos that are linked in `videos.html` are hardcoded in
the `_data/videos.yml`

The `_site` directory is a place for the Jekyll output.

## Contributing

Contributions to the content as well as to the looks of the website are welcome!
Please don't check the `_site` folder, as *it will be overwritten while
deploying the website*. Check our [contributing
guidelines](https://github.com/xmonad/xmonad/blob/master/CONTRIBUTING.md#rebasing-and-squashing-commits)
for information on rebasing and squashing commits.

## Swags of Hacktoberfest:
- Many of the candidates get attracted towards hacktoberfest to get swags . So, after 4 successfully merged pull request as for 2021 you will be eligible to get a Hacktoberfest T-shirt and Some stickers on your doorstep.
 
     <li><B><p><img src="https://miro.medium.com/max/1050/1*4JctIO7irt8hFxBmTvUpiQ.jpeg" width="400" height="225" style="width: 400px; height: 225px;" alt="tshirt image"></a></p><p><img src="https://miro.medium.com/max/1050/1*jkffr74bq5RsQ_xqDhgqYQ.jpeg" width="400" height="225" style="width: 400px; height: 225px;" alt="stickers image"></p>
</b></li>
