{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_JuicyPixels (
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
version = Version [3,3,7] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/bin"
libdir     = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/lib"
dynlibdir  = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/lib"
datadir    = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/share"
libexecdir = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/libexec"
sysconfdir = "/import/adams/1/z5361001/.cabal/store/ghc-8.8.4/JuicyPixels-3.3.7-6cb64c323350d794a46fc7f0ad34415895ed30e9526c49ff7823d286cbfb2ce5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "JuicyPixels_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "JuicyPixels_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "JuicyPixels_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "JuicyPixels_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "JuicyPixels_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "JuicyPixels_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
