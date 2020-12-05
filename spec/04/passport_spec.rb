# frozen_string_literal: true

RSpec.describe 'passport.rb' do
  let(:passport_rb) { File.join(ROOT, '04', 'passport.rb') }

  subject { `#{passport_rb} --strategy #{strategy} #{input_txt}` }

  context 'with :presence strategy' do
    let(:strategy) { :presence }

    context 'with example input 1' do
      let(:input_txt) { File.join(ROOT, 'spec', '04', 'example-01.txt') }

      it { is_expected.to include 'Total: 4' }
      it { is_expected.to include 'Valid: 2' }
    end

    context 'with example input 2' do
      let(:input_txt) { File.join(ROOT, 'spec', '04', 'example-02.txt') }

      it { is_expected.to include 'Total: 4' }
      it { is_expected.to include 'Valid: 4' }
    end

    context 'with example input 3' do
      let(:input_txt) { File.join(ROOT, 'spec', '04', 'example-03.txt') }

      it { is_expected.to include 'Total: 4' }
      it { is_expected.to include 'Valid: 4' }
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '04', 'input.txt') }

      it { is_expected.to include 'Total: 257' }
      it { is_expected.to include 'Valid: 228' }
    end
  end

  context 'with :strict strategy' do
    let(:strategy) { :strict }

    context 'with example input 2' do
      let(:input_txt) { File.join(ROOT, 'spec', '04', 'example-02.txt') }

      it { is_expected.to include 'Total: 4' }
      it { is_expected.to include 'Valid: 0' }
    end

    context 'with example input 3' do
      let(:input_txt) { File.join(ROOT, 'spec', '04', 'example-03.txt') }

      it { is_expected.to include 'Total: 4' }
      it { is_expected.to include 'Valid: 4' }
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '04', 'input.txt') }

      it { is_expected.to include 'Total: 257' }
      it { is_expected.to include 'Valid: 175' }
    end
  end
end
