require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

      it "must be created with a password" do
        @user = User.new({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: nil,
          password_confirmation: "test1"
          })
        @user.save
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it "must be created with a password confirmation" do
        @user = User.new({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: "test1",
          password_confirmation: nil
          })
        expect(@user.password_confirmation).should_not be_nil
      end

      it "must have matching password and password confirmation" do
        @user = User.new({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: "test1",
          password_confirmation: "test1"
          })
        expect(@user.password).to eq (@user.password_confirmation)
      end

      it "must have password with a minimum length equal to 8" do
        @user = User.new({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: "testtestt",
          password_confirmation: "testtestt"
          })

        @user.save
        expect(@user.errors.full_messages).to include "Password is too short"
      end

      it "must have unique email" do
          @user1 = User.create({
            first_name: "test",
            last_name: "test",
            email: "test",
            password: "test1",
            password_confirmation: "test1"
            })


         @user2 = User.new({
            first_name: "test",
            last_name: "test",
            email: "test",
            password: "test1",
            password_confirmation: "test1"
            })
          @user2.save
          expect(@user2.errors.full_messages).to include "Email has already been taken"
        end

      it "must have case insensitive email field" do
        @user1 = User.create({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: "test1",
          password_confirmation: "test1"
          })


       @user2 = User.new({
          first_name: "test",
          last_name: "test",
          email: "TEST",
          password: "test1",
          password_confirmation: "test1"
          })
        @user2.save
        expect(@user2.errors.full_messages).to include "Email has already been taken"
      end

      it "must be created with a first name" do
        @user = User.new({
          first_name: nil,
          last_name: "test",
          email: "test",
          password: "test1",
          password_confirmation: "test1"
          })

        @user.save
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end

      it "must be created with a first name" do
        @user = User.new({
          first_name: "test",
          last_name: nil,
          email: "test",
          password: "test1",
          password_confirmation: "test1"
          })

        @user.save
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

     it "will create unique users when all parameters filled in properly" do
        @user1 = User.new({
          first_name: "test",
          last_name: "test",
          email: "test",
          password: "test1",
          password_confirmation: "test1"
          })


        @user2 = User.new({
          first_name: "test2",
          last_name: "test2",
          email: "test2",
          password: "test12",
          password_confirmation: "test12"
          })

        expect(@user1.save && @user2.save).to be true
      end
  end

  describe ".authenticate_with_credentials" do
    it "should return user when passed correct parameters" do
    @user = User.create({
        first_name: "test",
        last_name: "test",
        email: "test",
        password: "test1",
        password_confirmation: "test1"
        })

    expect(User.authenticate_with_credentials(@user.email, @user.password)).to eql @user
    end

    it "should return nil when passed incorrect email" do
      @user = User.create({
        first_name: "test",
        last_name: "test",
        email: "test",
        password: "test1",
        password_confirmation: "test1"
        })

      expect(User.authenticate_with_credentials("bad_email", @user.password)).to eql nil
    end

    it "should return nil when passed incorrect password" do
      @user = User.create({
        first_name: "test",
        last_name: "test",
        email: "test",
        password: "test1",
        password_confirmation: "test1"
        })

      expect(User.authenticate_with_credentials(@user.email, "bad_password")).to eql nil
    end

    it "should return user when email has leading spaces" do
    @user = User.create({
        first_name: "test",
        last_name: "test",
        email: "test",
        password: "test1",
        password_confirmation: "test1"
        })

      expect(User.authenticate_with_credentials("   #{@user.email}", @user.password)).to eql @user
    end

    it "should return user when email has upcase characters" do
      @user = User.create({
        first_name: "test",
        last_name: "test",
        email: "test",
        password: "test1",
        password_confirmation: "test1"
        })

      puts '*************' + @user.email.upcase

      expect(User.authenticate_with_credentials(@user.email.upcase, @user.password)).to eql @user
    end
  end
end


      # validates :first_name, presence: true
      # validates :last_name, presence: true
      # validates :email, presence: true, uniqueness: { case_sensitive: false }
      # validates :password, presence: true
      # validates :password_confirmation, presence: true
