chai = require 'chai'
WhoseNews = require '../src/node/node'
accelPartnersJSON = require './support/accelPartnersJSON'
theVergeJSON = require './support/theVergeJSON'

chai.should()
expect = chai.expect

describe "WhoseNews", ->
  describe "#corporations", ->
    corporations = WhoseNews.corporations
    it "Accel Partners is at top of list", ->
      corporations[0].name.should.eql "Accel Partners"
    describe "#get()", ->
      it "can get corporations by name", ->
        corporations.get("Accel Partners").should.equal corporations[0]
    describe "#withChildren()", ->
      it "creates a list with children", ->
        expect(corporations.withChildren().get("NBCUniversal")).to.exist
      it "keeps parents in the list", ->
        corporations.withChildren().get("Accel Partners").should.equal corporations[0]
      it "returns a corporation list", ->
        corporations.withChildren().corporationList.should.be.true
      describe "#withChildren()", ->
        it "returns itself", ->
          list = corporations.withChildren()
          list.withChildren().should.deep.equal list
    it "contains corporations", ->
      it "keeps parents in the list", ->
        corporations.get("Accel Partners").should.equal corporations[0]
      corporations[0].should.be.an.instanceOf WhoseNews.Corporation
      it "keeps parents in the list", ->
        corporations.get("Accel Partners").should.equal corporations[0]
    it "is marked as a corporationsList", ->
      corporations.corporationList.should.be.true
    describe "#brands()", ->
      brands = corporations.brands()
      it "exists", ->
        brands.should.exist
      it "has brands", ->
        brands[0].should.be.an.instanceOf WhoseNews.Brand
      describe "#get()", ->
        it "can get a brand by name", ->
          brands.get("Vox").url.should.eql "http://www.vox.com/"
      describe "#fromHostname()", ->
        it "can get a brand from hostname", ->
          brands.fromHostname("vox.com").should.eql brands.get("Vox")
  describe "Corporation", ->
    accelPartners = WhoseNews.corporations.get("Accel Partners")
    comcast = WhoseNews.corporations.get("Comcast Corporation")
    voxMedia = WhoseNews.corporations.get("Vox Media")
    it "can be converted to JSON", ->
      accelPartners.toJSON().should.eql accelPartnersJSON
    it "can be converted from JSON", ->
      accelPartners.should.eql WhoseNews.Corporation.fromJSON accelPartnersJSON
    it "has brands", ->
      voxMedia.brands.should.not.be.empty
    describe "#investors()", ->
      it "returns a non-empty list", ->
        voxMedia.investors(WhoseNews.corporations).should.not.be.empty
      it "returns a CorporationList", ->
        voxMedia.investors(WhoseNews.corporations).corporationList.should.be.true
      it "returns a list of Corporations", ->
        voxMedia.investors(WhoseNews.corporations)[0].should.be.an.instanceOf WhoseNews.Corporation
      describe "Vox Media", ->
        it "is invested in by NBCUniversal", ->
          voxMedia.investors(WhoseNews.corporations.withChildren()).get("NBCUniversal").should.exist
        it "is invested in by Accel Partners", ->
          voxMedia.investors(WhoseNews.corporations.withChildren()).get("Accel Partners").should.exist
    describe '#allBrands()', ->
      it "returns brands of children, even without brands of it's own", ->
        comcast.allBrands().should.not.be.empty
        expect(comcast.brands).not.to.exist
      it "returns brands of itself, without children", ->
        voxMedia.allBrands().should.not.be.empty
        voxMedia.brands.should.not.be.empty
  describe "Brand", ->
    brands = WhoseNews.corporations.brands()
    vox = brands.get "Vox"
    theVerge = brands.get "The Verge"
    it "can be converted to JSON", ->
      theVerge.toJSON().should.eql theVergeJSON
    it "can be converted from JSON", ->
      theVerge.toJSON().should.eql WhoseNews.Brand.fromJSON(theVergeJSON).toJSON()
