# frozen_string_literal: true

RSpec.describe 'password_validator.rb' do
  let(:password_validator_rb) { File.join(ROOT, '02', 'password_validator.rb') }
  let(:args) { '' }

  subject { `#{password_validator_rb} --strategy #{strategy} #{args} #{input_txt}` }

  context 'with :old strategy' do
    let(:strategy) { :old }

    context 'with example input 1' do
      let(:input_txt) { File.join(ROOT, 'spec', '02', 'example-01.txt') }

      it { is_expected.to include 'Valid passwords: 2' }
      it { is_expected.to include 'Invalid passwords: 1' }
      it { is_expected.to include 'Total: 3' }

      context 'in verbose mode' do
        let(:args) { '--verbose' }
        it { is_expected.to match(/Invalid:\s+1-3 b: cdefg/) }
      end
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '02', 'input.txt') }

      it { is_expected.to include 'Valid passwords: 600' }
      it { is_expected.to include 'Invalid passwords: 400' }
      it { is_expected.to include 'Total: 1000' }
    end
  end

  context 'with :new strategy' do
    let(:strategy) { :new }

    context 'with example input 1' do
      let(:input_txt) { File.join(ROOT, 'spec', '02', 'example-01.txt') }

      it { is_expected.to include 'Valid passwords: 1' }
      it { is_expected.to include 'Invalid passwords: 2' }
      it { is_expected.to include 'Total: 3' }

      context 'in verbose mode' do
        let(:args) { '--verbose' }
        it { is_expected.to match(/Invalid:\s+1-3 b: cdefg\s+2-9 c: ccccccccc/) }
      end
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '02', 'input.txt') }

      it { is_expected.to include 'Valid passwords: 245' }
      it { is_expected.to include 'Invalid passwords: 755' }
      it { is_expected.to include 'Total: 1000' }
    end
  end
end
