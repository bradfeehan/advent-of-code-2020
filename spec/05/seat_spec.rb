# frozen_string_literal: true

require File.join(ROOT, '05', 'seat.rb')

RSpec.describe BinaryBoarding::Seat do
  describe '.decode()' do
    subject(:seat) { described_class.decode(code) }

    context 'with code BFFFBBFRRR' do
      let(:code) { 'BFFFBBFRRR' }
      its(:row) { is_expected.to eq 70 }
      its(:column) { is_expected.to eq 7 }
      its(:id) { is_expected.to eq 567 }
    end

    context 'with code FFFBBBFRRR' do
      let(:code) { 'FFFBBBFRRR' }
      its(:row) { is_expected.to eq 14 }
      its(:column) { is_expected.to eq 7 }
      its(:id) { is_expected.to eq 119 }
    end

    context 'with code BBFFBBFRLL' do
      let(:code) { 'BBFFBBFRLL' }
      its(:row) { is_expected.to eq 102 }
      its(:column) { is_expected.to eq 4 }
      its(:id) { is_expected.to eq 820 }
    end
  end

  context 'with puzzle input' do
    let(:input) { Pathname.new(ROOT) / '05' / 'input.txt' }
    let(:seats) { input.each_line.map { |l| BinaryBoarding::Seat.decode(l) } }

    describe 'maximum seat ID' do
      subject { seats.map(&:id).max }
      it { is_expected.to eq 832 }
    end

    describe 'your seat ID' do
      let(:seen_ids) { Set.new(seats.map(&:id)) }
      let(:all_ids) { Set.new(0..0b1111111111) }
      let(:unseen_ids) { all_ids - seen_ids }

      subject(:unseed_ids_with_seen_neighbours) do
        unseen_ids.subtract(unseen_ids.map(&:succ) + unseen_ids.map(&:pred))
      end

      it { is_expected.to eq Set.new([517]) }
    end
  end
end
