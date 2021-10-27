require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should have_many(:moves) }
  end

  describe 'validations' do
    it { should validate_presence_of(:board) }
    it { should validate_presence_of(:solution) }
  end
end
