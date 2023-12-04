{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_FontyFruity (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,5,3,5] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/bin"
libdir     = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/lib"
dynlibdir  = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/lib"
datadir    = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/share"
libexecdir = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/libexec"
sysconfdir = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/FontyFruity-0.5.3.5-b3669bde9cf6802536959b1c866b76bd9bbd4a468c6fcb6091a83ef8beff2c78/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "FontyFruity_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "FontyFruity_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "FontyFruity_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "FontyFruity_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "FontyFruity_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "FontyFruity_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
