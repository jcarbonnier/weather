require 'rails_helper'

RSpec.describe Private::WeatherForecastPolicy, type: :policy do
  subject(:current_policy) { described_class }

  describe '#limit params' do
    let(:user) { build(:user) }

    it 'grants limited index params' do
      expect(current_policy.new(user, WeatherAverage).permitted_params_for_index).to eq([{ filter: %w[id include weather_location_id] }])
    end
  end

  describe '#private policy' do
    context 'when user is missing' do
      let(:user) { nil }

      permissions :index?, :show?, :create?, :update?, :destroy? do
        it 'denies access if current is nil' do
          expect(current_policy).not_to permit(nil)
        end
      end
    end

    context 'when user is logged in' do
      let(:user) { build(:user) }

      permissions :index?, :show? do
        it 'grants access if current is nil' do
          expect(current_policy).to permit(user)
        end
      end

      permissions :create?, :update?, :destroy? do
        it 'denies access if current is nil' do
          expect(current_policy).not_to permit(user)
        end
      end
    end
  end
end
