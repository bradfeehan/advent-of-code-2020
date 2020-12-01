# frozen_string_literal: true

RSpec.describe 'expense_report.rb' do
  let(:expense_report_rb) { File.join(ROOT, '01', 'expense_report.rb') }

  context 'with :bruteforce strategy' do
    subject { `#{expense_report_rb} --strategy bruteforce #{input_txt}` }

    context 'with example input 1' do
      let(:input_txt) { File.join(ROOT, 'spec', '01', 'example-01.txt') }

      context 'doubles' do
        it { is_expected.to include 'Total 15 2-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '2-tuples with sum 2020: [[299, 1721]]' }
        it { is_expected.to include 'Product: [514579]' }
      end

      context 'triples' do
        subject { `#{expense_report_rb} --triples #{input_txt}` }
        it { is_expected.to include 'Total 20 3-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '3-tuples with sum 2020: [[366, 675, 979]]' }
        it { is_expected.to include 'Product: [241861950]' }
      end
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '01', 'input.txt') }

      context 'doubles' do
        it { is_expected.to include 'Total 19900 2-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '2-tuples with sum 2020: [[911, 1109]]' }
        it { is_expected.to include 'Product: [1010299]' }
      end

      context 'triples' do
        subject { `#{expense_report_rb} --triples #{input_txt}` }
        it { is_expected.to include 'Total 1313400 3-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '3-tuples with sum 2020: [[60, 472, 1488]]' }
        it { is_expected.to include 'Product: [42140160]' }
      end
    end
  end

  context 'with :smart strategy' do
    subject { `#{expense_report_rb} --strategy smart #{input_txt}` }

    context 'with example input 1' do
      let(:input_txt) { File.join(ROOT, 'spec', '01', 'example-01.txt') }

      context 'doubles' do
        it { is_expected.to include 'Total 15 2-tuples' }
        it { is_expected.to include 'Narrowed down to 2' }
        it { is_expected.to include '2-tuples with sum 2020: [[299, 1721]]' }
        it { is_expected.to include 'Product: [514579]' }
      end

      context 'triples' do
        subject { `#{expense_report_rb} --triples #{input_txt}` }
        it { is_expected.to include 'Total 20 3-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '3-tuples with sum 2020: [[366, 675, 979]]' }
        it { is_expected.to include 'Product: [241861950]' }
      end
    end

    context 'with puzzle input' do
      let(:input_txt) { File.join(ROOT, '01', 'input.txt') }

      context 'doubles' do
        it { is_expected.to include 'Total 19900 2-tuples' }
        it { is_expected.to include 'Narrowed down to 2' }
        it { is_expected.to include '2-tuples with sum 2020: [[911, 1109]]' }
        it { is_expected.to include 'Product: [1010299]' }
      end

      context 'triples' do
        subject { `#{expense_report_rb} --triples #{input_txt}` }
        it { is_expected.to include 'Total 1313400 3-tuples' }
        it { is_expected.to include 'Narrowed down to 1' }
        it { is_expected.to include '3-tuples with sum 2020: [[60, 472, 1488]]' }
        it { is_expected.to include 'Product: [42140160]' }
      end
    end
  end
end
