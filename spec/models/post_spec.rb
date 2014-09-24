require 'rails_helper'

describe Post do
	context 'with title and body' do 
		let(:post) {FactoryGirl.build :post}
		subject {post}

		it {should be_valid}
		it {should respond_to :title}
		it {should respond_to :body}
	end
	
	context 'without a title' do
		let(:partial_post) {FactoryGirl.build :invalid_post}
		subject {partial_post}

		it {should_not be_valid}
	end
end
