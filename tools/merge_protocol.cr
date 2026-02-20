#!/usr/bin/env crystal
# Merge browser_protocol.json and js_protocol.json into a single schema
# Apply patches similar to Go generator

require "json"

class ProtocolMerger
  @browser : JSON::Any
  @js : JSON::Any
  @merged : JSON::Any

  def initialize(browser_path : String, js_path : String)
    @browser = JSON.parse(File.read(browser_path))
    @js = JSON.parse(File.read(js_path))
    @merged = JSON.parse(%({"version": {"major": "1", "minor": "3"}, "domains": []}))
  end

  private def to_json_any(value) : JSON::Any
    JSON.parse(value.to_json)
  end

  def merge : JSON::Any
    # Merge domains
    domains = [] of JSON::Any

    # Collect domains from both files
    domain_map = {} of String => JSON::Any

    collect_domains(@browser, domain_map)
    collect_domains(@js, domain_map)

    # Convert back to array
    domain_map.each_value do |domain|
      domains << domain
    end

    # Sort domains by name for consistent output
    domains.sort_by!(&.["domain"].as_s)

    @merged.as_h["domains"] = JSON::Any.new(domains)

    # Apply patches
    apply_patches

    @merged
  end

  private def collect_domains(source : JSON::Any, map : Hash(String, JSON::Any))
    source["domains"].as_a.each do |domain|
      name = domain["domain"].as_s
      map[name] = domain
    end
  end

  private def apply_patches
    # Patch 1: TargetTargetInfoType enum
    target_info_type = find_property("Target", "TargetInfo", "type")
    if target_info_type
      target_info_type.as_h["enum"] = to_json_any([
        "page", "background_page", "service_worker", "shared_worker", "browser", "other",
      ])
    end

    # Patch 2: PageLifecycleEventName enum
    lifecycle_event_name = find_event_parameter("Page", "lifecycleEvent", "name")
    if lifecycle_event_name
      lifecycle_event_name.as_h["enum"] = to_json_any([
        "init", "firstPaint", "firstContentfulPaint", "firstImagePaint", "firstMeaningfulPaintCandidate",
        "DOMContentLoaded", "load", "networkAlmostIdle", "firstMeaningfulPaint", "networkIdle",
      ])
    end

    # Patch 3: Skip TimeSinceEpoch and MonotonicTime types
    skip_type("Input", "TimeSinceEpoch")
    skip_type("Network", "TimeSinceEpoch")
    skip_type("Network", "MonotonicTime")

    # Patch 4: Fix Cookie.Expires type
    cookie_expires = find_property("Network", "Cookie", "expires")
    if cookie_expires
      cookie_expires.as_h.clear
      cookie_expires.as_h["$ref"] = to_json_any("TimeSinceEpoch")
      cookie_expires.as_h["description"] = to_json_any("Cookie expiration date")
      cookie_expires.as_h["name"] = to_json_any("expires")
    end

    # Patch 5: deltaX and deltaY are not optional for mouseWheel events
    delta_x = find_command_parameter("Input", "dispatchMouseEvent", "deltaX")
    if delta_x
      delta_x.as_h.delete("optional")
    end
    delta_y = find_command_parameter("Input", "dispatchMouseEvent", "deltaY")
    if delta_y
      delta_y.as_h.delete("optional")
    end

    # Patch 6: removing the optional for the body as we need to distinguish between no body and empty body
    body_param = find_command_parameter("Fetch", "fulfillRequest", "body")
    if body_param
      body_param.as_h.delete("optional")
    end
  end

  private def find_domain(name : String) : JSON::Any?
    @merged["domains"].as_a.find { |d| d["domain"].as_s == name }
  end

  private def find_type(domain_name : String, type_id : String) : JSON::Any?
    domain = find_domain(domain_name)
    return unless domain

    domain["types"].as_a.find { |t| t["id"]?.try(&.as_s) == type_id }
  end

  private def find_property(domain_name : String, type_id : String, property_name : String) : JSON::Any?
    type = find_type(domain_name, type_id)
    return unless type && type["properties"]?

    type["properties"].as_a.find { |p| p["name"]?.try(&.as_s) == property_name }
  end

  private def find_event_parameter(domain_name : String, event_name : String, param_name : String) : JSON::Any?
    domain = find_domain(domain_name)
    return unless domain

    event = domain["events"].as_a.find { |e| e["name"]?.try(&.as_s) == event_name }
    return unless event && event["parameters"]?

    event["parameters"].as_a.find { |p| p["name"]?.try(&.as_s) == param_name }
  end

  private def find_command_parameter(domain_name : String, command_name : String, param_name : String) : JSON::Any?
    domain = find_domain(domain_name)
    return unless domain

    command = domain["commands"].as_a.find { |c| c["name"]?.try(&.as_s) == command_name }
    return unless command && command["parameters"]?

    command["parameters"].as_a.find { |p| p["name"]?.try(&.as_s) == param_name }
  end

  private def skip_type(domain_name : String, type_id : String)
    type = find_type(domain_name, type_id)
    if type
      type.as_h["skip"] = to_json_any(true)
    end
  end
end

# Main execution
if ARGV.size != 2
  puts "Usage: crystal run tools/merge_protocol.cr -- <browser_protocol.json> <js_protocol.json>"
  puts "Output: merged_protocol.json"
  exit 1
end

browser_path = ARGV[0]
js_path = ARGV[1]

merger = ProtocolMerger.new(browser_path, js_path)
merged = merger.merge

output_path = "temp/merged_protocol.json"
File.write(output_path, merged.to_pretty_json)
puts "Merged protocol saved to #{output_path}"
