class Shash  
  attr_reader :hash  
  
  def initialize(hash={})
    @hash = hash
  end

  def method_missing(key, *args, &block)
    if key[/=$/]
      @hash[key[0...-1]] = args.first
    else
      if value = @hash[key.to_s]
        case value
          when Hash
            Shash.new(value)
          else
            value
        end
      else
        @hash.send(key, *args, &block)
      end
    end
  end
  
  def has_key?(key)
    @hash.has_key?(key.to_s)
  end
  alias_method :key?, :has_key?
  
  def == other
    @hash == other.hash
  end
end

class Hash
  def to_shash
    Shash.new(self)
  end
end
