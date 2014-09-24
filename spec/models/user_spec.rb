require 'rails_helper'

describe User do
	let(:alex) { FactoryGirl.build :alex }
	subject{ alex }

	it { should respond_to :first_name }
	it { should respond_to :last_name }
	it { should respond_to :email }
	it { should respond_to :password_digest }

	it 'has a display name' do
		expect(alex.name).to eq 'Alex Meyers'
	end
end
