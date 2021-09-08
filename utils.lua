local utils = {}

function utils.any(tbl, fn)
    for _, item in ipairs(tbl) do
        if fn(item) then return true end
    end
    return false
end

function utils.all(tbl, fn)
    for _, item in ipairs(tbl) do
        if not fn(item) then return false end
    end
    return true
end

function utils.none(tbl, fn)
    for _, item in ipairs(tbl) do
        if fn(item) then return false end
    end
    return true
end

function utils.contains(tbl, item)
    return utils.any(tbl, function(i) return item == i end)
end

function utils.filter(tbl, fn)
    local result = {}
    for _, item in ipairs(tbl) do
        if fn(item) then table.insert(result, item) end
    end
    return result
end

function utils.clone(tbl)
    local t = type(tbl)
    local copy
    if t == 'table' then
        copy = {}
        for ok, ov in next, tbl, nil do
            copy[utils.clone(ok)] = utils.clone(ov)
        end
        setmetatable(copy, utils.clone(getmetatable(tbl)))
    else
        copy = tbl
    end
    return copy
end

--non-destructive, leaves original tables intact
function utils.merge(orig, modi, exclude_keys)
    local exclude
    if type(exclude_keys) == 'table' then
        exclude = exclude_keys
    else
        exclude = {}
    end

    local result = utils.clone(orig)
    local m = utils.clone(modi)
    for mk, mv in next, m, nil do
        if not utils.any(exclude, function(i) return i == mk end) then
            if type(mv) == 'table' then
                if type(result[mk] or false) == 'table' then
                    result[mk] = utils.merge(result[mk] or {}, m[mk] or {})
                else
                    if not result[mk] then result[mk] = mv end
                end
            else
                if not result[mk] then result[mk] = mv end
            end
        end
    end
    return result
end

function utils.table_debug(tbl, lvl)
    lvl = lvl or 0
    local indent = function(lv)
        if lv > 0 then
            for i = 1, lv * 2 do io.write(" ") end
        end
    end
    io.write("{\n")
    for k, v in pairs(tbl) do
        indent(lvl + 1)
        io.write(string.format("%s = ", k))
        if type(v) == 'table' then
            utils.table_debug(v, lvl + 1)
        else
            io.write(v, "\n")
        end
    end
    indent(lvl)
    io.write("}\n")
end

function utils.clamp(val, low, high)
    if val < low then
        return low
    elseif val > high then
        return high
    else
        return val
    end 
end

function utils.between(val, low, high)
    return utils.clamp(val, low, high) == val
end

function utils.repo_search(tbl, conditions)
    if not conditions then return tbl end
    local result = {}
    local t = type(conditions)
    for rk, rv in pairs(tbl) do
        if t == 'table' then
            local to_add = true
            for ck, cv in pairs(conditions) do
                if rv[ck] ~= cv then
                    to_add = false
                    break
                end
            end
            if to_add then result[rk] = rv end
        elseif t == 'function' then
            if conditions(rv) then result[rk] = rv end
        end
    end
    return result
end

function utils.prob_table(tbl, conditions, frequency_field)
    local freq = frequency_field or "freq"
    local search = utils.repo_search(tbl, conditions)
    local refine = utils.repo_search(search, function (i) return i[freq] end)
    local result = {}
    for k, v in pairs(refine) do
        result[k] = v[freq]
    end
    return result
end

function utils.uuid()
    math.randomseed(os.time())

    local result = ""
    for x = 1, 16 do
        local num = math.random(0, 255)
        if x == 7 then
            num = 0x40 | (num & 0xF)
        end
        if x == 9 then
            num = 0x80 | (num & 0x3F)
        end
        result = result .. string.format("%02x", num)
        if x == 4 or x == 6 or x == 8 or x == 10 then
            result = result .. "-"
        end
    end

    return result
end

return utils