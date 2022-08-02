module Serializers
  def serialize_items(items, file_name)
    file = File.open(file_name, 'w')
    obj_strings = []
    items.each do |item|
      obj_strings.push(JSON.generate(item).to_s)
    end
    file.write(obj_strings)
    file.close
  end

  def serialize_all(data)
    serialize_items(data[0], data[1])
  end
end
