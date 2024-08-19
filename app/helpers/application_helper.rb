# app/helpers/application_helper.rb
module ApplicationHelper
  def json_to_table(json_data)
    content_tag(:table, class: 'hover:table-fixed') do
      json_data.map do |key, value|
        concat(
          content_tag(:tr) do
            concat(content_tag(:td, key.to_s.humanize, class: "border px-4 py-2"))
            concat(content_tag(:td, format_value(value), class: "border px-4 py-2"))
          end
        )
      end.join.html_safe
    end
  end

  private

  def format_value(value)
    case value
    when Hash
      json_to_table(value) # Recursive call for nested hashes
    when Array
      if value.all? { |v| v.is_a?(String) }
        array_string(value) 
      else
        array_json(value)
      end
    else
      value.to_s
    end
  end

  def array_string(array)
    array.join(", ")
  end

  def array_json(hash_array)
    content_tag(:ul, class: 'ul-table') do
      hash_array.map do |hash|
        concat(content_tag(:li, json_to_table(hash), class: 'li-table'))
      end.join.html_safe
    end
  end
end