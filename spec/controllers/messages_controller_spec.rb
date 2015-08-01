require 'spec_helper'

describe MessagesController, type: :controller do
    before(:all) { 30.times { FactoryGirl.create(:message) }}
    after(:all) { Message.delete_all }
    
    describe "#index" do
        describe "normal case" do
            it "render all message" do
                get :index
                expect(assigns[:messages]).to eq Message.all
                expect(response).to render_template :index
            end
        end
    end
    describe "#create" do
        let(:params) { {name:"name",age: 20,body:"body"} }
        let(:message) { Message.new(params) }
        
        describe "normal case" do
            it "create message" do
                expect {
                    # attributes_forでパラメータのハッシュ取得
                    post :create, message: FactoryGirl.attributes_for(:message)
                }.to change(Message, :count).by(1)
            end
            it "redirect root" do
                post :create, message: FactoryGirl.attributes_for(:message)
                expect(response).to redirect_to root_path
            end
            it "assign vaiables" do
                post :create, message: FactoryGirl.attributes_for(:message)
                expect(flash[:notice]).to eq 'メッセージを保存しました'
            end
        end
        describe "error case" do
            it "create no message" do
                expect {
                    # attributes_forでパラメータのハッシュ取得
                    post :create, message: FactoryGirl.attributes_for(:message, name:nil)
                }.not_to change(Message, :count)
            end
            it "render index" do
                post :create, message: FactoryGirl.attributes_for(:message, name:nil)
                expect(response).to render_template :index
            end
            it "assign vaiables" do
                post :create, message: FactoryGirl.attributes_for(:message, name:nil)
                expect(flash[:alert]).to eq 'メッセージの保存に失敗しました'
            end
        end
    end
    describe "#edit" do
        let(:params) { {name:"name",age: 20,body:"body"} }
        let(:message) { Message.new(params) }
        
        before(:each) {
            message.save
        }
        describe "normal case" do
            it "render edit page" do
                get :edit, id: message
                expect(response).to render_template :edit
            end
            it "assigns edit message" do
                get :edit, id: message
                # assigns[:message].should == message
                expect(assigns(:message)).to eq message
            end
        end
    end
    describe "#update" do
        let(:params) { {name:"name",age: 20,body:"body"} }
        let(:params_update) { {name:"name2",age: 30,body:"body2"} }
        let(:message) { Message.new(params) }
        
        before(:each) {
            message.save
        }
        
        describe "normal case" do
            it "update message" do
                expect {
                    post :update, id: message, message: params_update
                }.not_to change(Message, :count)
                
                message.reload
                expect(message.name).to eq "name2"
                expect(message.age).to eq 30
                expect(message.body).to eq "body2"
            end
            it "redirect root" do
                post :update, id: message, message: params_update
                expect(response).to redirect_to root_path
            end
            it "assign vaiables" do
                post :update, id: message, message: params_update
                expect(flash[:notice]).to eq 'メッセージを編集しました'
            end
        end
        describe "error case" do
            before(:each) {
                params_update[:name] = nil
                params_update[:body] = "b"
                params_update[:age] = "age"
            }
            it "update no message" do
                expect {
                    post :update, id: message, message: params_update
                }.not_to change(Message, :count)
                
                message.reload
                expect(message.name).to eq "name"
                expect(message.age).to eq 20
                expect(message.body).to eq "body"
            end
            it "render edit" do
                post :update, id: message, message: params_update
                expect(response).to render_template :edit
            end
            it "assign vaiables" do
                post :update, id: message, message: params_update
                expect(assigns(:message)).to eq message
            end
        end
    end
    describe "#destroy" do
        let(:params) { {name:"name",age: 20,body:"body"} }
        let(:message) { Message.new(params) }
        
        before(:each) {
            message.save
        }
        
        describe "normal case" do
            it "destroy message" do
                expect {
                    post :destroy, id: message
                }.to change(Message, :count).by(-1)
                
                expect(Message.find_by_id(message.id)).to eq nil
            end
        end
    end
end
