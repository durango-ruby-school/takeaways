object @brochure_rack => :brochure_racks
attributes :id,:name
child :placements do
  attributes :id,:takeaway_name, :client_name
end
