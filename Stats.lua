Stats = {}
Stats.__index = Stats

function Stats.new(config)
    local self = setmetatable({}, Stats)
    
    self.value = config.value or {}
    self.graph_limit = config.graph_limit or 50
    self.refresh = config.refresh or 30
    
    -- Internal storage for our graphs
    self._graphs = {}
    if config.graphs then
        for _, name in ipairs(config.graphs) do
            self._graphs[name] = {
                current = 0,
                history = {} -- Will store { val = 123, time = 17000000 }
            }
        end
    end
    
    return self
end

-- Use this for basic card values (like Uptime)
function Stats:UpdateValue(key, new_val)
    self.value[key] = new_val
end

-- Use this for graph values (like Earned, Kills)
function Stats:UpdateGraph(key, current_val)
    local graph = self._graphs[key]
    if not graph then return end
    
    -- Always update the 'current' tracker
    graph.current = current_val
    
    local history = graph.history
    local last_entry = history[#history]
    
    -- Check for delta: If no previous entry exists, OR the value has changed
    if not last_entry or last_entry.val ~= current_val then
        table.insert(history, {
            val = current_val,
            time = os.time()
        })
        
        -- Enforce graph limit to prevent memory leaks
        if #history > self.graph_limit then
            table.remove(history, 1)
        end
    end
end

-- Call this right before you send your telemetry payload
function Stats:Export()
    local payload = {}
    
    -- 1. Insert standard values (Cards)
    for k, v in pairs(self.value) do
        payload[k] = v
    end
    
    -- 2. Insert graph objects
    for k, v in pairs(self._graphs) do
        -- Only export graphs if they actually have data
        if #v.history > 0 then
            payload[k] = {
                current = v.current,
                history = v.history
            }
        end
    end
    
    return payload
end

return Stats
