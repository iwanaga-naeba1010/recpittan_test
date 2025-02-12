# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordComplexityValidator do
  let(:user) { User.new(email: 'test@example.com', password: password) }

  subject { user.valid? }

  shared_examples 'a valid password' do
    it 'is valid' do
      expect(user).to be_valid
    end
  end

  shared_examples 'an invalid password' do
    it 'is invalid' do
      expect(user).to be_invalid
      expect(user.errors[:password]).to include('は数字・英小文字・英大文字・記号のうち2種類以上を含める必要があります')
    end
  end

  describe 'valid password' do
    context 'when the password meets complexity requirements' do
      context 'with uppercase and lowercase letters' do
        let(:password) { 'Abcdefgh' }
        include_examples 'a valid password'
      end

      context 'with letters and numbers' do
        let(:password) { 'abcd1234' }
        include_examples 'a valid password'
      end

      context 'with letters and symbols' do
        let(:password) { 'abcd!@#$' }
        include_examples 'a valid password'
      end

      context 'with uppercase letters and numbers' do
        let(:password) { 'ABC12345' }
        include_examples 'a valid password'
      end

      context 'with uppercase letters and symbols' do
        let(:password) { 'ABC!@#$%' }
        include_examples 'a valid password'
      end

      context 'with numbers and symbols' do
        let(:password) { '1234!@#$' }
        include_examples 'a valid password'
      end

      context 'with all character types included' do
        let(:password) { 'Aa1!abcd' }
        include_examples 'a valid password'
      end
    end
  end

  describe 'invalid password' do
    context 'when the password does not meet complexity requirements' do
      context 'with only lowercase letters' do
        let(:password) { 'abcdefgh' }
        include_examples 'an invalid password'
      end

      context 'with only uppercase letters' do
        let(:password) { 'ABCDEFGH' }
        include_examples 'an invalid password'
      end

      context 'with only numbers' do
        let(:password) { '12345678' }
        include_examples 'an invalid password'
      end

      context 'with only symbols' do
        let(:password) { '!@#$%^&*' }
        include_examples 'an invalid password'
      end
    end
  end
end
