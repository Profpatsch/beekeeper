-- | Model the beehive datatypes.
{-# LANGUAGE OverloadedStrings #-}

module Beehive where

import Control.Applicative
import Control.Monad
import Data.Aeson
import Data.Maybe
import Data.Text
import Prelude
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy.Char8 as BL

data Config = Config [Bee] [Chain] deriving (Show)

instance FromJSON Config where
  parseJSON (Object v) = Config
                       <$> v .: "Bees"
                       <*> v .: "Chains"
  parseJSON _ = mzero

instance ToJSON Config where
  toJSON (Config beeL chainL) = object ["Bees" .= beeL, "Chains" .= chainL]


data Bee = Bee { beeName :: Text
               , beeKind :: Text
               , beeOptions :: [Option]
               , beeDescription :: Text } deriving (Show)

testConfig :: FilePath -> IO ()
testConfig cfg = do
  config <- parseConfig cfg
  print config
  BL.putStrLn $ encode config

parseConfig :: FilePath -> IO Config
parseConfig cfg = do
  contents <- B.readFile cfg
  either error return $ eitherDecodeStrict contents

instance FromJSON Bee where
  parseJSON (Object v) = Bee
                         <$> v .: "Name"
                         <*> v .: "Class"
                         <*> v .: "Options"
                         <*> v .: "Description"
  parseJSON _ = mzero

instance ToJSON Bee where
  toJSON (Bee name kind options description) =
    object ["Name" .= name, "Class" .= kind,
            "Options" .= options, "Description" .= description]


data Chain = Chain { chainName :: Text
                   , chainEvent :: Event
                   , chainElements :: [Element]
                   , chainDescription :: Text } deriving (Show)

instance FromJSON Chain where
  parseJSON (Object v) = Chain
                         <$> v .: "Name"
                         <*> v .: "Event"
                         <*> v .: "Elements"
                         <*> v .: "Description"
  parseJSON _ = mzero

instance ToJSON Chain where
  toJSON (Chain name event elements description) =
    object ["Name" .= name, "Event" .= event, "Elements" .= elements,
            "Description" .= description]


data Event = Event { eventBee :: Text
                   , eventName :: Text } deriving (Show)

instance FromJSON Event where
  parseJSON (Object v) = Event
                         <$> v .: "Bee"
                         <*> v .: "Name"
  parseJSON _ = mzero

instance ToJSON Event where
  toJSON (Event bee name) = object ["Bee" .= bee, "Name" .= name]


data Element = Filter {filterName :: Text, filterOptions :: [FilterOption]}
           | Action {actionName :: Text, actionBee :: Text, actionOptions :: [Option]}
           deriving (Show)

instance FromJSON Element where
  parseJSON (Object v) = do
      o <- v .:? "Filter"
      case o of
        Just x -> Filter
                  <$> x .: "Name"
                  <*> x .: "Options"
        Nothing -> do
                   x <- v .: "Action"
                   Action
                     <$> x .: "Name"
                     <*> x .: "Bee"
                     <*> x .: "Options"
  parseJSON _ = mzero

instance ToJSON Element where
  toJSON (Filter name options) =
    object ["Name" .= name, "Options" .= options]
  toJSON (Action name bee options) =
    object ["Name" .= name, "Bee" .= bee, "Options" .= options]


data Option = Option { optionName :: Text
                     , optionValue :: Value } deriving (Show)

instance FromJSON Option where
  parseJSON (Object v) = Option
                         <$> v .: "Name"
                         <*> v .: "Value"
  parseJSON _ = mzero

instance ToJSON Option where
  toJSON (Option name value) = object ["Name" .= name, "Value" .= value]


data FilterOption = FilterOption { filterOptionName :: Text
                                 , filterOptionValue :: Value
                                 , filterOptionInverse :: Bool
                                 , filterOptionCaseInsensitive :: Bool
                                 , filterOptionTrimmed :: Bool } deriving (Show)

instance FromJSON FilterOption where
  parseJSON (Object v) = FilterOption
                         <$> v .: "Name"
                         <*> v .: "Value"
                         <*> v .:? "Inverse" .!= False
                         <*> v .:? "CaseInsensitive" .!= False
                         <*> v .:? "Trimmed" .!= False
  parseJSON _ = mzero

instance ToJSON FilterOption where
  toJSON (FilterOption name value inverse caseInsensitive trimmed) =
    object ["Name" .= name, "Value" .= value, "Inverse" .= inverse,
            "CaseInsensitive" .= caseInsensitive, "Trimmed" .= trimmed]
