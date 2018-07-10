require 'json'
require 'rspec/autorun'
require 'pry'

class DebugUtil
  def self._is_object_pair_equal?(l_obj, r_obj)
    if l_obj.is_a?(Hash) || l_obj.is_a?(Array) && r_obj.is_a?(Hash) || r_obj.is_a?(Array)
      l_array = l_obj.to_a.sort.join(',')
      r_array = r_obj.to_a.sort.join(',')
      l_array == r_array
    else
       l_obj.to_s == r_obj.to_s
    end
  end
end
