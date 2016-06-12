RSpec.describe 'Zenv' do
  after do
    ENV.delete 'KEY'
    ENV.delete 'ZENV'
    Object.send :remove_const, :Zenv
  end

  describe "require'ing the gem" do
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
end
