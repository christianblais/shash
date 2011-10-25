class Shash  
  def initialize(hash={}, &proc)
    @_hash = hash
    @_proc = proc
  end
  
  def _key key
    @_proc ? @_proc.call(key) : key.to_s
  end 

  def method_missing(key, *args, &block)
    if key[/=$/]
      @_hash[_key(key[0...-1])] = args.first
    else
      if value = @_hash[_key(key)]
        case value
          when Hash
            Shash.new(value, &@_proc)
          else
            value
        end
      else
        begin
          @_hash.send(key, *args, &block)
        rescue NoMethodError
          nil
        end
      end
    end
  end
  
  def has_key?(key)
    @_hash.has_key?(key)
  end
  alias_method :key?, :has_key?
  
  def ==(other)
    other == @_hash
  end
  
  def []=(key,value)
    @_hash[key] = value
  end
end

class Hash
  def to_shash &proc
    Shash.new(self, &proc)
  end
end
