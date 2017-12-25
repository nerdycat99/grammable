require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

	describe "comments#create action" do

		it "should allow a user to create a comments for a gram" do
			gram = FactoryBot.create(:gram)
			user = FactoryBot.create(:user)
			sign_in user
			post :create, params: { gram_id: gram.id, comment: { message: 'awesome gram' } }
			expect(response).to redirect_to root_path
			expect(gram.comments.length).to eq 1
			expect(gram.comments.first.message).to eq "awesome gram"

		end

		it "should ensure a user is logged in in order to make a comment" do
			gram = FactoryBot.create(:gram)
			post :create, params: { gram_id: gram.id, comment: { message: 'awesome gram' } }
			expect(response).to redirect_to new_user_session_path

		end

		it "should show a 404 if a user attempts to create a comment for a non-existent gram" do
			user = FactoryBot.create(:user)
			sign_in user
			patch :create, params: { gram_id: 'XYZ', comment: { message: 'blahblah' } }
			expect(response).to have_http_status(:not_found)
		end

	end

end
