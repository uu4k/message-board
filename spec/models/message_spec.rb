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
    describe "validates body" do
        context "normal case" do
            it "minimum length:2" do
                message.body = "a"*2
                expect(message.save).to eq true
            end
            it "maximum length:30" do
                message.body = "a"*30
                expect(message.save).to eq true
            end
        end
        context "error case" do
            it "minimum length over:0" do
                message.body = ""
                expect(message.save).to eq false
            end
            it "minimum length over:1" do
                message.body = "a"*1
                expect(message.save).to eq false
            end
            it "maximum length over:31" do
                message.body = "a"*31
                expect(message.save).to eq false
            end
        end
    end
    describe "validates age" do
        context "normal case" do
            it "minimum length:0" do
                message.age = 0
                expect(message.save).to eq true
            end
            it "maximum length:200" do
                message.age = 200
                expect(message.save).to eq true
            end
        end
        context "error case" do
            it "minimum length over:-1" do
                message.age = -1
                expect(message.save).to eq false
            end
            it "minimum length over:201" do
                message.age = 201
                expect(message.save).to eq false
            end
            it "type error:string" do
                message.age = "a"
                expect(message.save).to eq false
            end
            it "type error:float" do
                message.age = 1.1
                expect(message.save).to eq true
            end
        end
    end
end
