class Shash
  def initialize(hash={})
    @hash = {}
    init!(hash)
  end

  def method_missing(key, *args, &block)
    if key[/=$/]
      self[key[0...-1]] = args.first
    else
      if @hash.key?(key)
        @hash[key]
      else
        begin
          @hash.send(key, *args, &block)
        rescue NoMethodError
          nil
        end
      end
    end
  end
  
  def ==(other)
    other == @hash
  end
  
  def []=(key,value)
    @hash[key.respond_to?(:to_sym) ? key.to_sym : key] = shashify(value)
  end

  protected

  def init!(hash)
    hash.each do |k,v|
      self[k] = v
    end
  end

  def shashify(value)
    case value
      when Hash
        Shash.new(value)
      when Array
        value.map{|v| self.shashify(v)}
      else
        value
    end
  end
end

class Hash
  def to_shash
    Shash.new(self)
  end
end
