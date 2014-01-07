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

  def to_h
    unshashify(self)
  end
  alias_method :to_hash, :to_h

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

  def unshashify(value)
    case value
      when Shash
        h = {}
        value.hash.each do |k,v|
          h[k] = unshashify(v)
        end
        h
      when Array
        value.map{|v| unshashify(v)}
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
