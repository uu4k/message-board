require 'spec_helper'

describe Message do
    let(:message) { Message.new(params) }
    let(:params) { {name: "テスト ユーザー", body:"テスト=ユーザーです.", age:20} }
    describe "validates name" do
        context "normal case" do
            it "minimum length:1" do
                message.name = "a"
                expect(message.save).to eq true
            end
            it "maximum length:20" do
                message.name = "a"*20
                expect(message.save).to eq true
            end
        end
        context "error case" do
            it "minimum length over:0" do
                message.name = ""
                expect(message.save).to eq false
            end
            it "maximum length over:21" do
                message.name = "a"*21
                expect(message.save).to eq false
            end
        end
    end
end
