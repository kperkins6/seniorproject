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
 end
