json.array!(@combat_parsers) do |combat_parser|
  json.extract! combat_parser, :id, log
  json.url combat_parser_url(combat_parser, format: :json)
end
