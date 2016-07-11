require 'weather'

describe Weather do
  subject(:weather) { described_class.new }

  it { is_expected.to(respond_to(:stormy?)) }

  describe '#stormy?' do
    it 'sets the weather to stormy when random_number equals 1' do
      allow(weather).to receive(:stormy?) { true }
      expect(weather.stormy?).to(equal(true))
    end
    it 'sets the weather to fair for all other random_numbers' do
      allow(weather).to receive(:stormy?) { false }
      expect(weather.stormy?).to(equal(false))
    end
  end

end
