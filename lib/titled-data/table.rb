module TitledData
  class Table
    attr_accessor :raw, :titles, :data, :rows, :indexes

    def initialize(raw_data)
      @raw = raw_data

      if (first_row = raw_data.first).is_a? Hash
        @titles = first_row.keys
        @data = raw_data.map { |h| h.values }
        @rows = raw_data.map { |r| Row.new(r) }
      else
        @titles, @data = raw_data[0], raw_data[1..-1]

        @rows = raw_data[1..-1].inject([]) { |c, d| c << Row.new(@titles, d) }
      end
    end

    def create_row(values = nil)
      row = Row.new(values)
      rows.push(row)

      row
    end

    def remove_row(index)
      rows.delete_at(index)
    end

    def [](index)
      rows[index]
    end

    def get(index, title = nil)
      if index.is_a? String
        return rows.collect { |r| r.get(index) }
      end

      return rows[index] unless title

      rows[index].get(title)
    end

    def find_by(title, value)
      create_indexes(title) unless @indexes

      positions = @indexes[title][value]
      rows.values_at(*positions)
    end

    def has_duplication?(title)
      create_indexes(title) if @indexes.nil? || @indexes[title].nil?
      dup = @indexes[title].select { |k, v| v.count > 1 }

      not dup.empty?
    end

    def to_hash
      rows.inject([]) { |res, r| res << r.to_hash }
    end

    protected
    def method_missing(meth, *args, &block)
      raw.send(meth, *args, &block)
    end

    private
    def create_indexes(indexes)
      @indexes ||= {}

      indexes = [indexes] unless indexes.is_a? Array
      indexes.each do |i|
        values = get(i)
        @indexes[i] ||= {}

        values.each_index do |j|
          @indexes[i][values[j]] ? @indexes[i][values[j]] << j : @indexes[i][values[j]] = [j]
        end
      end
    end
  end
end
