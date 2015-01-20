require 'rails_helper'

RSpec.describe Article, :type => :model do

    subject { FactoryGirl.create(:user) }

    describe "validations" do

      it "should require presence of :content" do
        article = Article.new({title: "blah"})
        expect(article.save).to be(false)
      end

      it "should require presence of a :title" do
        article = Article.new({content: "blah"})
        expect(article.save).to be(false)       
      end

    end

    describe "associations" do

      it "should has an associated :user " do
        is_assoc = Article.reflect_on_association(:user)
        expect(is_assoc).to be_truthy
      end

      it "should belongs_to: :user" do
        macro = Article.reflect_on_association(:user).macro
        expect(macro).to be(:belongs_to)
      end

    end


    describe "#author" do

      it "should respond_to :author" do
        article = FactoryGirl.create(:article)
        expect(article).to respond_to(:author)
      end

      it "should return the associated author" do
        article = FactoryGirl.create(:article)
        subject.articles.push article
        author = "#{subject[:last_name]}, #{subject[:first_name]}"
        expect(article.author).to eq(author)
      end

    end

end
