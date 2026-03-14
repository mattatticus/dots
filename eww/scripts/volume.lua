#!/usr/bin/wpexec

local om = ObjectManager {
    Interest {
        type = "node",
        Constraint { "media.class", "=", "Audio/Sink" }
    }
}

om:connect("object-added", function(_, node)
    local name = node.properties["node.description"] or "Unknown Device"
end)

om:connect("object-removed", function(_, node)
    local name = node.properties["node.description"] or "Unknown Device"
end)

om:activate()

Core.require_api("default-nodes", "mixer", function(default_nodes, mixer)
    local default_sink_id = default_nodes:call("get-default-node", "Audio/Sink")

    mixer.scale = "cubic"
    local vol_info = mixer:call("get-volume", default_sink_id)

    if vol_info and vol_info["channelVolumes"] and vol_info["channelVolumes"][1] then
        local muted = vol_info["mute"]
        local current_volume = vol_info["channelVolumes"][1]["volume"]
        local percent = math.floor(current_volume * 100)

        print(string.format('{ "volume": %d, "muted": %s }', percent, muted))
    end

    mixer:connect("changed", function(_, id)
        default_sink_id = default_nodes:call("get-default-node", "Audio/Sink")

        if id ~= default_sink_id then
            return
        end

        mixer.scale = "cubic"
        vol_info = mixer:call("get-volume", id)

        if vol_info and vol_info["channelVolumes"] and vol_info["channelVolumes"][1] then
            local muted = vol_info["mute"]
            local current_volume = vol_info["channelVolumes"][1]["volume"]
            local percent = math.floor(current_volume * 100)

            print(string.format('{ "volume": %d, "muted": %s }', percent, muted))
        end
    end)
end)
