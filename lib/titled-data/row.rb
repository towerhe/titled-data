module TitledData
  class Row
    attr_accessor :hsh

    def initialize(values, data = nil)
      @hsh = {}

      if values.is_a? Hash
        @hsh= values.stringify_keys
      elsif values.is_a? Array
        data ||= []
        values.each_index { |i| @hsh[values[i].to_s] = data[i] }
      end
    end

    def titles
      hsh.keys
    end

    def data
      hsh.values
    end

    def get(title)
      hsh[title.to_s]
    end

    def set_value(title, value)
      title = title.to_s
      hsh[title] = value if hsh.has_key?(title)
    end

    def set_values(values)
      values.each { |k, v| set_value(k, v) }
    end

    def get_values
      to_hash
    end

    def [](index)
      data[index]
    end

    def to_hash
      hsh
    end
  end
end
