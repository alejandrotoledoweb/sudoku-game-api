require 'rails_helper'

RSpec.describe Move, type: :model do
  describe 'associations' do
    it { should belong_to(:game).class_name('Game') }
  end

  describe 'validations' do
    it { should validate_presence_of(:game_id) }
    it { should validate_presence_of(:row) }
    it { should validate_presence_of(:col) }
    it { should validate_presence_of(:number) }
  end
end
