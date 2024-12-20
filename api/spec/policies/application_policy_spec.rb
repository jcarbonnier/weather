require 'rails_helper'

RSpec.describe ApplicationPolicy, type: :policy do
  subject(:current_policy) { described_class }

  describe '#application policy' do
    permissions :index?, :show?, :create?, :update?, :destroy? do
      it 'denies access' do
        expect(current_policy).not_to permit(nil)
      end
    end
  end
end
