-- USAGE:
--
-- requirehash used to overwrite global require function
-- local require = require "modules/requirehash"
-- local script1 = require (self.scriptpath) -- it can both load modules by hash
-- local script2 = require "scripts/script2" -- and by strings as well


-- hashlist structure:
-- hashlist[hashed_path] = string_path
local hashlist = {}
local hashdir = "scripts" -- TODO get hashdir as parameter


--- Calls func for each file in the directory
-- @param path        path to directory with files to iterate
-- @param recursive   defines whether to check nested directories or not
-- @param func        function to call for each file, takes file path as single param
-- @usage foreachfile("/Desktop", false, print)
local function foreachfile (path, recursive, func)
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      local fullpath = path.."/"..file -- TODO get fullpath structure
      local attr = lfs.attributes (fullpath)
      if attr.mode == "directory" and recursive then
        foreachfile (fullpath, recursive, func)
      elseif attr.mode == "file" then
        func (fullpath)
      end
    end
  end
end

-- filling hashlist
do
  local function add_to_hashlist (file)
    hashlist[hash(file)] = file
  end
  foreachfile (hashdir, true, add_to_hashlist)
end

local function requirehash (key)
  for hashpath, strpath in pairs(hashlist) do
    if hashpath == key then -- hashes stored by pointer, can't hashlist[key]
      return dofile (strpath)
    end
  end
end

local function mixed_require (key)
  if type(key) == "userdata" then
    return requirehash(key)
  else
    return require(key)
  end
end

return mixed_require
