class Shash
  def initialize(source={})
    source.each do |k,v|
      self[k] = v
    end
  end

  def method_missing(key, *args, &block)
    if key[/=$/]
      self[key[0...-1]] = args.first
    elsif hash.key?(key)
      hash[key]
    elsif hash.respond_to?(key)
      hash.__send__(key, *args, &block)
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name[/=$/] || hash.key?(method_name) || hash.respond_to?(method_name) || super
  end
  
  def ==(other)
    other == hash
  end
  
  def []=(key, value)
    hash[key.respond_to?(:to_sym) ? key.to_sym : key] = shashify(value)
  end

  protected
  
  def hash
    @hash ||= {}
  end

  def shashify(value)
    case value
      when Hash
        Shash.new(value)
      when Array
        value.map{|v| shashify(v)}
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
