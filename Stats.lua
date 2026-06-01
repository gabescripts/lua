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

function Stats:UpdateGraph(key, current_val)
    local graph = self._graphs[key]
    if not graph then return end

    -- First run initialization
    if graph.last_abs == nil then
        graph.last_abs = current_val
        graph.session_total = 0
    else
        -- Calculate the Delta (Change)
        local delta = current_val - graph.last_abs
        
        -- Only update the graph if money/kills actually changed!
        if delta ~= 0 then
            table.insert(graph.history, {
                val = delta,
                time = os.time()
            })
            
            -- Update trackers
            graph.last_abs = current_val
            graph.session_total = graph.session_total + delta

            -- Prevent memory leaks
            if #graph.history > self.graph_limit then
                table.remove(graph.history, 1)
            end
        end
    end

    -- The main display number is now the total amount earned THIS session
    graph.current = graph.session_total or 0
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
