json.array!(@expenditures) do |expenditure|
  json.extract! expenditure, :id, :ammount, :status, :comment
  json.url expenditure_url(expenditure, format: :json)
end
