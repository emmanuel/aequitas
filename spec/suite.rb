spec_dir = File.expand_path('../aequitas', __FILE__)
Dir[File.join(spec_dir, '**', '*.rb')].each { |spec| require spec }
