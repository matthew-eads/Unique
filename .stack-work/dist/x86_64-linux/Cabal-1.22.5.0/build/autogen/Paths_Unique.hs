module Paths_Unique (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,4,3] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/matt/compsci/gg-proto/.stack-work/install/x86_64-linux/lts-5.4/7.10.3/bin"
libdir     = "/home/matt/compsci/gg-proto/.stack-work/install/x86_64-linux/lts-5.4/7.10.3/lib/x86_64-linux-ghc-7.10.3/Unique-0.4.3-5QtIhs0FjutFZcRcUfSgP3"
datadir    = "/home/matt/compsci/gg-proto/.stack-work/install/x86_64-linux/lts-5.4/7.10.3/share/x86_64-linux-ghc-7.10.3/Unique-0.4.3"
libexecdir = "/home/matt/compsci/gg-proto/.stack-work/install/x86_64-linux/lts-5.4/7.10.3/libexec"
sysconfdir = "/home/matt/compsci/gg-proto/.stack-work/install/x86_64-linux/lts-5.4/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Unique_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Unique_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Unique_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Unique_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Unique_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
