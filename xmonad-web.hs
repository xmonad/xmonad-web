--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend, (<>))
import           Hakyll


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith xmonadConfiguration $ do
    {-match "assets/img/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "assets/css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.rst", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls-}


    match "index.md" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

        {-compile $ do
            --posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx = constField "title" "xmonad | the tiling window manager that rocks"
                        <> defaultContext
                    --listField "posts" postCtx (return posts) `mappend`

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls-}

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

xmonadConfiguration :: Configuration
xmonadConfiguration = defaultConfiguration
  { providerDirectory    = "src/"
  , destinationDirectory = "app/html/"
  , storeDirectory       = "app/stores/"
  , tmpDirectory         = "app/tmp/"
  , deployCommand        = unwords
                         [ "cp -r app/html/ ../xmonad-html/ &&"
                         , "git checkout gh-pages &&"
                         , "cp -rf ../xmonad-html/* . &&"
                         , "rm -r ../xmonad-html/ &&"
                         , "git status"
                         ]
  }

