require './lib/journey'

describe Journey do
  let(:station1) {double(:station1, :zone => 1)}
  let(:station2) {double(:station2, :zone => 2)}
  subject(:journey1) {Journey.new station1}
  context 'when new journey' do
    it 'entry station' do
      expect(journey1.entry).to eq station1
    end
    it 'exit station' do
      journey1.exit = station2
      expect(journey1.exit).to eq station2
    end
    it 'set fare' do
      journey1.exit = station2
      expect(journey1.fare).to eq 2
    end
    it 'set journey complete' do
      expect(subject.complete).to eq false
    end
  end


end