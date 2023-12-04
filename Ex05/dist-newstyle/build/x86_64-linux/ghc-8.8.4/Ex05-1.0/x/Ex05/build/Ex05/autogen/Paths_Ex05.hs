{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Ex05 (
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
version = Version [1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/import/adams/1/z5361001/.cabal/bin"
libdir     = "/import/adams/1/z5361001/.cabal/lib/x86_64-linux-ghc-8.8.4/Ex05-1.0-inplace-Ex05"
dynlibdir  = "/import/adams/1/z5361001/.cabal/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/import/adams/1/z5361001/.cabal/share/x86_64-linux-ghc-8.8.4/Ex05-1.0"
libexecdir = "/import/adams/1/z5361001/.cabal/libexec/x86_64-linux-ghc-8.8.4/Ex05-1.0"
sysconfdir = "/import/adams/1/z5361001/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Ex05_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Ex05_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Ex05_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Ex05_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Ex05_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Ex05_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
