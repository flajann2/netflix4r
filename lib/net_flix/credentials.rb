module NetFlix
  class Credentials < Valuable
    
    has_value :key
    has_value :secret
    has_value :access_token
    
    def valid?
      (key && secret) != nil
    end
    
    class << self

      def from_file
        new(config_file_exists? ? YAML.load(File.open(Rails.root.join('config', 'credentials.yml'))) : {}) 
      end

      def config_file_exists?
        File.exist? Rails.root.join('config', 'credentials.yml')
      end

    end # class methods

    def to_file!
      credentials_store = File.new(Rails.root.join('config', 'credentials.yml'), 'w')
      credentials_store.puts(self.to_yaml)
      credentials_store.close
    end

    def to_yaml
      attributes.to_yaml
    end
  end

end
