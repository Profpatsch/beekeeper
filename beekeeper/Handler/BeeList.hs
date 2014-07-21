{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

module Handler.BeeList where

import Import
import Beehive

getBeeListR :: Handler Html
getBeeListR = defaultLayout $ do
  setTitle "Lemonade"
  $(widgetFile "bees") 
    where bees = [bee1, bee2, bee3]
          bee1 = Bee "Default" "DefaultClass" [] "Description"
          bee2 = defaultBee
          bee3 = bee1
