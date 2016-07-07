chai = require 'chai'
WhoseNews = require '../src/node/node'
accelPartnersJSON = require './support/accelPartnersJSON'
theVergeJSON = require './support/theVergeJSON'

chai.should()
expect = chai.expect

describe "WhoseNews for Node", ->
  describe "#corporations", ->
    corporations = WhoseNews.corporations
    it "Accel Partners is at top of list", ->
      corporations[0].name.should.eql "Accel Partners"
    describe "#get()", ->
      it "can get corporations by name", ->
        corporations.get("Accel Partners").should.equal corporations[0]
    it "contains corporations", ->
      corporations[0].should.be.an.instanceOf WhoseNews.Corporation
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
