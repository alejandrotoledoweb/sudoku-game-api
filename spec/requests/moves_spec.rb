require 'rails_helper'

RSpec.describe "Moves", type: :request do

  let(:move_attributes){ {game_id: 1,
    row: 0, col: 0, number: 5}}
  let(:move_attributes_wrong){ {game_id: 1,
    row: 0, col: 1, number: 5}}
  let(:move_attributes_zero){ {game_id: 1,
    row: 0, col: 0, number: 5}}
  let(:move_attributes_wrong_2){ {game_id: 1,
    row: 0, col: 0, number: 35}}

    
  describe "POST /moves" do
    before { post '/moves', params: move_attributes }

    it 'returns status code 200' do
      expect(response.status).to be(200)
    end
  end

  describe "POST /moves" do
    before { post '/moves', params: move_attributes_wrong }

    it 'returns status code 406 when move is not acceptable' do
      expect(response.status).to be(406)
    end
  end

  describe "POST /moves" do
    before { post '/moves', params: move_attributes_zero }

    it 'returns status code 200 when returning to zero' do
      expect(response.status).to be(200)
    end
  end

  describe "POST /moves" do
    before { post '/moves', params: move_attributes_wrong_2 }

    it 'returns status code 406 when given a number out the range 0..9' do
      expect(response.status).to be(406)    
    end
  end
end
