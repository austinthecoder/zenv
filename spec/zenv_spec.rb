RSpec.describe 'Zenv' do
  after do
    ENV.delete 'KEY'
    ENV.delete 'ZENV'
    Object.send :remove_const, :Zenv
  end

  context 'when the ZENV env var is not set' do
    it 'loads env vars from the :default namespace' do
      expect { load 'zenv.rb' }.to change { ENV['KEY'] }.from(nil).to 'default value'
    end
  end

  context 'when the ZENV env var is set' do
    it 'loads env vars from the specified namespace' do
      ENV['ZENV'] = 'other'
      expect { load 'zenv.rb' }.to change { ENV['KEY'] }.from(nil).to 'other value'
    end
  end
end
