require "airport"

describe Airport do
  subject(:airport) { described_class.new }
  let(:plane) { double :plane }
  let(:weather) { double :weather }

  it { is_expected.to(respond_to(:land).with(1).argument) }
  it { is_expected.to(respond_to(:flying?).with(1).argument) }
  it { is_expected.to(respond_to(:planes))}
  it { is_expected.to(respond_to(:take_off).with(1).argument) }
  it { is_expected.to(respond_to(:find).with(1).argument) }
  it { is_expected.to(respond_to(:remove).with(1).argument) }
  #it { is_expected.to(respond_to(:is_stormy?)) }


  describe '#planes' do
    it 'returns landed planes' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { false }
      allow(plane).to(receive(:land_plane))
      airport.land(plane)
      expect(airport.planes).to(eq([plane]))
    end
  end

  describe '#land' do
    it 'returns an error if the plane is already landed' do
      allow(plane).to(receive(:landed?).and_return(true))
      expect{ airport.land(plane) }.to(raise_error("Plane has already landed"))
    end
    it 'it does not land a plane when weather is stormy' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { true }
      allow(plane).to(receive(:land_plane))
      expect{ airport.land(plane) }.to(raise_error("Weather is bad, plane cannot land"))
    end
    it 'lands a plane' do
      allow(plane).to(receive(:landed?).and_return(false))
      allow(airport.weather).to receive(:stormy?) { false }
      expect(plane).to(receive(:land_plane))
      airport.land(plane)
    end
    it 'includes the landed plane in the planes array' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { false }
      allow(plane).to(receive(:land_plane))
      airport.land(plane)
      expect(airport.planes).to(eq([plane]))
    end
  end

  describe '#take_off' do
    it 'returns an error if the plane is not in the airport' do
      expect{airport.take_off(plane)}.to(raise_error("No planes"))
    end
    it 'it does not allow a plane to take off when weather is stormy' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { false }
      allow(plane).to(receive(:land_plane))
      airport.land(plane)
      allow(plane).to(receive(:fly))
      allow(airport.weather).to receive(:stormy?) { true }
      expect{ airport.take_off(plane) }.to(raise_error("Weather is bad, plane cannot take off"))
    end
    it 'tells a plane to take off' do
      allow(plane).to(receive(:landed?))
      allow(plane).to(receive(:land_plane))
      airport.land(plane)
      expect(plane).to(receive(:fly))
      airport.take_off(plane)
    end
    it 'removes the plane from the planes array' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { false }
      allow(plane).to(receive(:land_plane))
      allow(plane).to(receive(:fly))
      airport.land(plane)
      airport.take_off(plane)
      expect(airport.planes).to(be_empty)
    end
  end

  describe '#flying?' do
    it 'returns the landed? status of the plane' do
      expect(plane).to(receive(:landed?))
      airport.flying?(plane)
    end
  end

  describe '#find' do
    it 'finds the plane in the planes array' do
      allow(plane).to(receive(:landed?))
      allow(airport.weather).to receive(:stormy?) { false }
      allow(plane).to(receive(:land_plane))
      airport.land(plane)
      expect(airport.find(plane)).to(eq(true))
    end
  end

  describe '#remove' do
    it 'removes the plane from the planes array' do
      allow(plane).to(receive(:landed?))
      allow(plane).to(receive(:land_plane))
      allow(plane).to(receive(:fly))
      airport.land(plane)
      expect(airport.planes).not_to(eq(plane))
      airport.take_off(plane)
    end
  end

end
