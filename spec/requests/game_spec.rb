require 'rails_helper'

RSpec.describe "Games", type: :request do

  @game1 = Game.create( board: "070000043040009610800634900094052000358460020000800530080070091902100005007040802",
    solution: "679518243543729618821634957794352186358461729216897534485276391962183475137945862")

  describe "GET /game/1" do
    before { get '/game/1' }

    it 'returns status code 200' do
      expect(response.status).to be(200)
    end

  end

end
