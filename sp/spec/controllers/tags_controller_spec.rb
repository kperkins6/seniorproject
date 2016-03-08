require 'rails_helper'

describe TagsController do
    render_views
    describe "index" do
      before do
        Tag.create!(text: 'Baked Potato w/ Cheese')
        Tag.create!(text: 'Garlic Mashed Potatoes')
        Tag.create!(text: 'Potatoes Au Gratin')
        Tag.create!(text: 'Baked Brussel Sprouts')

        xhr :get, :index, format: :json, keywords: keywords
      end

      subject(:results) { JSON.parse(response.body) }

      def extract_text
        ->(object) { object["text"] }
      end

      context "when the search finds results" do
        let(:keywords) { 'baked' }
        it 'should 200' do
          expect(response.status).to eq(200)
        end
        it 'should return two results' do
          expect(results.size).to eq(2)
        end
        it "should include 'Baked Potato w/ Cheese'" do
          expect(results.map(&extract_text)).to include('Baked Potato w/ Cheese')
        end
        it "should include 'Baked Brussel Sprouts'" do
          expect(results.map(&extract_text)).to include('Baked Brussel Sprouts')
        end
      end

      context "when the search doesn't find results" do
        let(:keywords) { 'foo' }
        it 'should return no results' do
          expect(results.size).to eq(0)
        end
      end

    end

  describe "show" do
    before do
      xhr :get, :show, format: :json, id: tag_id
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the tag exists" do
      let(:tag) { 
        Tag.create!(text: 'Baked Potato w/ Cheese', 
               hits: "20") 
      }
      let(:tag_id) { tag.id }

      it { expect(response.status).to eq(200) }
      it { expect(results["id"]).to eq(tag.id) }
      it { expect(results["text"]).to eq(tag.text) }
      it { expect(results["hits"]).to eq(tag.hits) }
    end

    context "when the tag doesn't exit" do
      let(:tag_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end
 
 describe "create" do
    before do
      xhr :post, :create, format: :json, tag: { text: "Toast", 
                                           hits: "7" }
    end
    it { expect(response.status).to eq(201) }
    it { expect(Tag.last.text).to eq("Toast") }
    it { expect(Tag.last.hits).to eq(7) }
  end

  describe "update" do
    let(:tag) { 
      Tag.create!(text: 'Baked Potato w/ Cheese', 
                     hits: "20") 
    }
    before do
      xhr :put, :update, format: :json, id: tag.id, tag: { text: "Toast", 
                                                 hits: "7" }
      tag.reload
    end
    it { expect(response.status).to eq(204) }
    it { expect(tag.text).to eq("Toast") }
    it { expect(tag.hits).to eq(7) }
  end

  describe "destroy" do
    let(:tag_id) { 
      Tag.create!(text: 'Baked Potato w/ Cheese', 
                     hits: "20").id
    }
    before do
      xhr :delete, :destroy, format: :json, id: tag_id
    end
    it { expect(response.status).to eq(204) }
    it { expect(Tag.find_by_id(tag_id)).to be_nil }
  end
 end
