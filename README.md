# Hakyll >>= xmonad-web
A Hakyll application for the
[xmonad-web](https://github.com/xmonad/xmonad-web)
repository.

## Requirements
- Haskell (ghc-8.0.2 or higher)
- Hakyll

As a suggestion, please use
[The Haskell Tool Stack](https://docs.haskellstack.org/en/stable/README/).

## Installation
First, we need to clone this branch.

```
git clone -b rebuild-xmonad-web --single-branch https://github.com/wisn/xmonad-web.git
```

Then, open the clonned repository.

```
cd xmonad-web
```

### Stack
Using Stack, run this command.

```
stack install
```

### Cabal
If you have no Stack and install Haskell in a different way,
please make sure that you have Cabal instead.
Using Cabal, run this command.

```
cabal install
```

## Verify
Try to run `xmonad-web` command. You should see something like this.

```
Missing: COMMAND

Usage: xmonad-web [-v|--verbose] COMMAND
  xmonad-web - Static site compiler created with Hakyll

Available options:
  -h,--help                Show this help text
  -v,--verbose             Run in verbose mode

Available commands:
  build                    Generate the site
  check                    Validate the site output
  clean                    Clean up and remove cache
  deploy                   Upload/deploy your site
  preview                  [DEPRECATED] Please use the watch command
  rebuild                  Clean and build again
  server                   Start a preview server
  watch                    Autocompile on changes and start a preview server.
                           You can watch and recompile without running a server
                           with --no-server.
```

## Application Structures
```
xmonad-web
├── app
│   ├── html
│   ├── stores
│   └── tmp
└── src
    ├── assets
    │   ├── css
    │   ├── img
    │   └── js
    ├── posts
    └── templates
```

The `app` directory is a place for the Hakyll output.
As you can see, `app/html` is a place for the generated HTML.
Both `app/stores` nor `app/tmp` is a place for the Hakyll *caches*.

So, the main source files is located at the `src` directory.

## Generating the Website
When you have done some changes, run `xmonad-web build` command.
The HTML files will be generated and copied to the `app/html` directory.

## Preview the Website
You may use `xmonad-web server` command.
But, it's better to use `xmonad-web watch` command.

## Deploying the Website
When you finished, please deploy the website.
The generated website a.k.a `app/html` directory will be copied to the
`gh-pages` branch. Use `xmonad-web deploy` command to do that.
Are you curious what exactly `deploy` command do? Here is it:

```
cp -r app/html/ ../xmonad-html/ && git checkout gh-pages && cp -rf ../xmonad-html/* . && rm -r ../xmonad-html/ && git status
```

After running the `deploy` command, you will see the changes via
`github status` command. Give a commit and then push them.
Don't forget to switch back to your previous branch manually.

## License
Released under the MIT License.
Created by [Wisnu Adi Nurcahyo](https://github.com/wisn/).
