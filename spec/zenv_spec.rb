RSpec.describe 'Zenv' do
  after do
    ENV.delete 'KEY'
    ENV.delete 'ZENV'
    Object.send :remove_const, :Zenv
  end

  describe "require'ing the gem" do
    around do |example|
      create_dot_zenv
      example.run
      remove_dot_zenv
    end

    context 'when the ZENV environment variable is not set' do
      it 'loads environment variables from the :default namespace' do
        expect { load 'zenv.rb' }.to change { ENV['KEY'] }.from(nil).to 'default value'
      end
    end

    context 'when the ZENV environment variable specifies a namespace' do
      it 'loads environment variables from the specified namespace' do
        ENV['ZENV'] = 'other'
        expect { load 'zenv.rb' }.to change { ENV['KEY'] }.from(nil).to 'other value'
      end
    end
  end

  describe 'file extensions' do
    around do |example|
      create_dot_zenv '.rb'
      example.run
      remove_dot_zenv '.rb'
    end

    it "zenv files can have the .rb extension" do
      expect { load 'zenv.rb' }.to change { ENV['KEY'] }.from(nil).to 'default value'
    end
  end

  ##########

  def create_dot_zenv(extension = nil)
    zenv_contents = <<~RUBY
      {
        default: {
          KEY: 'default value'
        },
        other: {
          KEY: 'other value'
        }
      }
    RUBY

    zenv_filepath = File.expand_path "#{__dir__}/../.zenv#{extension}"

    File.open zenv_filepath, 'w+' do |file|
      file.write zenv_contents
    end
  end

  def remove_dot_zenv(extension = nil)
    zenv_filepath = File.expand_path "#{__dir__}/../.zenv#{extension}"

    FileUtils.rm zenv_filepath
  end
end
