# frozen_string_literal: true

RSpec.describe 'toboggan.rb' do
  let(:toboggan_rb) { File.join(ROOT, '03', 'toboggan.rb') }
  let(:args) { '' }
  let(:slope) { '3,1' }

  subject { `#{toboggan_rb} --slope #{slope} #{args} #{input_txt}` }

  context 'with example input 1' do
    let(:input_txt) { File.join(ROOT, 'spec', '03', 'example-01.txt') }

    it { is_expected.to include 'Trees encountered: 7' }

    context 'in verbose mode' do
      let(:args) { '--verbose' }
      it { is_expected.to include 'Width: 11' }
      it { is_expected.to include 'Slope: {:x=>3, :y=>1}' }

      context 'with slope 1,1' do
        let(:slope) { '1,1' }
        it { is_expected.to include 'Trees encountered: 2' }
        it { is_expected.to include 'Slope: {:x=>1, :y=>1}' }
      end

      context 'with slope 5,1' do
        let(:slope) { '5,1' }
        it { is_expected.to include 'Trees encountered: 3' }
        it { is_expected.to include 'Slope: {:x=>5, :y=>1}' }
      end

      context 'with slope 7,1' do
        let(:slope) { '7,1' }
        it { is_expected.to include 'Trees encountered: 4' }
        it { is_expected.to include 'Slope: {:x=>7, :y=>1}' }
      end

      context 'with slope 1,2' do
        let(:slope) { '1,2' }
        it { is_expected.to include 'Trees encountered: 2' }
        it { is_expected.to include 'Slope: {:x=>1, :y=>2}' }
      end
    end
  end

  context 'with puzzle input' do
    let(:input_txt) { File.join(ROOT, '03', 'input.txt') }

    it { is_expected.to include 'Trees encountered: 214' }

    context 'in verbose mode' do
      let(:args) { '--verbose' }
      it { is_expected.to include 'Width: 31' }
      it { is_expected.to include 'Slope: {:x=>3, :y=>1}' }

      context 'with slope 1,1' do
        let(:slope) { '1,1' }
        it { is_expected.to include 'Trees encountered: 94' }
        it { is_expected.to include 'Slope: {:x=>1, :y=>1}' }
      end

      context 'with slope 5,1' do
        let(:slope) { '5,1' }
        it { is_expected.to include 'Trees encountered: 99' }
        it { is_expected.to include 'Slope: {:x=>5, :y=>1}' }
      end

      context 'with slope 7,1' do
        let(:slope) { '7,1' }
        it { is_expected.to include 'Trees encountered: 91' }
        it { is_expected.to include 'Slope: {:x=>7, :y=>1}' }
      end

      context 'with slope 1,2' do
        let(:slope) { '1,2' }
        it { is_expected.to include 'Trees encountered: 46' }
        it { is_expected.to include 'Slope: {:x=>1, :y=>2}' }
      end
    end
  end
end
