% pico-8 tables and friends
% ![image](./sonat.png)
% 1. November, 2019

# Disclaimer
::: nonincremental
- pico-8 games are written in a subset Lua
- table to Lua is roughly what list is to Lisp
:::

#
::: nonincremental
```{.lua .numberLines}
-- this is a comment
local empty_table = {}
local tables_as_list = {1,2,3,4}
table_as_list[1] == 1 -- is true, Lua arrays are 1-indexed
table_as_list[-1] == nil -- is true

empty_table.func = function(echo) return echo end
-- empty table is not so empty any more

empty_table.func == empty_table["func"]
empty_table:func() -- is the same as empty_table.func(empty_table)

local table_as_map = {key = "value"}
table.key == "value"
```

:::

# metatable
::: nonincremental
- defines custom +-/*[]() operations
- defines what should happen when a key does not exist
- let's us implement 'objects' by defining prototype objects
:::

#
::: nonincremental
- if __index is a function, it is called like vec.__index(t, k)
- if __index is a table, a lookup is performed like vec.__index[k]
```{.lua .numberLines}
-- vector object
local vec = {}
vec.__index = vec

function vec:new(x, y)
    return setmetatable({x=x, y=y}, vec)
end

function vec:abs()
    return sqrt(self.x^2 + self.y^2)
end

local v = vec:new(1,1)
length = v:abs()

```

:::

# coroutines

TODO

# links
::: nonincremental
- <http://lua-users.org/wiki/MetamethodsTutorial>
- <http://lua-users.org/wiki/MetatableEvents>
- <https://www.lua.org/pil/16.html>
- <https://pico-8.fandom.com/wiki/APIReference>
- <http://lua.space/general/intro-to-metatables>
- <https://www.lexaloffle.com/bbs/?tid=3342>
- <https://pico-8.fandom.com/wiki/Tables>

:::
